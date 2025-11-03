//
//  DebuggerController.swift
//  QSC
//
//  Created by FIT on 27/07/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation
import Foundation
class
DCDebuggerController{
    func debugError(route:APITargetType,error:NetworkError){
#if DEBUG
        var urlString:String = route.baseURL.absoluteString
        let errorMSg:String
        switch error {
        case .jsonParser(let error):
            errorMSg = error
        default:
            errorMSg = ""

        }
//        print("\n\n*********Error API*********")
//        print("on:\n \(urlString)\n \(error) \n\(errorMSg)")
//        print("\n\n*********FINISH Error API*********")
#endif

    }

    func debugRequest(route:APITargetType,responseType:APITypeOfResponse,responseData:Data,httpStatusCode:Int?){
#if DEBUG
        var urlString:String = route.baseURL.absoluteString
        let slashString = "\\"
        let header = route.headers
        var typeHttpBody = ""
        var httpBodyJson:String? = nil
        let task = route.requestType

        switch task {
        case .requestPlain:
            break
        case .requestJsonEncodable(let encodable):
            typeHttpBody =  "--data '"

            let jsonDecoder = JSONEncoder()
            let jsonData:Data
            do{
                jsonData =  try jsonDecoder.encode(encodable)
            }catch{
                jsonData = Data()
            }




        case .queryParamsEncodable(let encodable):
            var components = URLComponents(string: urlString)!
            var    queryItems: [URLQueryItem] = []
            guard let requestData = try? JSONEncoder().encode(encodable) else{return}
            guard let jsonDictionary = try? JSONSerialization.jsonObject(with: requestData, options: []) as? [String: Any]else{
                print("Error converting to dictionary on debug controller \n")
                return}
            for (label, value) in jsonDictionary {
                let queryItem = URLQueryItem(name: label, value:  "\(value)")
                queryItems.append(queryItem)
            }
            components.queryItems = queryItems

            if let newUrlString = components.url?.absoluteString.stringByAddingPercentEncodingToData() {
                urlString = newUrlString
            }


        }


        var curlString:String = ""
        curlString += "curl --location '\(urlString)' \(slashString)\n"
        for (key,value) in header{
            curlString += "--header '\(key): \(value)' \(slashString)"
        }

        if let httpBodyJson = httpBodyJson{
            curlString += typeHttpBody
            curlString += "\(httpBodyJson)"
            curlString += "'"
        }
        var statusCode = "INVALID HTTP RESPONSE"
        if let httpStatusCode = httpStatusCode{
            statusCode = "\(httpStatusCode)"
        }

        if route.printRequest || route.printResponse{
//            print("\n\n*********CALL API*********")
        }

        if route.printRequest{

//            print("REQUEST HTTP STATUS CODE(\(statusCode)):\n \(curlString)\n")
        }
        if route.printResponse{
            var responseString:String =  String(data: responseData, encoding: .utf8) ?? ""
             responseString = String(data: responseData, encoding: .utf8) ?? ""
                print("\n\n----- RESPONSE FOR --\(route.baseURL)--:\n\(responseString as AnyObject) -----\n\n")
        }
        if route.printRequest || route.printResponse{
            print("\n\n*********FINISH API*********")
        }

        #endif
    }



}



