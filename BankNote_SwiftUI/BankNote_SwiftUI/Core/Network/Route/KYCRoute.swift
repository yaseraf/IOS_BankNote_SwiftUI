//
//  AuthRoute.swift
//  QSC
//
//  Created by FIT on 27/07/2024.
//  Copyright © 2024 FIT. All rights reserved.
//


import Foundation

enum KYCRoute :APITargetType{

    case CheckEmailOrPhoneExistence(requestModel: CheckEmailOrPhoneExistenceRequestModel)
    case GetAccessToken(requestModel: GetAccessTokenRequestModel)
    case StepVerifyPhone(requestModel: StepVerifyPhoneRequestModel)
    case VerifyPhoneOtp(requestModel: VerifyPhoneOtpRequestModel)
    case StepVerifyEmail(requestModel: StepVerifyEmailRequestModel)
    case VerifyEmailWithOtp(requestModel: VerifyEmailWithOtpRequestModel)
    case StepCreate(requestModel: StepCreateRequestModel)
    case VerifyIDFrontVlens(requestModel: VerifyIDFrontVlensRequestModel)
    case VerifyIDBack(requestModel: VerifyIDBackRequestModel)
    case VerifyLiveness(requestModel: VerifyLivenessRequestModel)
    case GetKYCCibc(requestModel: GetKYCCibcRequestModel)
    case GetSourceOfIncome(requestModel: GetSourceOfIncomeRequestModel)
    case GetInvestObjective(requestModel: GetInvestObjectiveRequestModel)
    case GetNationality(requestModel: GetNationalityRequestModel)
    case InsertAttachments(requestModel: InsertAttachmentsRequestModel)

    case loginVlens(requestModel: LoginVlensRequestModel)
    
    case GetAllRequestTypes(requestModel: GetAllRequestTypesRequestModel)
    case CreateBusinessRequest(requestModel: CreateBusinessRequestRequestModel)
    case getCurrentListIds(requestModel: GetCurrentListIdsRequestModel)
    case LoginAdmin(requestModel: LoginAdminRequestModel)
    case ApproveOrRejectRequest(requestModel: ApproveOrRejectRequestRequestModel)
    case GetCurrentBusinessRequestList(requestModel: GetCurrentBusinessRequestListRequestModel)
    case ActivateBusinessRequest(requestModel: ActivateBusinessRequestRequestModel)
    case ValidateOtpBusinessRequest(requestModel: ValidateOtpBusinessRequestRequestModel)
    
    //https://restful-api.dev/
    
    var baseURL: URL{
        get{
            return URL(string: AppEnvironmentController.currentNetworkConfiguration.basePath
                        + path)!
        }
    }

    var headers: [String : String]{
        get{
            switch self {
            case .StepVerifyPhone:
                var dicHeader = NetworkUtility.getHeader(.token)
                dicHeader["access-token"] = KeyChainController().accessToken
                return dicHeader
                
            case .StepVerifyEmail, .VerifyEmailWithOtp, .StepCreate, .GetNationality, .InsertAttachments:
                var dicHeader = NetworkUtility.getHeader(.token)
                dicHeader["access-token"] = KeyChainController().verifyPhoneOtpAccessToken
                return dicHeader
                
            case .VerifyIDFrontVlens, .VerifyIDBack, .VerifyLiveness, .GetKYCCibc, .GetSourceOfIncome, .GetInvestObjective:
                var dicHeader = NetworkUtility.getHeader(.token)
                dicHeader["access-token"] = KeyChainController().loginVlensAccessToken?.isEmpty == false ? KeyChainController().loginVlensAccessToken : KeyChainController().verifyPhoneOtpAccessToken
                return dicHeader
                
            case .GetAllRequestTypes, .CreateBusinessRequest, .LoginAdmin, .ApproveOrRejectRequest, .GetCurrentBusinessRequestList, .ActivateBusinessRequest, .ValidateOtpBusinessRequest, .getCurrentListIds:
                var dicHeader = NetworkUtility.getHeader(.token)
                dicHeader["access-token"] = KeyChainController().stepCreateAccessToken
                return dicHeader
                
            default:
                return  NetworkUtility.getHeader(.withoutToken)

            }
        }
    }
    
