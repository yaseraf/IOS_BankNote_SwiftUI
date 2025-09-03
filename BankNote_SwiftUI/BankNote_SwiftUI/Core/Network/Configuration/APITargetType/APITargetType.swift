//
//  APITargetType.swift
//  QSC
//
//  Created by FIT on 27/07/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation
public protocol APITargetType{
    var baseURL:URL{get}
    var path:String{get}
    var method:APIMethodType{get}
    var headers:[String:String]{get}
    var requestType:APITypeOfRequest{get}
    var allowsHttpStatusCode:[Int]{get}
    var failureType:Decodable.Type{get}
    var printRequest:Bool{get}
    var printResponse:Bool{get}
}

extension APITargetType{
    var printRequest:Bool{
        return false
    }

    var failureType: Decodable.Type{
        return NetworkErrorModel.self
    }

    var printResponse:Bool{
        return true
    }

    var allowsHttpStatusCode:[Int] {
        return []
    }

    
    var headers: [String : String] {
        return getDefaultHeader()
    }

    private func getDefaultHeader( ) ->  [String : String] {
        var headerDic = [String : String]()
        headerDic["Accepts"] = "*/*"
        headerDic["Content-Type"] = "application/json"
        return headerDic
    }
}
