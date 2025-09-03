//
//  RequestApi.swift
//  QSC
//
//  Created by FIT on 27/07/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation

class TokenRefreshConstants{
    static var isFinishCalling = true
}

struct RequestApi<U:Decodable>{

    private let route:APITargetType
    private let responseType:U.Type
    private let completion:(Result<U,NetworkError>)->Void?
     init(  route: APITargetType, responseType: U.Type = EmptyResponseModel.self, completion: @escaping (Result<U, NetworkError>) -> Void? ) {
        self.route = route
        self.responseType = responseType
        self.completion = completion
    }

    func repeatRequest() {
        Task{
            await requestApi()
        }
    }

    func requestApi() async{

        DCSimpleRequest().callAPI(route: route, type: responseType,complete: { [ self] result in
            switch result {
            case .success(let success):
                switch success{
                case .onSuccess:
                    do {
                        guard let jsonData =  "{}".data(using: .utf8) else{
                            self.completion(.failure(.custom(error: "Error using DCEmptyResponseModel")))
                            return
                        }

                        let decoder = JSONDecoder()
                        let decodedObject = try decoder.decode(responseType, from: jsonData )
                        self.completion(.success(decodedObject))
                    } catch {
                        print("error:\(error)")
                        self.completion(.failure(.custom(error: "Error using DCEmptyResponseModel on decode")))
                    }

                case .onSuccessModel(let model):
                    self.saveTokenIfNeed(self.route, model)
                    self.completion(.success(model))
                }

             case .failure(let failure):
                self.handleHttpResponseErrorCode( failure,onError: {
                   networkError in
                    self.completion(.failure(networkError))

                })

            }
        })
    }
//    MARK: Handel failure API
 private func handleHttpResponseErrorCode(_ type:APIResponseErrorType,onError:@escaping((NetworkError)->Void)) {

//
     
        switch type {

        case .onFailureNetwork(let networkError):
            onError(networkError)

        case .onFailureModel(let model, let httpStatusCode, let message):
            if let model = model as? NetworkErrorModel {
                onError(NetworkError.custom(error: model.message ))
            }else{
                onError(NetworkError.custom( error: message))

            }

        }

    }


    //    MARK: Save token if response same as login response or the refresh token response and
    private func saveTokenIfNeed(_ route:APITargetType,_ model:Decodable) {

    }


}

