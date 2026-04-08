//
//  VerifyOtpPopupViewModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 22/07/2025.
//

import Foundation
import Combine
import JavaScriptCore

class ConfirmOtpPopupViewModel: ObservableObject {
    private var coordinator: AuthCoordinatorProtocol
    private var useCase: AuthUseCaseProtocol
    private var anyCancellable: AnyCancellable? = nil
    @Published var timerViewModel:OTPTimerViewModel
    @Published var otpExpirationTimer: Double = 60
    
    @Published var forgotType: ForgotDataEnum

    @Published var registrationsOTPResetAPIResult:APIResultType<RegistrationsOTPResetUIModel>?
    @Published var forgetPasswordData: UserAuthenticationAdvanceUIModel?

    init(coordinator: AuthCoordinatorProtocol, useCase: AuthUseCaseProtocol, forgotType: ForgotDataEnum) {
        self.coordinator = coordinator
        self.useCase = useCase
        self.forgotType = forgotType
        self.timerViewModel = .init()
        
        anyCancellable = timerViewModel.objectWillChange.sink { [weak self] (_) in
            self?.objectWillChange.send()
        }
    }
    
    func onDismiss() {
        coordinator.dismiss()
        
    }
    
    func onVerify(otp: String) {
        if forgotType == .forgotPassword {
            callRegistrationsOTPResetAPI(success: true, otp: otp)
        } else if forgotType == .forgotPin {
            coordinator.dismiss()
            coordinator.openChangePinScene()
        }
    }
}

// MARK: API Calls
extension ConfirmOtpPopupViewModel {
    func callRegistrationsOTPResetAPI(success: Bool, otp:String) {
        
        var pin = otp
        let jsContext = JSContext()
              
        if jsContext != nil, let jsSourcePath = Bundle.main.path(forResource: "FiT_Encryption", ofType: "js") {
            do {
              
                let jsSourceContents = try String(contentsOfFile: jsSourcePath)
                
                jsContext!.evaluateScript(jsSourceContents)
                
                if let testFunction = jsContext!.objectForKeyedSubscript("encrypt"){
                    let encPin = (testFunction.call(withArguments: [otp])?.toString() ?? "")
//                    pin = encPin
                }
            }
            catch {
                printToLog("JS error:\(error.localizedDescription)")
            }
        }
        else {
            print ("error")
        }
                
        let requestModel = RegistrationsOTPResetRequestModel(fingerPrintEnabled: "", tradingNo: "", versionNumber: "", fingerPrintID: "", fingerPrintLevel: "", hdnKey: "", isAuthorizeOnly: "Y", mobileType: "", password: "", registrationID: "", sessionID: "", tokenID: pin, userIPAddress: UserDefaultController().userIPAddress ?? "", userName: forgetPasswordData?.userName)
        
        registrationsOTPResetAPIResult = .onLoading(show: true)
        
        Task.init {
            await useCase.RegistrationsOTPReset(requestModel: requestModel) {[weak self] result, cookies in
                
                self?.registrationsOTPResetAPIResult = .onLoading(show: false)
                
                switch result {
                case .success(let success):
                    self?.registrationsOTPResetAPIResult = .onSuccess(response: success)
                    
                    if success.statusCode == "0" {
                        KeyChainController().resetPasswordCookies = "\(cookies?.first?.name ?? "")=\(cookies?.first?.value ?? "")"
    //                    KeyChainController().resetPasswordCookies = cookies?.first?.value
                        
    //                    KeyChainController().signInToken = cookies?.first?.value
                        
                        KeyChainController.shared().webCode = success.webCode
                        UserDefaultController().username = success.username
                        
                        debugPrint("verify forget otp success")
                        
//                        self?.coordinator.dismiss()
//                        self?.coordinator.openChangePasswordScene()
                    } else {
                        
                        SceneDelegate.getAppCoordinator()?.showMessage(type: .failure, "\(success.errorMessage)")
                    }
                    
                    self?.coordinator.dismiss()
                    self?.coordinator.openChangePasswordScene()

                    

                case .failure(let failure):
                    self?.registrationsOTPResetAPIResult = .onFailure(error: failure)
                        debugPrint("verify forget otp failed")
               
                }
            }
        }
    }

}

// MARK: Timer
extension ConfirmOtpPopupViewModel {


    func initTimer() {
        timerViewModel.initTimer()
    }

    func startTimer() {
        timerViewModel.startTimer(resentOtpTimer: otpExpirationTimer)
    }

     func handleTimerValue(second: Int) {
         timerViewModel.handleTimerValue(second: second )

    }

    func endTimerIfNeed() {
        timerViewModel.endTimerIfNeed()
    }
}
