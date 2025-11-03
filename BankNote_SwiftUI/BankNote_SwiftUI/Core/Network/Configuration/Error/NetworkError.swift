//
//  NetworkError.swift
//  QSC
//
//  Created by FIT on 27/07/2024.
//  Copyright © 2024 FIT. All rights reserved.
//


import Foundation
public enum NetworkError:LocalizedError{
    public enum InvalidHttpResponse:Swift.Error{
        case unAuthenticated
        case forbidden
        case custom(Int)
    }

    
    case jsonParser(reason:String = "")
    case invalidHttpResponse
    case custom(error:String)
    case unAuthenticated
    case forbidden
    case noInternetConnection
    case errorRequestParams(reason:String)
    case none

    var text:String{
        switch self {
        case .errorRequestParams(let reason):
            return "API Error response with \(reason)"

        case .jsonParser(let reason):
            return "API Error response with \(reason)"

        case .invalidHttpResponse:
            return "invalid http response"
        case .custom(let error):
            return error

        case .unAuthenticated:
            return "Unauthorised access. Please log in to continue. (HTTP 401)"
        case .forbidden:
            return "Access denied. You do not have permission to view this resource. (HTTP 403)"

        case .noInternetConnection:
           return "Unable to connect to the internet. Please check your connection and try again."
        case .none:
            return ""
        }
    }
}
