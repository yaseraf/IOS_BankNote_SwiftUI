//
//  TradeUseCase.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 18/09/2025.
//

import Foundation

protocol KYCUseCaseProtocol{
    func CheckEmailOrPhoneExistence(requestModel: CheckEmailOrPhoneExistenceRequestModel, completion: @escaping(Result<CheckEmailOrPhoneExistenceUIModel, NetworkError>) -> Void) async
    func GetAccessToken(requestModel: GetAccessTokenRequestModel, completion: @escaping(Result<GetAccessTokenUIModel, NetworkError>) -> Void) async
    func StepVerifyPhone(requestModel: StepVerifyPhoneRequestModel, completion: @escaping(Result<StepVerifyPhoneUIModel, NetworkError>) -> Void) async
    func VerifyPhoneOtp(requestModel: VerifyPhoneOtpRequestModel, completion: @escaping(Result<VerifyPhoneOtpUIModel, NetworkError>) -> Void) async
    func StepVerifyEmail(requestModel: StepVerifyEmailRequestModel, completion: @escaping(Result<StepVerifyEmailUIModel, NetworkError>) -> Void) async
    func VerifyEmailWithOtp(requestModel: VerifyEmailWithOtpRequestModel, completion: @escaping(Result<VerifyEmailWithOtpUIModel, NetworkError>) -> Void) async
    func StepCreate(requestModel: StepCreateRequestModel, completion: @escaping(Result<StepCreateUIModel, NetworkError>) -> Void) async
    func VerifyIDFrontVlens(requestModel: VerifyIDFrontVlensRequestModel, completion: @escaping(Result<VerifyIDFrontVlensUIModel, NetworkError>) -> Void) async
    func VerifyIDBack(requestModel: VerifyIDBackRequestModel, completion: @escaping(Result<VerifyIDBackUIModel, NetworkError>) -> Void) async
    func VerifyLiveness(requestModel: VerifyLivenessRequestModel, completion: @escaping(Result<VerifyLivenessUIModel, NetworkError>) -> Void) async
    func GetKYCCibc(requestModel: GetKYCCibcRequestModel, completion: @escaping(Result<GetKYCCibcUIModel, NetworkError>) -> Void) async
    func GetSourceOfIncome(requestModel: GetSourceOfIncomeRequestModel, completion: @escaping(Result<GetSourceOfIncomeUIModel, NetworkError>) -> Void) async
    func GetInvestObjective(requestModel: GetInvestObjectiveRequestModel, completion: @escaping(Result<GetInvestObjectiveUIModel, NetworkError>) -> Void) async
    func GetNationality(requestModel: GetNationalityRequestModel, completion: @escaping(Result<GetNationalityUIModel, NetworkError>) -> Void) async
    func InsertAttachments(requestModel: InsertAttachmentsRequestModel, completion: @escaping(Result<InsertAttachmentsUIModel, NetworkError>) -> Void) async
    func loginVlens(requestModel: LoginVlensRequestModel, completion: @escaping(Result<LoginVlensUIModel, NetworkError>) -> Void) async
    func GetAllRequestTypes(requestModel: GetAllRequestTypesRequestModel, completion: @escaping(Result<GetAllRequestTypesUIModel, NetworkError>) -> Void) async
    func CreateBusinessRequest(requestModel: CreateBusinessRequestRequestModel, completion: @escaping(Result<CreateBusinessRequestUIModel, NetworkError>) -> Void) async
    func LoginAdmin(requestModel: LoginAdminRequestModel, completion: @escaping(Result<LoginAdminUIModel, NetworkError>) -> Void) async
    func ApproveOrRejectRequest(requestModel: ApproveOrRejectRequestRequestModel, completion: @escaping(Result<ApproveOrRejectRequestUIModel, NetworkError>) -> Void) async
    func GetCurrentBusinessRequestList(requestModel: GetCurrentBusinessRequestListRequestModel, completion: @escaping(Result<GetCurrentBusinessRequestListUIModel, NetworkError>) -> Void) async
    func GetCurrentListIds(requestModel: GetCurrentListIdsRequestModel, completion: @escaping(Result<GetCurrentListIdsUIModel, NetworkError>) -> Void) async
    func ActivateBusinessRequest(requestModel: ActivateBusinessRequestRequestModel, completion: @escaping(Result<ActivateBusinessRequestUIModel, NetworkError>) -> Void) async
    func ValidateOtpBusinessRequest(requestModel: ValidateOtpBusinessRequestRequestModel, completion: @escaping(Result<ValidateOtpBusinessRequestUIModel, NetworkError>) -> Void) async
}

class KYCUseCase {
    private let repository: KYCRepositoryProtocol
    init(repository: KYCRepositoryProtocol = KYCRepository()) {
        self.repository = repository
    }
}

