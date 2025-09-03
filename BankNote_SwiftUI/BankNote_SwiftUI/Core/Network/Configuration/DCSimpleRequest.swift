//
//  RequestApi.swift
//  QSC
//
//  Created by FIT on 27/07/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation
public class DCSimpleRequest{
    public  init(){

    }

    public func callAPI<T:Decodable>(route:APITargetType,type:T.Type = EmptyResponseModel.self,complete:@escaping((Result<APIResultSuccessType<T>,APIResponseErrorType>)->Void)){
        Task{
            let request = APICaller()
            var   responseType = APITypeOfResponse.responseData(type)
            if  type == EmptyResponseModel.self{
                responseType = APITypeOfResponse.responsePlain
            }

            await request.requestApi(route: route, responseType: responseType) { result in
                switch result {
                case .success(let success):
                    switch success {
                    case .onSuccess:
                        complete(.success(.onSuccess))
                    case .onSuccessModel(let decodable):
                       if let model = decodable as?  T {
                            complete(.success(.onSuccessModel(model)))
                        }else{
                            complete(.failure(.onFailureModel(model: decodable, httpStatusCode: 0, message: "ERROR USING !!")))
                        }
                    case .onFailureModel(let model, let httpStatusCode, let message):
                        complete(.failure(.onFailureModel(model: model, httpStatusCode: httpStatusCode, message: message)))
                    }
                case .failure(let failure):
                    complete(.failure(failure))
                }
            }
        }
    }

}
