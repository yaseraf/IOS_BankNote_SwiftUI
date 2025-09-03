//
//  NetworkEnum.swift
//  QSC
//
//  Created by FIT on 27/07/2024.
//  Copyright © 2024 FIT. All rights reserved.
//


import Foundation
public enum APIMethodType:String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

public enum APITypeOfRequest {
    case requestPlain
    case requestJsonEncodable(Encodable)
    case queryParamsEncodable(Encodable)
}

public enum APIResponseSuccessType{
    case onSuccess
    case onSuccessModel(Decodable)
    case onFailureModel(model:Decodable?,httpStatusCode:Int,message:String)
}

public enum APIResponseErrorType:Swift.Error{
    case onFailureNetwork(NetworkError)
    case onFailureModel(model:Decodable?,httpStatusCode:Int,message:String)

}

public enum APIResultSuccessType<T:Decodable>{
    case onSuccess
    case onSuccessModel(T)
}



public enum APITypeOfResponse {
    case responsePlain
    case responseData(Decodable.Type)
}
