//
//  LandingViewModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 21/07/2025.
//

import Foundation
import UIKit
import JavaScriptCore
import FlagAndCountryCode
import CryptoKit

class LandingViewModel:ObservableObject {
    private var coordinator: AuthCoordinatorProtocol
    private var useCase: AuthUseCase
    
    @Published var LoginResponseModelAPIResult: APIResultType<LoginUIModel>?
    
    init(coordinator: AuthCoordinatorProtocol, useCase: AuthUseCase) {
        self.coordinator = coordinator
        self.useCase = useCase
//        for family in UIFont.familyNames {
//            for name in UIFont.fontNames(forFamilyName: family) {
//                print(name)
//            }
//        }
        
    }
    
    func encParam(item:String) -> String {
        if item.isEmpty {
            return ""
        }
        
        let keyBase64 = "QfK0X0S8jz3k8HV3mQ4bnJ6Z6qA9KIMCE5TFs8FVbQY="
        let nonceBase64 = "T0aXZtrI3JcH39bs"
                 
        let keyData = Data(base64Encoded: keyBase64)!
        let nonceData = Data(base64Encoded: nonceBase64)!
        let key = SymmetricKey(data: keyData)
         
        let nonce = try? AES.GCM.Nonce(data: nonceData)
        let plaintextData = item.data(using: .utf8)!
         
        let sealedBox = try? AES.GCM.seal(plaintextData, using: key, nonce: nonce)
         
        let ciphertextBase64 = sealedBox?.ciphertext.base64EncodedString()
        let tagBase64 = sealedBox?.tag.base64EncodedString()
        
        return "\(ciphertextBase64 ?? "")!\(tagBase64 ?? "")"
    }
    
}

// MARK: Routing
extension LandingViewModel {
    func openSignUpScene() {
        coordinator.openSignUpScene(verificationType: .phone)
    }
    
    func openLoginScene() {
        SceneDelegate.getAppCoordinator()?.startFlow(startWith: .login)
    }
    
    func openForgotPasswordScene() {
        coordinator.openForgotPasswordScene(forgotType: .forgotPassword)
    }
    
    func openHomeScene() {
        AppUtility.shared.updateAppLanguage(language: .english)
        AppUtility.shared.applyDeviceLanguageIfNeeded()
        SceneDelegate.getAppCoordinator()?.showHomeFlow()
    }
    
    func openPinScene() {
        coordinator.openPinScene()
    }

}

// MARK: API Calling
extension LandingViewModel {
    func UsrAuthinticationByEmailAndMobileAPI(email : String = "" , phoneNo : String  , Password : String, isRememberMe: Bool)  {
        
        // MARK: - Save email & password in keychain
        KeyChainController().savedUserPhoneNo = phoneNo.replacingOccurrences(of: "+", with: "")
        KeyChainController().savedUserEmail = email
        KeyChainController().savedUserPassword = Password
        
         var email = email
        var phoneNo = phoneNo
        var password1 = Password
 
        let jsContext = JSContext()

        if jsContext != nil, let jsSourcePath = Bundle.main.path(forResource: "FiT_Encryption", ofType: "js") {
            do {
              
                let jsSourceContents = try String(contentsOfFile: jsSourcePath)
                
                jsContext!.evaluateScript(jsSourceContents)
                
                if let testFunction = jsContext!.objectForKeyedSubscript("encrypt"){
                    if email != "" {
                      
                        var encEmail = (testFunction.call(withArguments: [email])?.toString() ?? "")

                        KeyChainController.shared().email = email
                        KeyChainController.shared().mobileNo = ""
                    }
                    
                    if phoneNo != ""{
                        phoneNo.removeFirst()
                        print (phoneNo)
                        let encPhone = (testFunction.call(withArguments: [phoneNo])?.toString() ?? "")
                        KeyChainController.shared().mobileNo = encPhone
                        KeyChainController.shared().email = ""
                       }
                    
                    let encpassword = (testFunction.call(withArguments: [password1])?.toString() ?? "")

                    KeyChainController.shared().password = password1
   
                }
            }
            catch {
                printToLog("JS error:\(error.localizedDescription)")
            }
        }
        else {
            debugPrint ("error")
        }
        
        let loginRequest = LoginRequestModel(
            emailAddress: encParam(item: email),
            hdnKey: "",
            fingerPrintId: "",
            mainClientID: "",
            mobileNo: encParam(item: phoneNo),
            mobileType: "iOS/unrecognized/17.3.1/V.1",
            newUser: "",
            oldPassword: "",
            password: encParam(item: password1),
            password2: "",
            registrationId: "dLy7NdV_7UPosCQkg0rZ5U:APA91bHV9cChNcmI6vIiPrlOO1eL0tH4VgCZ8Ob6A6QU0tsWnPhQb76hEVNkGJCr1y-6qiP36rWQeTpZDS0XQDUQ-LxybMJonZVZyvKMAoRIDa66_4eexYsKTVUQEL5X7yuEbi4f0cty",
            sessionID: "",
            tokenID: "",
            touchToken: "",
            tradingNo: "",
            userIPAddress: "192.168.68.118",
            userName: "",
            versionNumber: "1",
            webCode: "",
            isAuthorizeOnly: "N"
        )
                       
        LoginResponseModelAPIResult = .onLoading(show: true)
        Task.init {
            await useCase.loginMap(requestModel: loginRequest) {[weak self] result, cookies in
                self?.LoginResponseModelAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):

                    if success.isFirstLogin?.lowercased() ?? "" == "y" {
                        KeyChainController().resetPasswordCookies = "\(cookies?.filter({$0.name == ".ASPXAUTH"}).first?.name ?? "")=\(cookies?.filter({$0.name == ".ASPXAUTH"}).first?.value ?? "")"
                        KeyChainController().username = success.userName ?? ""
                        
                        UserDefaultController().isFirstLogin = true

//                        self?.openResetPasswordScene(cookies: cookies)
                    }
                    
                    KeyChainController().username = success.userName ?? ""

//                    SceneDelegate.getAppCoordinator()?.showMessage(type: .success, "login_success".localized)
                    self?.LoginResponseModelAPIResult = .onSuccess(response: success)
                    
                case .failure(let failure):

                        self?.LoginResponseModelAPIResult = .onFailure(error: failure)
               
                }
            }
        }
    }

}
