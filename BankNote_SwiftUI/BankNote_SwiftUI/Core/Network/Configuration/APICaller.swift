//
//  APICaller.swift
//  QSC
//
//  Created by FIT on 27/07/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation
import Combine

public class APICaller{
    private  var cancellable: AnyCancellable?
    
    private static let networkDelegateDispatchQueue = DispatchQueue(label: "com.cibc.mahfazty.networkDelegateQueue")

    public  init(){

    }
    private func getURLRequest(route:APITargetType) -> URLRequest {
        var request = URLRequest(url: route.baseURL)
        request.httpMethod = route.method.rawValue
        route.headers.forEach { (key: String, value: String) in
            request.setValue(value, forHTTPHeaderField: key)
        }

        return request
    }

    private func getURLSession() -> URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = APIConfiguration.shared.getTimeoutForRequest()

        let delegateQueue = OperationQueue()
        delegateQueue.maxConcurrentOperationCount = 1 // Serial queue
        delegateQueue.underlyingQueue = APICaller.networkDelegateDispatchQueue

//        let urlSession = URLSession(configuration: configuration, delegate: NetworkManagerSessionDelegate(), delegateQueue: delegateQueue)
        
        let urlSession = URLSession(configuration: configuration)
        
        return urlSession
    }

    private func getUrlSessionDataTask(route:APITargetType) async -> Result<URLSession.DataTaskPublisher,NetworkError>{

        var request = getURLRequest(route: route)
        let task = route.requestType
        print("\n\n----- API CALL: \(route.baseURL) -----\n\n")
        switch task {
        case .requestPlain:
            print("\n\n----- no request -----\n\n")
            break
        case .requestJsonEncodable(let encodable):
            let jsonDecoder = JSONEncoder()
            let jsonData:Data
            do{
                jsonData =  try jsonDecoder.encode(encodable)
             let    rawParams = String(data: jsonData,
                                   encoding: .utf8) ?? ""
                print("\n\n----- request rawParams for --\(route.baseURL)--: \(rawParams) -----\n\n")
            }catch{
                jsonData = Data()
                return  .failure( NetworkError.custom( error: error.localizedDescription))
            }

            request.httpBody = jsonData

        case .queryParamsEncodable(let encodable):
            // Add the encoded parameters to the URL
            var components = URLComponents(string: request.url!.absoluteString)!
            var    queryItems: [URLQueryItem] = []

            guard let requestData = try? JSONEncoder().encode(encodable) else{
                return   .failure(NetworkError.errorRequestParams(reason: "Failed on JSONEncoder "))
            }
            guard let jsonDictionary = try? JSONSerialization.jsonObject(with: requestData, options: []) as? [String: Any]else{
                return  .failure( NetworkError.errorRequestParams(reason: "Failed to convert jsonDictionary"))

            }
            // Iterate over key-value pairs
            for (label, value) in jsonDictionary {
                let queryItem = URLQueryItem(name: label, value:  "\(value)")
                queryItems.append(queryItem)
            }
            components.queryItems = queryItems
            print("\n\n----- query params: \(queryItems) -----\n\n")
            if let urlString = components.url?.absoluteString.stringByAddingPercentEncodingToData(), let url = URL(string:urlString){
                request.url = url
            }


        }

        let urlSession = getURLSession()
        return .success(urlSession.dataTaskPublisher(for: request))
    }

    public func requestApi(route:APITargetType,responseType:APITypeOfResponse,completion:@escaping(Result<APIResponseSuccessType, APIResponseErrorType>)->Void) async {
        let result = await getUrlSessionDataTask(route: route)
        switch result {
        case .success(let dataTask):
            self.cancellable =
            dataTask
                .receive(on: DispatchQueue.main)
                .tryMap({  data,response in
                    let httpStatusCode =  (response as? HTTPURLResponse)?.statusCode
                    DCDebuggerController().debugRequest(route: route, responseType: responseType, responseData: data, httpStatusCode: httpStatusCode)
                     return try self.handleResponse(route: route, responseType: responseType, data: data, response: response)
                 }
                )
                .mapError({   error in
                    if let error = error as? NetworkError{
                        return error
                    }else{
                        return NetworkError.custom(error: error.localizedDescription)
                    }
                })
                .eraseToAnyPublisher()
                .sink(receiveCompletion:
                        {  status  in

                            switch status {
                            case .finished:
                                break
                            case .failure(let failure):

                                DCDebuggerController().debugError(route: route, error: failure)
                                switch failure{
                                case .invalidHttpResponse:
                                    let error = APIResponseErrorType.onFailureNetwork(.invalidHttpResponse)
                                    completion(.failure(error))

                                default:
                                    completion(.failure(.onFailureNetwork(failure)))
                                }
                            }

                        }, receiveValue:  { result in
                            switch result{
                            case .onSuccess:
                                completion(.success(.onSuccess))
                            case .onSuccessModel(let model):
                                completion(.success(.onSuccessModel(model)))
                            case.onFailureModel(let model,let httpStatusCode,let message):
                                completion(.success(.onFailureModel(model: model, httpStatusCode: httpStatusCode, message: message)))
                            }
                        })

        case .failure(let failure):
            completion(.failure(.onFailureNetwork(failure)))

        }

    }



    private  func handleResponse(route:APITargetType,  responseType:APITypeOfResponse,data: Data, response: URLResponse) throws -> APIResponseSuccessType {

        guard let statusCode:Int = (response as? HTTPURLResponse)?.statusCode else {
             
            throw NetworkError.invalidHttpResponse
        }

        let allow =    switch statusCode{
        case 200...299:
            true

        case 401:
            SessionManager.shared.UsersLogOffAPI(success: true)
            throw NetworkError.unAuthenticated
            
        case 403:
            throw NetworkError.forbidden

//        case 404:
//            SessionManager.shared.UsersLogOffAPI(success: true)
//            throw NetworkError.unAuthenticated
            
        case 408:
            SessionManager.shared.UsersLogOffAPI(success: true)
            throw NetworkError.unAuthenticated
            
        default:
            route.allowsHttpStatusCode.contains( statusCode)
        }

        guard allow  else{
            let error = NetworkError.invalidHttpResponse
//            print( "statusCode \(statusCode)")
            return try checkErrorResponse(error: error, route: route, responseType: responseType, data: data, statusCode: statusCode)
             }

            switch responseType {
            case .responsePlain:
                return APIResponseSuccessType.onSuccess
            case .responseData(let type):
                return try checkSuccessResponse(route: route, responseType: responseType, data: data, statusCode: statusCode, type: type)
            }

    }

    private func checkSuccessResponse(route:APITargetType,  responseType:APITypeOfResponse,data: Data,statusCode:Int,type:Decodable.Type) throws -> APIResponseSuccessType {
        do {
            let model = try  decodeDataResponse( responseType: type, data: data)
            return .onSuccessModel(model)
        }
        catch(let error) {
            return try checkErrorResponse(error: error, route: route, responseType: responseType, data: data,statusCode: statusCode)
        }
    }

    private func checkErrorResponse(error:any Error,route:APITargetType,  responseType:APITypeOfResponse,data: Data,statusCode: Int)throws -> APIResponseSuccessType {
        do {
             let model = try?  decodeDataResponse( responseType: route.failureType, data: data)
            if model != nil{
                return .onFailureModel(model: model, httpStatusCode: statusCode, message: String(data: data, encoding: .utf8) ?? "")
            }else{
                throw error
            }
        }catch(let error){
            throw error
        }
    }

    func decodeDataResponse(  responseType:any Decodable.Type,data: Data)  throws -> Decodable{
        do {
            let model =  try JSONDecoder().decode(responseType, from: data)
            return model
        }catch{
            throw NetworkError.jsonParser(reason:  "\(error)")

        }
    }
}


class NetworkManagerSessionDelegate:NSObject, URLSessionDelegate, URLSessionTaskDelegate {

    func urlSession(_ session: URLSession, task: URLSessionTask, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        let publicKeys: [String]? =
        [
            "i7wTqTvh00ioIruIfFR4kMPnBqrS2rdivp1/s2uC/CY=",
            "WI&MFY+9zijGG8QgEHCAK5fhA+ydPZxaLQOFdiEPz3U=",
            "EfFQLjZWxamoR5XMuj@qhWvz/B0wnP1P691eGWtbse0="
        ]
        
        if let publicKeys = publicKeys {
            let pinningManager = PinningManager(pinnedKeyHashes: publicKeys)
            pinningManager.validate(challenge: challenge, completionHandler: completionHandler)
        }else{
            completionHandler(.performDefaultHandling, nil)
        }
    }
}
