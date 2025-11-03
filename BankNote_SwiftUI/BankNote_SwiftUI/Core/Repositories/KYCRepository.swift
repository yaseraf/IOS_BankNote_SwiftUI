//
//  TradeRepository.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 18/09/2025.
//

import Foundation

protocol KYCRepositoryProtocol {
    func CheckEmailOrPhoneExistence(route:KYCRoute, completion: @escaping(Result<CheckEmailOrPhoneExistenceResponseModel, NetworkError>) -> Void) async
    func GetAccessToken(route:KYCRoute, completion: @escaping(Result<GetAccessTokenResponseModel, NetworkError>) -> Void) async
    func StepVerifyPhone(route:KYCRoute, completion: @escaping(Result<StepVerifyPhoneResponseModel, NetworkError>) -> Void) async
    func VerifyPhoneOtp(route:KYCRoute, completion: @escaping(Result<VerifyPhoneOtpResponseModel, NetworkError>) -> Void) async
    func StepVerifyEmail(route:KYCRoute, completion: @escaping(Result<StepVerifyEmailResponseModel, NetworkError>) -> Void) async
    func VerifyEmailWithOtp(route:KYCRoute, completion: @escaping(Result<VerifyEmailWithOtpResponseModel, NetworkError>) -> Void) async
    func StepCreate(route:KYCRoute, completion: @escaping(Result<StepCreateResponseModel, NetworkError>) -> Void) async
    func VerifyIDFrontVlens(route:KYCRoute, completion: @escaping(Result<VerifyIDFrontVlensResponseModel, NetworkError>) -> Void) async
    func VerifyIDBack(route:KYCRoute, completion: @escaping(Result<VerifyIDBackResponseModel, NetworkError>) -> Void) async
    func VerifyLiveness(route:KYCRoute, completion: @escaping(Result<VerifyLivenessResponseModel, NetworkError>) -> Void) async
    func GetKYCCibc(route:KYCRoute, completion: @escaping(Result<GetKYCCibcResponseModel, NetworkError>) -> Void) async
    func GetSourceOfIncome(route:KYCRoute, completion: @escaping(Result<GetSourceOfIncomeResponseModel, NetworkError>) -> Void) async
    func GetInvestObjective(route:KYCRoute, completion: @escaping(Result<GetInvestObjectiveResponseModel, NetworkError>) -> Void) async
    func GetNationality(route:KYCRoute, completion: @escaping(Result<GetNationalityResponseModel, NetworkError>) -> Void) async
    func InsertAttachments(route:KYCRoute, completion: @escaping(Result<InsertAttachmentsResponseModel, NetworkError>) -> Void) async
    func LoginVlens(route:KYCRoute, completion: @escaping(Result<LoginVlensResponseModel, NetworkError>) -> Void) async
    func GetAllRequestTypes(route:KYCRoute, completion: @escaping(Result<GetAllRequestTypesResponseModel, NetworkError>) -> Void) async
    func CreateBusinessRequest(route:KYCRoute, completion: @escaping(Result<CreateBusinessRequestResponseModel, NetworkError>) -> Void) async
    func GetCurrentListIds(route:KYCRoute, completion: @escaping(Result<GetCurrentListIdsResponseModel, NetworkError>) -> Void) async
    func LoginAdmin(route:KYCRoute, completion: @escaping(Result<LoginAdminResponseModel, NetworkError>) -> Void) async
    func ApproveOrRejectRequest(route:KYCRoute, completion: @escaping(Result<ApproveOrRejectRequestResponseModel, NetworkError>) -> Void) async
    func GetCurrentBusinessRequestList(route:KYCRoute, completion: @escaping(Result<GetCurrentBusinessRequestListResponseModel, NetworkError>) -> Void) async
    func ActivateBusinessRequest(route:KYCRoute, completion: @escaping(Result<ActivateBusinessRequestResponseModel, NetworkError>) -> Void) async
    func ValidateOtpBusinessRequest(route:KYCRoute, completion: @escaping(Result<ValidateOtpBusinessRequestResponseModel, NetworkError>) -> Void) async
}

class KYCRepository: KYCRepositoryProtocol {
    func CheckEmailOrPhoneExistence(route: KYCRoute, completion: @escaping (Result<CheckEmailOrPhoneExistenceResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route,responseType: CheckEmailOrPhoneExistenceResponseModel.self, completion: completion).requestApi()
    }
    
    func GetCurrentListIds(route: KYCRoute, completion: @escaping (Result<GetCurrentListIdsResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route,responseType: GetCurrentListIdsResponseModel.self, completion: completion).requestApi()
    }
    
