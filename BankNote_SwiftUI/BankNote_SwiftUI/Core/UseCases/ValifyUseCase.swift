//
//  ValifyUseCase.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 30/10/2025.
//

import Foundation

protocol ValifyUseCaseProtocol{
    func SendPhoneOtpValify(requestModel: SendPhoneOtpValifyRequestModel, completion: @escaping(Result<SendPhoneOtpValifyUIModel, NetworkError>) -> Void) async
    func VerifyPhoneOtpValify(requestModel: VerifyPhoneOtpValifyRequestModel, completion: @escaping(Result<VerifyPhoneOtpValifyUIModel, NetworkError>) -> Void) async
    func SendEmailOtpValify(requestModel: SendEmailOtpValifyRequestModel, completion: @escaping(Result<SendEmailOtpValifyUIModel, NetworkError>) -> Void) async
    func VerifyEmailOtpValify(requestModel: VerifyEmailOtpValifyRequestModel, completion: @escaping(Result<VerifyEmailOtpValifyUIModel, NetworkError>) -> Void) async
    func RegistrationStatusValify(requestModel: RegistrationStatusValifyRequestModel, completion: @escaping(Result<RegistrationStatusValifyUIModel, NetworkError>) -> Void) async
    func GetFrontBackValify(requestModel: GetFrontBackValifiyRequestModel, completion: @escaping(Result<GetFrontBackValifiyUIModel, NetworkError>) -> Void) async
    func GetValifyData(requestModel: GetValifyDataRequestModel, completion: @escaping(Result<GetValifyDataUIModel, NetworkError>) -> Void) async
    func RegisterValify(requestModel: RegisterValifyRequestModel, completion: @escaping(Result<RegisterValifyUIModel, NetworkError>) -> Void) async
    func GetQuestionsValify(requestModel: GetQuestionsValifyRequestModel, completion: @escaping(Result<GetQuestionsValifyUIModel, NetworkError>) -> Void) async
    func SetAnswerValify(requestModel: SetAnswerValifyRequestModel, completion: @escaping(Result<SetAnswerValifyUIModel, NetworkError>) -> Void) async
    func SetPasswordValify(requestModel: SetPasswordValifyRequestModel, completion: @escaping(Result<SetPasswordValifyUIModel, NetworkError>) -> Void) async
    func LoginValify(requestModel: LoginValifyRequestModel, completion: @escaping(Result<LoginValifyUIModel, NetworkError>) -> Void) async
    func ResetPasswordValify(requestModel: ResetPasswordValifyRequestModel, completion: @escaping(Result<ResetPasswordValifyUIModel, NetworkError>) -> Void) async
    func CsoValify(requestModel: CsoValifyRequestModel, completion: @escaping(Result<CsoValifyUIModel, NetworkError>) -> Void) async
    func NtraValify(requestModel: NtraValifyRequestModel, completion: @escaping(Result<NtraValifyUIModel, NetworkError>) -> Void) async
    func GetKYCFieldValify(requestModel: GetKycFieldValifyRequestModel, completion: @escaping(Result<GetKycFieldValifyUIModel, NetworkError>) -> Void) async
    func GetKYCContractValify(requestModel: GetKycContractValifyRequestModel, completion: @escaping(Result<GetKycContractValifyUIModel, NetworkError>) -> Void) async
    func GetContractValify(requestModel: GetContractValifyRequestModel, completion: @escaping(Result<GetContractValifyUIModel, NetworkError>) -> Void) async
}
    
    class ValifyUseCase {
        private let repository: ValifyRepositoryProtocol
        init(repository: ValifyRepositoryProtocol = ValifyRepository()) {
            self.repository = repository
        }
    }

