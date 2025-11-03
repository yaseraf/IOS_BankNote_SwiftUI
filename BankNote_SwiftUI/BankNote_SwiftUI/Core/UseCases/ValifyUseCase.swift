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
    func GetFrontBackValify(requestModel: GetFrontBackValifiyRequestModel, completion: @escaping(Result<GetFrontBackValifiyUIModel, NetworkError>) -> Void) async
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

}
