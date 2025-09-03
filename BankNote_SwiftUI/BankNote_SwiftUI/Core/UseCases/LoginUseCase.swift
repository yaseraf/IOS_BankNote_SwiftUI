//
//  LoginUseCase.swift
//  QSC_SwiftUI
//
//  Created by FIT on 20/08/2025.
//

import Foundation
protocol LoginUseCaseProtocol{
    func loginMap(requestModel: LoginRequestModel , completion: @escaping(Result<LoginUIModel, NetworkError>, [HTTPCookie]?) -> Void) async
    func otp(requestModel: OTPRequestModel , completion: @escaping(Result<otpUIModel, NetworkError>) -> Void) async
}

class LoginUseCase {
    private let repository: AuthRepositoryProtocol
    init(repository: AuthRepositoryProtocol = AuthRepository()) {
        self.repository = repository
    }
}

extension LoginUseCase: LoginUseCaseProtocol {
    func otp(requestModel: OTPRequestModel, completion: @escaping (Result<otpUIModel, NetworkError>) -> Void) async {
        let route = AuthRoute.OTP(requestModel: requestModel)
        await repository.OTP(route: route) { result in
            switch result {
            case .success(let responseModel):
                
                let uiModel = otpUIModel.mapToUIModel(responseModel)
                
                completion(.success(uiModel))
                
            case .failure(let failure):
                completion(.failure(failure))
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
}
