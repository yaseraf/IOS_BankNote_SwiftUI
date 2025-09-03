//
//  APIResultType.swift
//  QSC
//
//  Created by FIT on 27/07/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation
enum APIResultType<T>{
    case onLoading(show:Bool)
    case onFailure(error:NetworkError)
    case onSuccess(response:T)
}

struct NetworkErrorModel:Decodable{
    var message:String
}


public struct EmptyResponseModel:Decodable{}

public enum APIResponseType{
    case onSuccessModel(Decodable)
    case onFailureModel(model:Decodable?,httpStatusCode:Int,message:String)
    case onSuccess

}

