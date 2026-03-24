//
//  ForgotPasswordViewModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 22/07/2025.
//

import Foundation
import JavaScriptCore

class ForgotPasswordViewModel:ObservableObject {
    private var coordinator: AuthCoordinatorProtocol
    private var useCase: AuthUseCaseProtocol
    
    @Published var forgotType: ForgotDataEnum
    
    @Published var authenticationType: AuthenticationViewType = .email
    
    @Published var emailInputValue: String = ""
    @Published var mobileInputValue: String = ""
    @Published var selectedSegment: Int = 0

    @Published var forgetPasswordAPIResult:APIResultType<UserAuthenticationAdvanceUIModel>?

    init(coordinator: AuthCoordinatorProtocol, useCase: AuthUseCaseProtocol, forgotType: ForgotDataEnum) {
        self.coordinator = coordinator
        self.useCase = useCase
        self.forgotType = forgotType
    }
    
    func onBack() {
        coordinator.popViewController()
    }
    
    func onSubmit() {
//        coordinator.openConfirmOtpScene(forgotType: forgotType)
        forgetPasswordAPI(success: true)
    }
    
    func openCountryPickerScene() {
//        coordinator.openCountryPickerScene()
    }
}

// MARK: API Calls
extension ForgotPasswordViewModel {
    func forgetPasswordAPI(success: Bool) {
        
        var email = ""
        var mobile = ""
        
        if authenticationType == .email {
            email = emailInputValue
        } else {
            mobile = mobileInputValue
        }
        
        let jsContext = JSContext()

        if jsContext != nil, let jsSourcePath = Bundle.main.path(forResource: "FiT_Encryption", ofType: "js") {
            do {
              
                let jsSourceContents = try String(contentsOfFile: jsSourcePath)
                
                jsContext!.evaluateScript(jsSourceContents)
                
                if let testFunction = jsContext!.objectForKeyedSubscript("encrypt"){
                    if email != "" {
                      
                        var encEmail = (testFunction.call(withArguments: [email])?.toString() ?? "")
                       
//                        printToLog("JS jsContext encUser:\(encEmail)")
                        email = encEmail
                    }
                    
                    if mobile != ""{
//                        phoneNo.removeLast()
                        mobile.removeFirst()
                        print (mobile)
                        let encPhone = (testFunction.call(withArguments: [mobile])?.toString() ?? "")
                        printToLog("JS jsContext encphone:\(encPhone)")
                        mobile = encPhone
                       }
                }
            }
            catch {
                printToLog("JS error:\(error.localizedDescription)")
            }
        }
        else {
            debugPrint ("error")
        }
                
//        let requestModel = UserAuthenticationAdvanceRequestModel(email: email, hdnKey: "", id: "", mobile: mobile, mobileType: "IOS", nin: "", newUser: "", oldPassword: "", password: "", requestType: authenticationType == .email ? "E" : "M", sessionID: "", tokenID: "", tradingNo: "", userIPAddress: "192.168.68.118", userName: "", webCode: KeyChainController.shared().webCode ?? "", lang: "")
        
  
        let requestModel = UserAuthenticationAdvanceRequestModel(email: email, id: "", mobile: mobile, mobileType: "IOS", nin: "", requestType: authenticationType == .email ? "E" : "M", userIPAddress: UserDefaultController().userIPAddress ?? "")
        
        forgetPasswordAPIResult = .onLoading(show: true)
        
        Task.init {
            await useCase.UserAuthinticationAdvance(requestModel: requestModel) {[weak self] result in
                
                self?.forgetPasswordAPIResult = .onLoading(show: false)
                
                switch result {
                case .success(let success):
                    self?.forgetPasswordAPIResult = .onSuccess(response: success)
                    
                    debugPrint("Success to user authenticate advance")
                    
                    if success.status == "0" {
                        self?.coordinator.openConfirmOtpScene(forgotType: .forgotPassword)
                    } else {
                        if requestModel.requestType == "E" {
                            SceneDelegate.getAppCoordinator()?.showMessage(type: .failure, "\("incorrect_email_entered".localized)")
                        } else if requestModel.requestType == "M" {
                            SceneDelegate.getAppCoordinator()?.showMessage(type: .failure, "\("incorrect_phone_entered".localized)")
                        }
                    }

                case .failure(let failure):
                    self?.forgetPasswordAPIResult = .onFailure(error: failure)
                        debugPrint("Failed to get user portfolio")
               
                }
            }
        }
    }

}