extension KYCUseCase: KYCUseCaseProtocol {
    func CheckEmailOrPhoneExistence(requestModel: CheckEmailOrPhoneExistenceRequestModel, completion: @escaping (Result<CheckEmailOrPhoneExistenceUIModel, NetworkError>) -> Void) async {
        let route = KYCRoute.CheckEmailOrPhoneExistence(requestModel: requestModel)
        await repository.CheckEmailOrPhoneExistence(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = CheckEmailOrPhoneExistenceUIModel.mapToUIModel(responseModel)
                completion(.success(uiModel))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }

    func GetCurrentListIds(requestModel: GetCurrentListIdsRequestModel, completion: @escaping (Result<GetCurrentListIdsUIModel, NetworkError>) -> Void) async {
        let route = KYCRoute.getCurrentListIds(requestModel: requestModel)
        await repository.GetCurrentListIds(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = GetCurrentListIdsUIModel.mapToUIModel(responseModel)
                completion(.success(uiModel))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func LoginAdmin(requestModel: LoginAdminRequestModel, completion: @escaping (Result<LoginAdminUIModel, NetworkError>) -> Void) async {
        let route = KYCRoute.LoginAdmin(requestModel: requestModel)
        await repository.LoginAdmin(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = LoginAdminUIModel.mapToUIModel(responseModel)
                completion(.success(uiModel))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func ApproveOrRejectRequest(requestModel: ApproveOrRejectRequestRequestModel, completion: @escaping (Result<ApproveOrRejectRequestUIModel, NetworkError>) -> Void) async {
        let route = KYCRoute.ApproveOrRejectRequest(requestModel: requestModel)
        await repository.ApproveOrRejectRequest(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = ApproveOrRejectRequestUIModel.mapToUIModel(responseModel)
                completion(.success(uiModel))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func CreateBusinessRequest(requestModel: CreateBusinessRequestRequestModel, completion: @escaping (Result<CreateBusinessRequestUIModel, NetworkError>) -> Void) async {
        let route = KYCRoute.CreateBusinessRequest(requestModel: requestModel)
        await repository.CreateBusinessRequest(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = CreateBusinessRequestUIModel.mapToUIModel(responseModel)
                completion(.success(uiModel))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func GetCurrentBusinessRequestList(requestModel: GetCurrentBusinessRequestListRequestModel, completion: @escaping (Result<GetCurrentBusinessRequestListUIModel, NetworkError>) -> Void) async {
        let route = KYCRoute.GetCurrentBusinessRequestList(requestModel: requestModel)
        await repository.GetCurrentBusinessRequestList(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = GetCurrentBusinessRequestListUIModel.mapToUIModel(responseModel)
                completion(.success(uiModel))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func ActivateBusinessRequest(requestModel: ActivateBusinessRequestRequestModel, completion: @escaping (Result<ActivateBusinessRequestUIModel, NetworkError>) -> Void) async {
        let route = KYCRoute.ActivateBusinessRequest(requestModel: requestModel)
        await repository.ActivateBusinessRequest(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = ActivateBusinessRequestUIModel.mapToUIModel(responseModel)
                completion(.success(uiModel))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func ValidateOtpBusinessRequest(requestModel: ValidateOtpBusinessRequestRequestModel, completion: @escaping (Result<ValidateOtpBusinessRequestUIModel, NetworkError>) -> Void) async {
        let route = KYCRoute.ValidateOtpBusinessRequest(requestModel: requestModel)
        await repository.ValidateOtpBusinessRequest(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = ValidateOtpBusinessRequestUIModel.mapToUIModel(responseModel)
                completion(.success(uiModel))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func GetAllRequestTypes(requestModel: GetAllRequestTypesRequestModel, completion: @escaping (Result<GetAllRequestTypesUIModel, NetworkError>) -> Void) async {
        let route = KYCRoute.GetAllRequestTypes(requestModel: requestModel)
        await repository.GetAllRequestTypes(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = GetAllRequestTypesUIModel.mapToUIModel(responseModel)
                completion(.success(uiModel))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func loginVlens(requestModel: LoginVlensRequestModel, completion: @escaping (Result<LoginVlensUIModel, NetworkError>) -> Void) async {
        let route = KYCRoute.loginVlens(requestModel: requestModel)
        await repository.LoginVlens(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = LoginVlensUIModel.mapToUIModel(responseModel)
                completion(.success(uiModel))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func StepVerifyPhone(requestModel: StepVerifyPhoneRequestModel, completion: @escaping (Result<StepVerifyPhoneUIModel, NetworkError>) -> Void) async {
        let route = KYCRoute.StepVerifyPhone(requestModel: requestModel)
        await repository.StepVerifyPhone(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = StepVerifyPhoneUIModel.mapToUIModel(responseModel)
                completion(.success(uiModel))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func VerifyPhoneOtp(requestModel: VerifyPhoneOtpRequestModel, completion: @escaping (Result<VerifyPhoneOtpUIModel, NetworkError>) -> Void) async {
        let route = KYCRoute.VerifyPhoneOtp(requestModel: requestModel)
        await repository.VerifyPhoneOtp(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = VerifyPhoneOtpUIModel.mapToUIModel(responseModel)
                completion(.success(uiModel))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func StepVerifyEmail(requestModel: StepVerifyEmailRequestModel, completion: @escaping (Result<StepVerifyEmailUIModel, NetworkError>) -> Void) async {
        let route = KYCRoute.StepVerifyEmail(requestModel: requestModel)
        await repository.StepVerifyEmail(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = StepVerifyEmailUIModel.mapToUIModel(responseModel)
                completion(.success(uiModel))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func VerifyEmailWithOtp(requestModel: VerifyEmailWithOtpRequestModel, completion: @escaping (Result<VerifyEmailWithOtpUIModel, NetworkError>) -> Void) async {
        let route = KYCRoute.VerifyEmailWithOtp(requestModel: requestModel)
        await repository.VerifyEmailWithOtp(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = VerifyEmailWithOtpUIModel.mapToUIModel(responseModel)
                completion(.success(uiModel))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func StepCreate(requestModel: StepCreateRequestModel, completion: @escaping (Result<StepCreateUIModel, NetworkError>) -> Void) async {
        let route = KYCRoute.StepCreate(requestModel: requestModel)
        await repository.StepCreate(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = StepCreateUIModel.mapToUIModel(responseModel)
                completion(.success(uiModel))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func VerifyIDFrontVlens(requestModel: VerifyIDFrontVlensRequestModel, completion: @escaping (Result<VerifyIDFrontVlensUIModel, NetworkError>) -> Void) async {
        let route = KYCRoute.VerifyIDFrontVlens(requestModel: requestModel)
        await repository.VerifyIDFrontVlens(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = VerifyIDFrontVlensUIModel.mapToUIModel(responseModel)
                completion(.success(uiModel))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func VerifyIDBack(requestModel: VerifyIDBackRequestModel, completion: @escaping (Result<VerifyIDBackUIModel, NetworkError>) -> Void) async {
        let route = KYCRoute.VerifyIDBack(requestModel: requestModel)
        await repository.VerifyIDBack(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = VerifyIDBackUIModel.mapToUIModel(responseModel)
                completion(.success(uiModel))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func VerifyLiveness(requestModel: VerifyLivenessRequestModel, completion: @escaping (Result<VerifyLivenessUIModel, NetworkError>) -> Void) async {
        let route = KYCRoute.VerifyLiveness(requestModel: requestModel)
        await repository.VerifyLiveness(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = VerifyLivenessUIModel.mapToUIModel(responseModel)
                completion(.success(uiModel))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func GetKYCCibc(requestModel: GetKYCCibcRequestModel, completion: @escaping (Result<GetKYCCibcUIModel, NetworkError>) -> Void) async {
        let route = KYCRoute.GetKYCCibc(requestModel: requestModel)
        await repository.GetKYCCibc(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = GetKYCCibcUIModel.mapToUIModel(responseModel)
                completion(.success(uiModel))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func GetSourceOfIncome(requestModel: GetSourceOfIncomeRequestModel, completion: @escaping (Result<GetSourceOfIncomeUIModel, NetworkError>) -> Void) async {
        let route = KYCRoute.GetSourceOfIncome(requestModel: requestModel)
        await repository.GetSourceOfIncome(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = GetSourceOfIncomeUIModel.mapToUIModel(responseModel)
                completion(.success(uiModel))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func GetInvestObjective(requestModel: GetInvestObjectiveRequestModel, completion: @escaping (Result<GetInvestObjectiveUIModel, NetworkError>) -> Void) async {
        let route = KYCRoute.GetInvestObjective(requestModel: requestModel)
        await repository.GetInvestObjective(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = GetInvestObjectiveUIModel.mapToUIModel(responseModel)
                completion(.success(uiModel))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func GetNationality(requestModel: GetNationalityRequestModel, completion: @escaping (Result<GetNationalityUIModel, NetworkError>) -> Void) async {
        let route = KYCRoute.GetNationality(requestModel: requestModel)
        await repository.GetNationality(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = GetNationalityUIModel.mapToUIModel(responseModel)
                completion(.success(uiModel))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func InsertAttachments(requestModel: InsertAttachmentsRequestModel, completion: @escaping (Result<InsertAttachmentsUIModel, NetworkError>) -> Void) async {
        let route = KYCRoute.InsertAttachments(requestModel: requestModel)
        await repository.InsertAttachments(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = InsertAttachmentsUIModel.mapToUIModel(responseModel)
                completion(.success(uiModel))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func GetAccessToken(requestModel: GetAccessTokenRequestModel, completion: @escaping (Result<GetAccessTokenUIModel, NetworkError>) -> Void) async {
        let route = KYCRoute.GetAccessToken(requestModel: requestModel)
        await repository.GetAccessToken(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = GetAccessTokenUIModel.mapToUIModel(responseModel)
                completion(.success(uiModel))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
