//
//  ChangePasswordViewModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 23/07/2025.
//

import Foundation
import JavaScriptCore

class ChangePasswordViewModel: ObservableObject {
    private var coordinator: AuthCoordinator
    private var useCase: AuthUseCaseProtocol
    
    @Published var ChangePasswordResponseModelAPIResult: APIResultType<changePasswordUIModel>?

    init(coordinator: AuthCoordinator, useCase: AuthUseCaseProtocol) {
        self.coordinator = coordinator
        self.useCase = useCase
    }
    
    func onBack() {
        coordinator.popViewController(animated: true)
    }
    
    func onConfirmChangePassword(oldPassword: String, newPassword: String, pin: String) {
//        coordinator.popMultipleViews(count: 2, animated: true)
        callChangePasswordAPI(oldPassword: oldPassword, newPassword: newPassword, pin: pin)
    }
}

// MARK: Functions
extension ChangePasswordViewModel {
    
}

// MARK: API Call
extension ChangePasswordViewModel {
    func callChangePasswordAPI( oldPassword : String  , newPassword : String, pin:String )  {
        

        var oldPassword = oldPassword // "971501076610"  // phoneNo
        var newPassword =  newPassword    //"NEDAL"
        var encNewPassword: String = ""
        var pinValue: String = ""
        var username = UserDefaultController().username ?? ""
        let jsContext = JSContext()

//        if KeyChainController().savedUserPassword ?? "" == newPassword {
//            SceneDelegate.getAppCoordinator()?.showMessage(type: .failure, "\("please_choose_new_password".localized)")
//            return
//        }
        
//        printToLog(" cUser:\(username)")
//        printToLog(" oldPassword:\(oldPassword)")
//        printToLog(" newPassword:\(newPassword)")
        
        print(jsContext == nil ) // false
      
        if jsContext != nil, let jsSourcePath = Bundle.main.path(forResource: "FiT_Encryption", ofType: "js") {
            do {
              
                let jsSourceContents = try String(contentsOfFile: jsSourcePath)
                
                jsContext!.evaluateScript(jsSourceContents)
                
                if let testFunction = jsContext!.objectForKeyedSubscript("encrypt"){
                    let encUser = (testFunction.call(withArguments: [username])?.toString() ?? "")
                    let encOldPassword = (testFunction.call(withArguments: [oldPassword])?.toString() ?? "")
                    let encPin = (testFunction.call(withArguments: [pinValue])?.toString() ?? "")
                    encNewPassword = (testFunction.call(withArguments: [newPassword])?.toString() ?? "")

                    username = encUser
                    oldPassword = encOldPassword
//                    pinValue = encPin
                 
                }
            }
            catch {
                printToLog("JS error:\(error.localizedDescription)")
            }
        }
        else {
            print ("error")
        }
        
        let loginRequest = ChangePasswordRequestModel(UserName: UserDefaultController().username ?? "", Password: encNewPassword, Password2: pin, MobileType: "iOS_native", SessionID: "", UserIPAddress: "109.107.237.83", TokenID: "", WebCode: KeyChainController.shared().webCode ?? "", OldPassword: oldPassword)
        
        print (loginRequest)
       
        ChangePasswordResponseModelAPIResult = .onLoading(show: true)
        Task.init {
            await useCase.ChangesPassword(requestModel: loginRequest) {[weak self] result in
                self?.ChangePasswordResponseModelAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                 
                    self?.ChangePasswordResponseModelAPIResult = .onSuccess(response: success)
                    
                    if success.status == "-1" {
                        SceneDelegate.getAppCoordinator()?.showMessage(type: .failure, "\(success.errorMsg ?? "")")
                        debugPrint("reset password failed, status: \(success.status), \(success.errorMsg)")
                    } else {
                        KeyChainController().savedUserPassword = newPassword
                        SceneDelegate.getAppCoordinator()?.showMessage(type: .success, "\("success".localized)")

    //                    self?.coordinator.finishAndBackToLoginScene()
                       self?.coordinator.dismiss(complete: {
                           SceneDelegate.getAppCoordinator()?.logout()
                       })
                    }
                    


                    
                      
                case .failure(let failure):
                    debugPrint("reset password failed")

                        self?.ChangePasswordResponseModelAPIResult = .onFailure(error: failure)
                    
                    SceneDelegate.getAppCoordinator()?.showMessage(type: .failure, "\(failure)")

//                        self?.coordinator.finishAndBackToLoginScene()
//                    self?.coordinator.dismiss(complete: {
//                        SceneDelegate.getAppCoordinator()?.logout()
//                    })
//
                }
            }
        }
    }

}