    func LoginAdmin(route: KYCRoute, completion: @escaping (Result<LoginAdminResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route,responseType: LoginAdminResponseModel.self, completion: completion).requestApi()
    }
    
    func ApproveOrRejectRequest(route: KYCRoute, completion: @escaping (Result<ApproveOrRejectRequestResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route,responseType: ApproveOrRejectRequestResponseModel.self, completion: completion).requestApi()
    }
    
    func CreateBusinessRequest(route: KYCRoute, completion: @escaping (Result<CreateBusinessRequestResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route,responseType: CreateBusinessRequestResponseModel.self, completion: completion).requestApi()
    }
    
    func GetCurrentBusinessRequestList(route: KYCRoute, completion: @escaping (Result<GetCurrentBusinessRequestListResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route,responseType: GetCurrentBusinessRequestListResponseModel.self, completion: completion).requestApi()
    }
    
    func ActivateBusinessRequest(route: KYCRoute, completion: @escaping (Result<ActivateBusinessRequestResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route,responseType: ActivateBusinessRequestResponseModel.self, completion: completion).requestApi()
    }
    
    func ValidateOtpBusinessRequest(route: KYCRoute, completion: @escaping (Result<ValidateOtpBusinessRequestResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route,responseType: ValidateOtpBusinessRequestResponseModel.self, completion: completion).requestApi()
    }
    
    func GetAllRequestTypes(route: KYCRoute, completion: @escaping (Result<GetAllRequestTypesResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route,responseType: GetAllRequestTypesResponseModel.self, completion: completion).requestApi()
    }
    
    func LoginVlens(route: KYCRoute, completion: @escaping (Result<LoginVlensResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route,responseType: LoginVlensResponseModel.self, completion: completion).requestApi()
    }
    
    func GetAccessToken(route: KYCRoute, completion: @escaping (Result<GetAccessTokenResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route,responseType: GetAccessTokenResponseModel.self, completion: completion).requestApi()
    }
    
    func StepVerifyPhone(route: KYCRoute, completion: @escaping (Result<StepVerifyPhoneResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route,responseType: StepVerifyPhoneResponseModel.self, completion: completion).requestApi()
    }
    
    func VerifyPhoneOtp(route: KYCRoute, completion: @escaping (Result<VerifyPhoneOtpResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route,responseType: VerifyPhoneOtpResponseModel.self, completion: completion).requestApi()
    }
    
    func StepVerifyEmail(route: KYCRoute, completion: @escaping (Result<StepVerifyEmailResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route,responseType: StepVerifyEmailResponseModel.self, completion: completion).requestApi()
    }
    
    func VerifyEmailWithOtp(route: KYCRoute, completion: @escaping (Result<VerifyEmailWithOtpResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route,responseType: VerifyEmailWithOtpResponseModel.self, completion: completion).requestApi()
    }
    
    func StepCreate(route: KYCRoute, completion: @escaping (Result<StepCreateResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route,responseType: StepCreateResponseModel.self, completion: completion).requestApi()
    }
    
    func VerifyIDFrontVlens(route: KYCRoute, completion: @escaping (Result<VerifyIDFrontVlensResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route,responseType: VerifyIDFrontVlensResponseModel.self, completion: completion).requestApi()
    }
    
    func VerifyIDBack(route: KYCRoute, completion: @escaping (Result<VerifyIDBackResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route,responseType: VerifyIDBackResponseModel.self, completion: completion).requestApi()
    }
    
    func VerifyLiveness(route: KYCRoute, completion: @escaping (Result<VerifyLivenessResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route,responseType: VerifyLivenessResponseModel.self, completion: completion).requestApi()
    }
    
    func GetKYCCibc(route: KYCRoute, completion: @escaping (Result<GetKYCCibcResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route,responseType: GetKYCCibcResponseModel.self, completion: completion).requestApi()
    }
    
    func GetSourceOfIncome(route: KYCRoute, completion: @escaping (Result<GetSourceOfIncomeResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route,responseType: GetSourceOfIncomeResponseModel.self, completion: completion).requestApi()
    }
    
    func GetInvestObjective(route: KYCRoute, completion: @escaping (Result<GetInvestObjectiveResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route,responseType: GetInvestObjectiveResponseModel.self, completion: completion).requestApi()
    }
    
    func GetNationality(route: KYCRoute, completion: @escaping (Result<GetNationalityResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route,responseType: GetNationalityResponseModel.self, completion: completion).requestApi()
    }
    
    func InsertAttachments(route: KYCRoute, completion: @escaping (Result<InsertAttachmentsResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route,responseType: InsertAttachmentsResponseModel.self, completion: completion).requestApi()
    }
}