extension ValifyUseCase: ValifyUseCaseProtocol {
    func SendPhoneOtpValify(requestModel: SendPhoneOtpValifyRequestModel, completion: @escaping (Result<SendPhoneOtpValifyUIModel, NetworkError>) -> Void) async {
        let route = AuthRoute.SendPhoneOtpValify(requestModel: requestModel)
        await repository.SendPhoneOtpValify(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = SendPhoneOtpValifyUIModel.mapToUIModel(responseModel)
                completion(.success(uiModel))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func VerifyPhoneOtpValify(requestModel: VerifyPhoneOtpValifyRequestModel, completion: @escaping (Result<VerifyPhoneOtpValifyUIModel, NetworkError>) -> Void) async {
        let route = AuthRoute.VerifyPhoneOtpValify(requestModel: requestModel)
        await repository.VerifyPhoneOtpValify(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = VerifyPhoneOtpValifyUIModel.mapToUIModel(responseModel)
                completion(.success(uiModel))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func RegistrationStatusValify(requestModel: RegistrationStatusValifyRequestModel, completion: @escaping (Result<RegistrationStatusValifyUIModel, NetworkError>) -> Void) async {
        let route = AuthRoute.RegistrationStatusValify(requestModel: requestModel)
        await repository.RegistrationStatusValify(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = RegistrationStatusValifyUIModel.mapToUIModel(responseModel)
                completion(.success(uiModel))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func SendEmailOtpValify(requestModel: SendEmailOtpValifyRequestModel, completion: @escaping (Result<SendEmailOtpValifyUIModel, NetworkError>) -> Void) async {
        let route = AuthRoute.SendEmailOtpValify(requestModel: requestModel)
        await repository.SendEmailOtpValify(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = SendEmailOtpValifyUIModel.mapToUIModel(responseModel)
                completion(.success(uiModel))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }

    func VerifyEmailOtpValify(requestModel: VerifyEmailOtpValifyRequestModel, completion: @escaping (Result<VerifyEmailOtpValifyUIModel, NetworkError>) -> Void) async {
        let route = AuthRoute.VerifyEmailOtpValify(requestModel: requestModel)
        await repository.VerifyEmailOtpValify(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = VerifyEmailOtpValifyUIModel.mapToUIModel(responseModel)
                completion(.success(uiModel))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func GetFrontBackValify(requestModel: GetFrontBackValifiyRequestModel, completion: @escaping (Result<GetFrontBackValifiyUIModel, NetworkError>) -> Void) async {
        let route = AuthRoute.GetFrontBackValify(requestModel: requestModel)
        await repository.GetFrontBackValify(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = GetFrontBackValifiyUIModel.mapToUIModel(responseModel)
                completion(.success(uiModel))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }

    func GetValifyData(requestModel: GetValifyDataRequestModel, completion: @escaping (Result<GetValifyDataUIModel, NetworkError>) -> Void) async {
        let route = AuthRoute.GetValifyData(requestModel: requestModel)
        await repository.GetValifyData(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = GetValifyDataUIModel.mapToUIModel(responseModel)
                completion(.success(uiModel))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func RegisterValify(requestModel: RegisterValifyRequestModel, completion: @escaping (Result<RegisterValifyUIModel, NetworkError>) -> Void) async {
        let route = AuthRoute.RegisterValify(requestModel: requestModel)
        await repository.RegisterValify(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = RegisterValifyUIModel.mapToUIModel(responseModel)
                completion(.success(uiModel))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func GetQuestionsValify(requestModel: GetQuestionsValifyRequestModel, completion: @escaping (Result<GetQuestionsValifyUIModel, NetworkError>) -> Void) async {
        let route = AuthRoute.GetQuestionsValify(requestModel: requestModel)
        await repository.GetQuestionsValify(route: route) { result in
            switch result {
            case .success(let responseModel):
                
                let uiModel = GetQuestionsValifyUIModel.mapToUIModel(responseModel)

                completion(.success(uiModel))

                completion(.success(uiModel))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }

    func SetAnswerValify(requestModel: SetAnswerValifyRequestModel, completion: @escaping (Result<SetAnswerValifyUIModel, NetworkError>) -> Void) async {
        let route = AuthRoute.SetAnswerValify(requestModel: requestModel)
        await repository.SetAnswerValify(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = SetAnswerValifyUIModel.mapToUIModel(responseModel)
                completion(.success(uiModel))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }

    func SetPasswordValify(requestModel: SetPasswordValifyRequestModel, completion: @escaping (Result<SetPasswordValifyUIModel, NetworkError>) -> Void) async {
        let route = AuthRoute.SetPasswordValify(requestModel: requestModel)
        await repository.SetPasswordValify(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = SetPasswordValifyUIModel.mapToUIModel(responseModel)
                completion(.success(uiModel))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }

    func LoginValify(requestModel: LoginValifyRequestModel, completion: @escaping (Result<LoginValifyUIModel, NetworkError>) -> Void) async {
        let route = AuthRoute.LoginValify(requestModel: requestModel)
        await repository.LoginValify(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = LoginValifyUIModel.mapToUIModel(responseModel)
                completion(.success(uiModel))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func ResetPasswordValify(requestModel: ResetPasswordValifyRequestModel, completion: @escaping (Result<ResetPasswordValifyUIModel, NetworkError>) -> Void) async {
        let route = AuthRoute.ResetPasswordValify(requestModel: requestModel)
        await repository.ResetPasswordValify(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = ResetPasswordValifyUIModel.mapToUIModel(responseModel)
                completion(.success(uiModel))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }

    func CsoValify(requestModel: CsoValifyRequestModel, completion: @escaping (Result<CsoValifyUIModel, NetworkError>) -> Void) async {
        let route = AuthRoute.CsoValify(requestModel: requestModel)
        await repository.CsoValify(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = CsoValifyUIModel.mapToUIModel(responseModel)
                completion(.success(uiModel))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func NtraValify(requestModel: NtraValifyRequestModel, completion: @escaping (Result<NtraValifyUIModel, NetworkError>) -> Void) async {
        let route = AuthRoute.NtraValify(requestModel: requestModel)
        await repository.NtraValify(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = NtraValifyUIModel.mapToUIModel(responseModel)
                completion(.success(uiModel))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }

    func GetKYCFieldValify(requestModel: GetKycFieldValifyRequestModel, completion: @escaping (Result<GetKycFieldValifyUIModel, NetworkError>) -> Void) async {
        let route = AuthRoute.GetKYCFieldValify(requestModel: requestModel)
        await repository.GetKYCFieldValify(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = GetKycFieldValifyUIModel.mapToUIModel(responseModel)
                completion(.success(uiModel))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func GetKYCContractValify(requestModel: GetKycContractValifyRequestModel, completion: @escaping (Result<GetKycContractValifyUIModel, NetworkError>) -> Void) async {
        let route = AuthRoute.GetKYCContractValify(requestModel: requestModel)
        await repository.GetKYCContractValify(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = GetKycContractValifyUIModel.mapToUIModel(responseModel)
                completion(.success(uiModel))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func GetContractValify(requestModel: GetContractValifyRequestModel, completion: @escaping (Result<GetContractValifyUIModel, NetworkError>) -> Void) async {
        let route = AuthRoute.GetContractValify(requestModel: requestModel)
        await repository.GetContractValify(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = GetContractValifyUIModel.mapToUIModel(responseModel)
                completion(.success(uiModel))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }

}
