//
//  AuthRoute.swift
//  QSC
//
//  Created by FIT on 27/07/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation
enum AuthRoute:APITargetType{
    
    case login(requestModel: LoginRequestModel )
    case OTP(requestModel: OTPRequestModel )
    case GetDeviceConfigs(requestModel: GetDeviceConfigsRequestModel)
    
    var baseURL: URL{
        get{
            return URL(string: AppEnvironmentController.currentNetworkConfiguration.basePath
                       + path)!
        }
    }
    
    var headers: [String : String]{
        get{
            switch self {
                default:
                    return  NetworkUtility.getHeader(.withoutToken)
            }
        }
    }

    var path: String{
        switch self {
        case .login:
            return "GeneralWServices/UsrAuthinticationByEmailAndMobile"
        case .OTP:
           return  "GeneralWServices/RegistrationsOTPByEmailAndMobile"
        case .GetDeviceConfigs:
            return "GeneralWServices/GetDeviceConfigs"
        }
    }
    
    var method: APIMethodType{
        get{
            switch self {
            case .login :
                return .post
            case .OTP:
                return .post
            case .GetDeviceConfigs:
                return .get
            }
        }
    }

    var requestType: APITypeOfRequest{
        switch self {
        case .login( let RequestModel):
                .requestJsonEncodable(RequestModel)
        case .OTP(requestModel: let requestModel):
                .requestJsonEncodable(requestModel)
        case .GetDeviceConfigs:
                .requestPlain
        }
    }}
