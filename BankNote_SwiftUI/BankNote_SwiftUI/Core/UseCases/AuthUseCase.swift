//
//  AuthUseCase.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 17/09/2025.
//

import Foundation
protocol AuthUseCaseProtocol{
    func urlIPAddress(requestModel: String, completion: @escaping(Result<UrlIPAddressResponseModel, NetworkError>) -> Void) async
    func OTPMap(requestModel: OTPRequestModel , completion: @escaping(Result<otpUIModel, NetworkError>, [HTTPCookie]?) -> Void) async
    func loginMap(requestModel: LoginRequestModel , completion: @escaping(Result<LoginUIModel, NetworkError>, [HTTPCookie]?) -> Void) async
    func GetKYCCibc(requestModel: GetKYCCibcRequestModel, completion: @escaping(Result<GetKYCCibcUIModel, NetworkError>) -> Void) async
    
    // MARK: Forget Password
    func UserAuthinticationAdvance(requestModel: UserAuthenticationAdvanceRequestModel, completion: @escaping(Result<UserAuthenticationAdvanceUIModel, NetworkError>) -> Void) async
    func RegistrationsOTPReset(requestModel: RegistrationsOTPResetRequestModel, completion: @escaping(Result<RegistrationsOTPResetUIModel, NetworkError>, [HTTPCookie]?) -> Void) async
    func ChangesPassword(requestModel: ChangePasswordRequestModel, completion: @escaping(Result<changePasswordUIModel, NetworkError>) -> Void) async
    func ChangePin(requestModel: ChangePinRequestModel, completion: @escaping(Result<changePinUIModel, NetworkError>) -> Void) async
}

class AuthUseCase {
    private let repository: AuthRepositoryProtocol
    init(repository: AuthRepositoryProtocol = AuthRepository()) {
        self.repository = repository
    }
}

extension AuthUseCase: AuthUseCaseProtocol {
    
    func urlIPAddress(requestModel: String, completion: @escaping (Result<UrlIPAddressResponseModel, NetworkError>) -> Void) async {
        let route = AuthRoute.urlIPAddress(requestModel: requestModel)
        await repository.urlIPAddress(route: route) { result in
            switch result {
            case .success(let responseModel):
                

                let uiModel = responseModel
                completion(.success(uiModel))
                
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func OTPMap(requestModel: OTPRequestModel, completion: @escaping (Result<otpUIModel, NetworkError>, [HTTPCookie]?) -> Void) async {
        let route = AuthRoute.OTP(requestModel: requestModel)
        await repository.OTP(route: route) { result in
            switch result {
            case .success(let responseModel):
                
                let cookies = HTTPCookieStorage.shared.cookies(for: route.baseURL)

                let uiModel = otpUIModel.mapToUIModel(responseModel)
                
                completion(.success(uiModel), cookies)

            case .failure(let failure):
                completion(.failure(failure), [])
            }
        }
    }
    
    func loginMap(requestModel: LoginRequestModel, completion: @escaping (Result<LoginUIModel, NetworkError>, [HTTPCookie]?) -> Void) async {
        let route = AuthRoute.login(requestModel: requestModel)
        await repository.login(route: route) { result in
            switch result {
            case .success(let responseModel):
                
                let cookies = HTTPCookieStorage.shared.cookies(for: route.baseURL)

                let uiModel = LoginUIModel.mapToUIModel(responseModel)
                
                completion(.success(uiModel), cookies)
                
            case .failure(let failure):
                completion(.failure(failure), [])
            }
        }
    }
    
    func GetKYCCibc(requestModel: GetKYCCibcRequestModel, completion: @escaping (Result<GetKYCCibcUIModel, NetworkError>) -> Void) async {
        let route = AuthRoute.GetKYCCibc(requestModel: requestModel)
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
    
    // MARK: Forget Password
    func UserAuthinticationAdvance(requestModel: UserAuthenticationAdvanceRequestModel, completion: @escaping (Result<UserAuthenticationAdvanceUIModel, NetworkError>) -> Void) async {
        let route = AuthRoute.UserAuthinticationAdvance(requestModel: requestModel)
        await repository.UserAuthinticationAdvance(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = UserAuthenticationAdvanceUIModel.mapToUIModel(responseModel)
                completion(.success(uiModel))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func RegistrationsOTPReset(requestModel: RegistrationsOTPResetRequestModel, completion: @escaping (Result<RegistrationsOTPResetUIModel, NetworkError>, [HTTPCookie]?) -> Void) async {
        let route = AuthRoute.RegistrationsOTPReset(requestModel: requestModel)
        await repository.RegistrationsOTPReset(route: route) { result in
            switch result {
            case .success(let responseModel):
                let cookies = HTTPCookieStorage.shared.cookies(for: route.baseURL)
                let uiModel = RegistrationsOTPResetUIModel.mapToUIModel(responseModel)
                completion(.success(uiModel), cookies)
            case .failure(let failure):
                completion(.failure(failure), [])
            }
        }
    }
    
    func ChangesPassword(requestModel: ChangePasswordRequestModel, completion: @escaping (Result<changePasswordUIModel, NetworkError>) -> Void) async {
        let route = AuthRoute.ChangesPassword(requestModel: requestModel)
        await repository.ChangesPassword(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = changePasswordUIModel.mapToUIModel(responseModel)
                completion(.success(uiModel))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func ChangePin(requestModel: ChangePinRequestModel, completion: @escaping (Result<changePinUIModel, NetworkError>) -> Void) async {
        let route = AuthRoute.ChangePin(requestModel: requestModel)
        await repository.ChangePin(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = changePinUIModel.mapToUIModel(responseModel)
                completion(.success(uiModel))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }

    
}
