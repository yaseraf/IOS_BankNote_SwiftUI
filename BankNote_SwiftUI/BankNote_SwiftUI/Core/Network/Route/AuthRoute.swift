//
//  AuthRoute.swift
//  QSC
//
//  Created by FIT on 27/07/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation
enum AuthRoute:APITargetType{
    
    case urlIPAddress(requestModel: String)
    case login(requestModel: LoginRequestModel )
    case OTP(requestModel: OTPRequestModel )
    case GetDeviceConfigs(requestModel: GetDeviceConfigsRequestModel)
    case GetKYCCibc(requestModel: GetKYCCibcRequestModel)
    
    // MARK: Valify
    case SendPhoneOtpValify(requestModel: SendPhoneOtpValifyRequestModel)
    case VerifyPhoneOtpValify(requestModel: VerifyPhoneOtpValifyRequestModel)
    case RegistrationStatusValify(requestModel: RegistrationStatusValifyRequestModel)
    case SendEmailOtpValify(requestModel: SendEmailOtpValifyRequestModel)
    case VerifyEmailOtpValify(requestModel: VerifyEmailOtpValifyRequestModel)
    case GetFrontBackValify(requestModel: GetFrontBackValifiyRequestModel)
    case GetValifyData(requestModel: GetValifyDataRequestModel)
    
    // Register
    case RegisterValify(requestModel: RegisterValifyRequestModel)
    case GetQuestionsValify(requestModel: GetQuestionsValifyRequestModel)
    case SetAnswerValify(requestModel: SetAnswerValifyRequestModel)
    case SetPasswordValify(requestModel: SetPasswordValifyRequestModel)
    
    // Login
    case LoginValify(requestModel: LoginValifyRequestModel)
    case ResetPasswordValify(requestModel: ResetPasswordValifyRequestModel)
    case CsoValify(requestModel: CsoValifyRequestModel)
    case NtraValify(requestModel: NtraValifyRequestModel)
    
    // Contracts
    case GetKYCFieldValify(requestModel: GetKycFieldValifyRequestModel)
    case GetKYCContractValify(requestModel: GetKycContractValifyRequestModel)
    case GetContractValify(requestModel: GetContractValifyRequestModel)
    
    var baseURL: URL{
        get{
            switch self {
                case .urlIPAddress:
                    return URL(string: "https://httpbin.org/ip")!

                default:
                    return URL(string: AppEnvironmentController.currentNetworkConfiguration.basePath + path)!
            }
        }
    }
    
    var headers: [String : String]{
        get{
            switch self {
            case .GetKYCCibc:
                var dicHeader = NetworkUtility.getHeader(.token)
                dicHeader["access-token"] = KeyChainController().loginAccessToken
                return dicHeader
//            case .SendPhoneOtpValify:
//                var dicHeader = NetworkUtility.getHeader(.token)
//                dicHeader["access-token"] = "344553443"
//                return dicHeader

            case .VerifyPhoneOtpValify:
                var dicHeader = NetworkUtility.getHeader(.token)
                dicHeader["access-token"] = KeyChainController().loginAccessToken
                return dicHeader
                
            case .RegistrationStatusValify:
                var dicHeader = NetworkUtility.getHeader(.token)
                dicHeader["access-token"] = KeyChainController().loginAccessToken
                return dicHeader

            case .SendEmailOtpValify:
                var dicHeader = NetworkUtility.getHeader(.token)
                dicHeader["access-token"] = KeyChainController().loginAccessToken
                return dicHeader

            case .VerifyEmailOtpValify:
                var dicHeader = NetworkUtility.getHeader(.token)
                dicHeader["access-token"] = KeyChainController().loginAccessToken
                return dicHeader

            case .GetFrontBackValify:
                var dicHeader = NetworkUtility.getHeader(.token)
                dicHeader["access-token"] = KeyChainController().loginAccessToken
                return dicHeader
                
            case .GetValifyData:
                var dicHeader = NetworkUtility.getHeader(.token)
                dicHeader["access-token"] = KeyChainController().loginAccessToken
                return dicHeader
                
            case .RegisterValify:
                var dicHeader = NetworkUtility.getHeader(.token)
                dicHeader["access-token"] = KeyChainController().loginAccessToken
                return dicHeader

            case .GetQuestionsValify:
                var dicHeader = NetworkUtility.getHeader(.token)
                dicHeader["access-token"] = KeyChainController().loginAccessToken
                return dicHeader

            case .SetAnswerValify:
                var dicHeader = NetworkUtility.getHeader(.token)
                dicHeader["access-token"] = KeyChainController().loginAccessToken
                return dicHeader

            case .SetPasswordValify:
                var dicHeader = NetworkUtility.getHeader(.token)
                dicHeader["access-token"] = KeyChainController().loginAccessToken
                return dicHeader

            case .LoginValify:
                var dicHeader = NetworkUtility.getHeader(.token)
                dicHeader["access-token"] = KeyChainController().loginAccessToken
                return dicHeader

            case .ResetPasswordValify:
                var dicHeader = NetworkUtility.getHeader(.token)
                dicHeader["access-token"] = KeyChainController().loginAccessToken
                return dicHeader

            case .CsoValify:
                var dicHeader = NetworkUtility.getHeader(.token)
                dicHeader["access-token"] = KeyChainController().loginAccessToken
                return dicHeader

            case .NtraValify:
                var dicHeader = NetworkUtility.getHeader(.token)
                dicHeader["access-token"] = KeyChainController().loginAccessToken
                return dicHeader
                
            case .GetKYCFieldValify:
                var dicHeader = NetworkUtility.getHeader(.token)
                dicHeader["access-token"] = KeyChainController().loginAccessToken
                return dicHeader

            case .GetKYCContractValify:
                var dicHeader = NetworkUtility.getHeader(.token)
                dicHeader["access-token"] = KeyChainController().loginAccessToken
                return dicHeader

            case .GetContractValify:
                var dicHeader = NetworkUtility.getHeader(.token)
                dicHeader["access-token"] = KeyChainController().loginAccessToken
                return dicHeader

                
            default:
                return  NetworkUtility.getHeader(.withoutToken)
            }
        }
    }