    func getCurrentDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ddMMyyyyHHmmss"
        let currentDate = Date()
        let dateString = dateFormatter.string(from: currentDate)
        return dateString
    }

    var path: String{
        switch self {
        case .CheckEmailOrPhoneExistence:
            return "KYCWServices/CheckEmailOrPhoneExistence"
        case .GetAccessToken:
            return "IntegrationWServices/GetAccessToken"
        case .StepVerifyPhone:
            return "KYCWServices/StepVerifyPhone"
        case .VerifyPhoneOtp:
            return "KYCWServices/VerifyPhoneOtp"
        case .StepVerifyEmail:
            return "KYCWServices/StepVerifyEmail"
        case .VerifyEmailWithOtp:
            return "KYCWServices/VerifyEmailWithOtp"
        case .StepCreate:
            return "KYCWServices/StepCreate"
        case .VerifyIDFrontVlens:
            return "KYCWServices/VerifyIDFrontVlens"
        case .VerifyIDBack:
            return "KYCWServices/VerifyIDBack"
        case .VerifyLiveness:
            return "KYCWServices/VerifyLiveness"
        case .GetKYCCibc:
            return "KYCWServices/GetKYCCibc"
        case .GetSourceOfIncome:
            return "KYCWServices/GetSourceOfIncome"
        case .GetInvestObjective:
            return "KYCWServices/GetInvesObjective"
        case .GetNationality:
            return "KYCWServices/Getnationality"
        case .InsertAttachments:
            return "KYCWServices/InsertAttachments"
        case .loginVlens:
            return "KYCWServices/LoginVlens"
        case .GetAllRequestTypes:
            return "KYCWServices/GetAllRequestTypes"
        case .CreateBusinessRequest:
            return "KYCWServices/CreateBusinessRequest"
        case .getCurrentListIds:
            return "KYCWServices/GetCurrentListIds"
        case .LoginAdmin:
            return "KYCWServices/LoginAdmin"
        case .ApproveOrRejectRequest:
            return "KYCWServices/ApproveOrRejectRequest"
        case .GetCurrentBusinessRequestList:
            return "KYCWServices/GetCurrentBusinessRequest"
        case .ActivateBusinessRequest:
            return "KYCWServices/ActivateBusinessRequest"
        case .ValidateOtpBusinessRequest:
            return "KYCWServices/ValidateOtpBusinessRequest"
        }
    }
    
    var method: APIMethodType{
        get{
            switch self {
                case .CheckEmailOrPhoneExistence, .GetAccessToken, .StepVerifyPhone, .VerifyPhoneOtp, .StepVerifyEmail, .VerifyEmailWithOtp, .StepCreate, .VerifyIDFrontVlens, .VerifyIDBack, .VerifyLiveness, .GetKYCCibc, .GetSourceOfIncome, .GetInvestObjective, .GetNationality, .InsertAttachments, .loginVlens, .GetAllRequestTypes, .CreateBusinessRequest, .getCurrentListIds, .LoginAdmin, .ApproveOrRejectRequest, .GetCurrentBusinessRequestList, .ActivateBusinessRequest, .ValidateOtpBusinessRequest:
                return .post
            }
        }
    }

    var requestType: APITypeOfRequest{
        switch self {
        case .CheckEmailOrPhoneExistence(let requestModel):
                .requestJsonEncodable(requestModel)
        case .GetAccessToken(let requestModel):
                .requestJsonEncodable(requestModel)
        case .StepVerifyPhone(let requestModel):
                .requestJsonEncodable(requestModel)
        case .VerifyPhoneOtp(let requestModel):
                .requestJsonEncodable(requestModel)
        case .StepVerifyEmail(let requestModel):
                .requestJsonEncodable(requestModel)
        case .VerifyEmailWithOtp(let requestModel):
                .requestJsonEncodable(requestModel)
        case .StepCreate(let requestModel):
                .requestJsonEncodable(requestModel)
        case .VerifyIDFrontVlens(let requestModel):
                .requestJsonEncodable(requestModel)
        case .VerifyIDBack(let requestModel):
                .requestJsonEncodable(requestModel)
        case .VerifyLiveness(let requestModel):
                .requestJsonEncodable(requestModel)
        case .GetKYCCibc(let requestModel):
                .requestJsonEncodable(requestModel)
        case .GetSourceOfIncome(let requestModel):
                .requestJsonEncodable(requestModel)
        case .GetInvestObjective(let requestModel):
                .requestJsonEncodable(requestModel)
        case .GetNationality(let requestModel):
                .requestJsonEncodable(requestModel)
        case .InsertAttachments(let requestModel):
                .requestJsonEncodable(requestModel)
        case .loginVlens(let requestModel):
                .requestJsonEncodable(requestModel)
        case .GetAllRequestTypes(let requestModel):
                .requestJsonEncodable(requestModel)
        case .CreateBusinessRequest(let requestModel):
                .requestJsonEncodable(requestModel)
        case .getCurrentListIds(let requestModel):
                .requestJsonEncodable(requestModel)
        case .LoginAdmin(let requestModel):
                .requestJsonEncodable(requestModel)
        case .ApproveOrRejectRequest(let requestModel):
                .requestJsonEncodable(requestModel)
        case .GetCurrentBusinessRequestList(let requestModel):
                .requestJsonEncodable(requestModel)
        case .ActivateBusinessRequest(let requestModel):
                .requestJsonEncodable(requestModel)
        case .ValidateOtpBusinessRequest(let requestModel):
                .requestJsonEncodable(requestModel)
        }
    }


}
