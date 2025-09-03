//
//  VerifyOtpPopupViewModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 22/07/2025.
//

import Foundation
import UIKit

class VerifyOtpPopupViewModel: ObservableObject {
    private var coordinator: AuthCoordinatorProtocol
    private let useCase: LoginUseCase
    
    @Published var username:String?
    @Published var password:String?
    
    @Published var otpAPIResult: APIResultType<otpUIModel>?
    
    init(coordinator: AuthCoordinatorProtocol, useCase: LoginUseCase, username: String, password: String) {
        self.coordinator = coordinator
        self.useCase = useCase
        
        self.username = username
        self.password = password
    }
    
    func onDismiss() {
        coordinator.dismiss()
        
    }
    
    func openForgotPinScene() {
        coordinator.dismiss()
        coordinator.openForgotPasswordScene(forgotType: .forgotPin)
    }
    
    func onVerify(tokenId: String) {
        callRegistrationsOTPAPI(tokenId: tokenId)
    }
    
    func callRegistrationsOTPAPI(tokenId: String)  {
    
        let requestModel = OTPRequestModel(emailAddress: "", hdnKey: "", fingerPrintId: "", mainClientID: "", mobileNo: "", mobileType: "iOS/\(UIDevice.current.type)/\(UIDevice.current.systemVersion)/V.\(String(Bundle.main.getVersionNumber ?? 1))", newUser: "", oldPassword: "", password: password ?? "", password2: "", registrationId: "", sessionID: "", tokenID: tokenId.arToEnDigits, touchToken: "", tradingNo: "", userIPAddress: AppUtility.shared.getAddress(for: .wifi) ?? "", userName: username ?? "", versionNumber: "", webCode: "", isAuthorizeOnly: "N", fingerPrintID: "", fingerPrintLevel: "", FingerPrintEnabled: "", RegistrationId: "dLy7NdV_7UPosCQkg0rZ5U:APA91bHV9cChNcmI6vIiPrlOO1eL0tH4VgCZ8Ob6A6QU0tsWnPhQb76hEVNkGJCr1y-6qiP36rWQeTpZDS0XQDUQ-LxybMJonZVZyvKMAoRIDa66_4eexYsKTVUQEL5X7yuEbi4f0cty")
        
                       
        otpAPIResult = .onLoading(show: true)
        Task.init {
            await useCase.otp(requestModel: requestModel) {[weak self] result in
                self?.otpAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    
                    KeyChainController.shared().webCode = success.webCode
                    KeyChainController.shared().brokerID = success.brokerID
                    KeyChainController.shared().UCODE = success.uCode
                    KeyChainController.shared().compInit = success.compInit
                    KeyChainController.shared().email = success.email
                    KeyChainController.shared().username = success.userName
                    KeyChainController.shared().userType = success.userType
                    UserDefaultController.instance.nameFullNameA = success.nameFullNameA
                    UserDefaultController.instance.nameFullNameE = success.nameFullNameE
                    KeyChainController.shared().mobileNo = success.mobileNo

                    
                    self?.otpAPIResult = .onSuccess(response: success)
                    
                case .failure(let failure):

                    self?.otpAPIResult = .onFailure(error: failure)
               
                }
            }
        }
    }

}