    var path: String{
        switch self {
        case .urlIPAddress:
            return ""
        case .login:
            return "GeneralWServices/UsrAuthinticationByEmailAndMobile"
        case .OTP:
           return  "GeneralWServices/RegistrationsOTPByEmailAndMobile"
        case .GetDeviceConfigs:
            return "GeneralWServices/GetDeviceConfigs"
        case .GetKYCCibc:
            return "KYCWServices/GetKYCCibc"
        case .SendPhoneOtpValify:
            return "KYCWServices/SendPhoneOtpValify"
        case .VerifyPhoneOtpValify:
            return "KYCWServices/VerifyPhoneOtpValify"
        case .RegistrationStatusValify:
            return "KYCWServices/RegistrationStatusValify"
        case .SendEmailOtpValify:
            return "KYCWServices/SendEmailOtpValify"
        case .VerifyEmailOtpValify:
            return "KYCWServices/VerifyEmailOtpValify"
        case .GetFrontBackValify:
            return "KYCWServices/GetFrontBackVilify"
        case .GetValifyData:
            return "KYCWServices/GetValifyData"
        case .RegisterValify:
            return "KYCWServices/RegisterValify"
        case .GetQuestionsValify:
            return "KYCWServices/GetQuestionsValify"
        case .SetAnswerValify:
            return "KYCWServices/SetAnswerValify"
        case .SetPasswordValify:
            return "KYCWServices/SetPasswordValify"
        case .LoginValify:
            return "KYCWServices/LoginValify"
        case .ResetPasswordValify:
            return "KYCWServices/ResetPasswordValify"
        case .CsoValify:
            return "KYCWServices/CsoValify"
        case .NtraValify:
            return "KYCWServices/NtraValify"
        case .GetKYCFieldValify:
            return "KYCWServices/GetKycFiledValify"
        case .GetKYCContractValify:
            return "KYCWServices/GetKycContractValify"
        case .GetContractValify:
            return "KYCWServices/GetContractValify"

        }
    }
    
    var method: APIMethodType{
        get{
            switch self {
            case .login, .OTP, .GetKYCCibc, .SendPhoneOtpValify, .VerifyPhoneOtpValify, .RegistrationStatusValify, .SendEmailOtpValify, .VerifyEmailOtpValify, .GetFrontBackValify, .GetValifyData, .RegisterValify, .GetQuestionsValify, .SetAnswerValify, .SetPasswordValify, .LoginValify, .ResetPasswordValify, .CsoValify, .NtraValify, .GetKYCFieldValify, .GetKYCContractValify, .GetContractValify:
                return .post
            case .GetDeviceConfigs, .urlIPAddress:
                return .get
            }
        }
    }

    var requestType: APITypeOfRequest{
        switch self {
        case .urlIPAddress:
                .requestPlain
        case .login( let RequestModel):
                .requestJsonEncodable(RequestModel)
        case .OTP(requestModel: let requestModel):
                .requestJsonEncodable(requestModel)
        case .GetDeviceConfigs:
                .requestPlain
        case .GetKYCCibc(let requestModel):
                .requestJsonEncodable(requestModel)
        case .SendPhoneOtpValify(let requestModel):
                .requestJsonEncodable(requestModel)
        case .VerifyPhoneOtpValify(let requestModel):
                .requestJsonEncodable(requestModel)
        case .RegistrationStatusValify(let requestModel):
                .requestJsonEncodable(requestModel)
        case .SendEmailOtpValify(let requestModel):
                .requestJsonEncodable(requestModel)
        case .VerifyEmailOtpValify(let requestModel):
                .requestJsonEncodable(requestModel)
        case .GetFrontBackValify(let requestModel):
                .requestJsonEncodable(requestModel)
        case .GetValifyData(let requestModel):
                .requestJsonEncodable(requestModel)
        case .RegisterValify(let requestModel):
                .requestJsonEncodable(requestModel)
        case .GetQuestionsValify(let requestModel):
                .requestJsonEncodable(requestModel)
        case .SetAnswerValify(let requestModel):
                .requestJsonEncodable(requestModel)
        case .SetPasswordValify(let requestModel):
                .requestJsonEncodable(requestModel)
        case .LoginValify(let requestModel):
                .requestJsonEncodable(requestModel)
        case .ResetPasswordValify(let requestModel):
                .requestJsonEncodable(requestModel)
        case .CsoValify(let requestModel):
                .requestJsonEncodable(requestModel)
        case .NtraValify(let requestModel):
                .requestJsonEncodable(requestModel)
        case .GetKYCFieldValify(let requestModel):
                .requestJsonEncodable(requestModel)
        case .GetKYCContractValify(let requestModel):
                .requestJsonEncodable(requestModel)
        case .GetContractValify(let requestModel):
                .requestJsonEncodable(requestModel)
        }
    }}
