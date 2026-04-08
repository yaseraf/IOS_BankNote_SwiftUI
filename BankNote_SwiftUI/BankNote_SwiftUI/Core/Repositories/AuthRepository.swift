//
//  AuthRepository.swift
//  QSC_SwiftUI
//
//  Created by FIT on 20/08/2025.
//

import Foundation
protocol AuthRepositoryProtocol {
    func urlIPAddress(route:AuthRoute, completion: @escaping(Result<UrlIPAddressResponseModel, NetworkError>) -> Void) async
    func login(route:AuthRoute, completion: @escaping(Result<LoginResponseModel, NetworkError>) -> Void) async
    func OTP (route:AuthRoute, completion: @escaping(Result<OTPResponseModel, NetworkError>) -> Void) async
    func GetDeviceConfigs (route:AuthRoute, completion: @escaping(Result<GetDeviceConfigsResponseModel, NetworkError>) -> Void) async
    func GetKYCCibc(route:AuthRoute, completion: @escaping(Result<GetKYCCibcResponseModel, NetworkError>) -> Void) async
    
    // MARK: Forget Password
    func UserAuthinticationAdvance(route:AuthRoute, completion: @escaping(Result<UserAuthenticationAdvanceResponseModel, NetworkError>) -> Void) async
    func RegistrationsOTPReset(route:AuthRoute, completion: @escaping(Result<RegistrationsOTPResetResponseModel, NetworkError>) -> Void) async
    func ChangesPassword(route:AuthRoute, completion: @escaping(Result<ChangePasswordResponseModel, NetworkError>) -> Void) async
    func ChangePin(route:AuthRoute, completion: @escaping(Result<ChangePinResponseModel, NetworkError>) -> Void) async

}

class AuthRepository: AuthRepositoryProtocol {
    
    func urlIPAddress(route: AuthRoute, completion: @escaping (Result<UrlIPAddressResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route,responseType: UrlIPAddressResponseModel.self, completion: completion).requestApi()
    }

    func OTP(route: AuthRoute, completion: @escaping (Result<OTPResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route,responseType: OTPResponseModel.self, completion: completion).requestApi()
    }
    
    func login(route: AuthRoute, completion: @escaping (Result<LoginResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route,responseType: LoginResponseModel.self, completion: completion).requestApi()
    }
    
    func GetDeviceConfigs(route: AuthRoute, completion: @escaping (Result<GetDeviceConfigsResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route,responseType: GetDeviceConfigsResponseModel.self, completion: completion).requestApi()
    }
    
    func GetKYCCibc(route: AuthRoute, completion: @escaping (Result<GetKYCCibcResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route,responseType: GetKYCCibcResponseModel.self, completion: completion).requestApi()
    }
    
    // MARK: Forget Password
    func UserAuthinticationAdvance(route: AuthRoute, completion: @escaping (Result<UserAuthenticationAdvanceResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route,responseType: UserAuthenticationAdvanceResponseModel.self, completion: completion).requestApi()
    }
    
    func RegistrationsOTPReset(route: AuthRoute, completion: @escaping (Result<RegistrationsOTPResetResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route,responseType: RegistrationsOTPResetResponseModel.self, completion: completion).requestApi()
    }
    
    func ChangesPassword(route: AuthRoute, completion: @escaping (Result<ChangePasswordResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route,responseType: ChangePasswordResponseModel.self, completion: completion).requestApi()
    }
    
    func ChangePin(route: AuthRoute, completion: @escaping (Result<ChangePinResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route,responseType: ChangePinResponseModel.self, completion: completion).requestApi()
    }

}
