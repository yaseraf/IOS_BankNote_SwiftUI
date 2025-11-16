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
    func GetValifyData (route:AuthRoute, completion: @escaping(Result<GetValifyDataResponseModel, NetworkError>) -> Void) async
    func RegisterValify (route:AuthRoute, completion: @escaping(Result<RegisterValifyResponseModel, NetworkError>) -> Void) async
    func GetQuestionsValify (route:AuthRoute, completion: @escaping(Result<GetQuestionsValifyResponseModel, NetworkError>) -> Void) async
    func SetAnswerValify (route:AuthRoute, completion: @escaping(Result<SetAnswerValifyResponseModel, NetworkError>) -> Void) async
    func SetPasswordValify (route:AuthRoute, completion: @escaping(Result<SetPasswordValifyResponseModel, NetworkError>) -> Void) async
    func LoginValify (route:AuthRoute, completion: @escaping(Result<LoginValifyResponseModel, NetworkError>) -> Void) async
    func ResetPasswordValify (route:AuthRoute, completion: @escaping(Result<ResetPasswordValifyResponseModel, NetworkError>) -> Void) async
    func CsoValify (route:AuthRoute, completion: @escaping(Result<CsoValifyResponseModel, NetworkError>) -> Void) async
    func NtraValify (route:AuthRoute, completion: @escaping(Result<NtraValifyResponseModel, NetworkError>) -> Void) async
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
    
    func GetValifyData(route: AuthRoute, completion: @escaping (Result<GetValifyDataResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route,responseType: GetValifyDataResponseModel.self, completion: completion).requestApi()
    }
    
    func RegisterValify(route: AuthRoute, completion: @escaping (Result<RegisterValifyResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route,responseType: RegisterValifyResponseModel.self, completion: completion).requestApi()
    }

    func GetQuestionsValify(route: AuthRoute, completion: @escaping (Result<GetQuestionsValifyResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route,responseType: GetQuestionsValifyResponseModel.self, completion: completion).requestApi()
    }

    func SetAnswerValify(route: AuthRoute, completion: @escaping (Result<SetAnswerValifyResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route,responseType: SetAnswerValifyResponseModel.self, completion: completion).requestApi()
    }

    func SetPasswordValify(route: AuthRoute, completion: @escaping (Result<SetPasswordValifyResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route,responseType: SetPasswordValifyResponseModel.self, completion: completion).requestApi()
    }

    func LoginValify(route: AuthRoute, completion: @escaping (Result<LoginValifyResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route,responseType: LoginValifyResponseModel.self, completion: completion).requestApi()
    }

    func ResetPasswordValify(route: AuthRoute, completion: @escaping (Result<ResetPasswordValifyResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route,responseType: ResetPasswordValifyResponseModel.self, completion: completion).requestApi()
    }
    
    func CsoValify(route: AuthRoute, completion: @escaping (Result<CsoValifyResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route,responseType: CsoValifyResponseModel.self, completion: completion).requestApi()
    }

    func NtraValify(route: AuthRoute, completion: @escaping (Result<NtraValifyResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route,responseType: NtraValifyResponseModel.self, completion: completion).requestApi()
    }


}
