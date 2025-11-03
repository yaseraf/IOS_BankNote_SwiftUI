//
//  AuthRepository.swift
//  QSC_SwiftUI
//
//  Created by FIT on 20/08/2025.
//

import Foundation
protocol ValifyRepositoryProtocol {
    func SendPhoneOtpValify(route:AuthRoute, completion: @escaping(Result<SendPhoneOtpValifyResponseModel, NetworkError>) -> Void) async
    func VerifyPhoneOtpValify (route:AuthRoute, completion: @escaping(Result<VerifyPhoneOtpValifyResponseModel, NetworkError>) -> Void) async
    func SendEmailOtpValify (route:AuthRoute, completion: @escaping(Result<SendEmailOtpValifyResponseModel, NetworkError>) -> Void) async
    func VerifyEmailOtpValify (route:AuthRoute, completion: @escaping(Result<VerifyEmailOtpValifyResponseModel, NetworkError>) -> Void) async
    func GetFrontBackValify (route:AuthRoute, completion: @escaping(Result<GetFrontBackValifiyResponseModel, NetworkError>) -> Void) async
}

class ValifyRepository: ValifyRepositoryProtocol {
    func SendPhoneOtpValify(route: AuthRoute, completion: @escaping (Result<SendPhoneOtpValifyResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route,responseType: SendPhoneOtpValifyResponseModel.self, completion: completion).requestApi()
    }
    
    func VerifyPhoneOtpValify(route: AuthRoute, completion: @escaping (Result<VerifyPhoneOtpValifyResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route,responseType: VerifyPhoneOtpValifyResponseModel.self, completion: completion).requestApi()
    }
    
    func SendEmailOtpValify(route: AuthRoute, completion: @escaping (Result<SendEmailOtpValifyResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route,responseType: SendEmailOtpValifyResponseModel.self, completion: completion).requestApi()
    }
    
    func VerifyEmailOtpValify(route: AuthRoute, completion: @escaping (Result<VerifyEmailOtpValifyResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route,responseType: VerifyEmailOtpValifyResponseModel.self, completion: completion).requestApi()
    }
    
    func GetFrontBackValify(route: AuthRoute, completion: @escaping (Result<GetFrontBackValifiyResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route,responseType: GetFrontBackValifiyResponseModel.self, completion: completion).requestApi()
    }
}
