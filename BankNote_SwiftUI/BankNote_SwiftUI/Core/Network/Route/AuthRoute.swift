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
    
    // Valify
    case SendPhoneOtpValify(requestModel: SendPhoneOtpValifyRequestModel)
    case VerifyPhoneOtpValify(requestModel: VerifyPhoneOtpValifyRequestModel)
    case SendEmailOtpValify(requestModel: SendEmailOtpValifyRequestModel)
    case VerifyEmailOtpValify(requestModel: VerifyEmailOtpValifyRequestModel)
    case GetFrontBackValify(requestModel: GetFrontBackValifiyRequestModel)
    
    var baseURL: URL{
        get{
            return URL(string: AppEnvironmentController.currentNetworkConfiguration.basePath
                       + path)!
        }
    }
    
    var headers: [String : String]{
        get{
            switch self {
            case .SendPhoneOtpValify:
                var dicHeader = NetworkUtility.getHeader(.token)
                dicHeader["access-token"] = "344553443"
                return dicHeader

            case .VerifyPhoneOtpValify:
                var dicHeader = NetworkUtility.getHeader(.token)
                dicHeader["access-token"] = "344553443"
                return dicHeader

            case .SendEmailOtpValify:
                var dicHeader = NetworkUtility.getHeader(.token)
                dicHeader["access-token"] = "344553443"
                return dicHeader

            case .VerifyEmailOtpValify:
                var dicHeader = NetworkUtility.getHeader(.token)
                dicHeader["access-token"] = "344553443"
                return dicHeader

            case .GetFrontBackValify:
                var dicHeader = NetworkUtility.getHeader(.token)
                dicHeader["access-token"] = "344553443"
                return dicHeader

                
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
        case .SendPhoneOtpValify:
            return "KYCWServices/SendPhoneOtpValify"
        case .VerifyPhoneOtpValify:
            return "KYCWServices/VerifyPhoneOtpValify"
        case .SendEmailOtpValify:
            return "KYCWServices/SendEmailOtpValify"
        case .VerifyEmailOtpValify:
            return "KYCWServices/VerifyEmailOtpValify"
        case .GetFrontBackValify:
            return "KYCWServices/GetFrontBackVilify"
        }
    }
    
    var method: APIMethodType{
        get{
            switch self {
            case .login, .OTP, .SendPhoneOtpValify, .VerifyPhoneOtpValify, .SendEmailOtpValify, .VerifyEmailOtpValify, .GetFrontBackValify:
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
        case .SendPhoneOtpValify(let requestModel):
                .requestJsonEncodable(requestModel)
        case .VerifyPhoneOtpValify(let requestModel):
                .requestJsonEncodable(requestModel)
        case .SendEmailOtpValify(let requestModel):
                .requestJsonEncodable(requestModel)
        case .VerifyEmailOtpValify(let requestModel):
                .requestJsonEncodable(requestModel)
        case .GetFrontBackValify(let requestModel):
                .requestJsonEncodable(requestModel)
        }
    }}
