//
//  LoginViewModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 21/07/2025.
//

import Foundation
import JavaScriptCore
import CryptoKit

class LoginViewModel: ObservableObject {
    private var coordinator: AuthCoordinatorProtocol
    private let useCase: LoginUseCaseProtocol

    @Published var LoginResponseModelAPIResult: APIResultType<LoginUIModel>?

    
    init(coordinator: AuthCoordinatorProtocol, useCase: LoginUseCaseProtocol) {
        self.coordinator = coordinator
        self.useCase = useCase
    }
    
    func openForgotPasswordScene() {
        coordinator.openForgotPasswordScene(forgotType: .forgotPassword)
    }
    
    func openForgotNameScene() {
        coordinator.openForgotPasswordScene(forgotType: .forgotName)
    }
    
    func changeLanguage() {
        AppUtility.shared.updateAppLanguage(language: AppUtility.shared.isRTL ? .english : .arabic)
        SceneDelegate.getAppCoordinator()?.restart()
    }
    
    func openVerifyOtpScene(username: String, password: String) {
        
        var username1 = username
        var password1 = password
        
        let jsContext = JSContext()

        if jsContext != nil, let jsSourcePath = Bundle.main.path(forResource: "FiT_Encryption", ofType: "js") {
            do {
              
                let jsSourceContents = try String(contentsOfFile: jsSourcePath)
                
                jsContext!.evaluateScript(jsSourceContents)
                
                if let testFunction = jsContext!.objectForKeyedSubscript("encrypt"){
                    if username != "" {
                      
                        var encUsername = (testFunction.call(withArguments: [username])?.toString() ?? "")

                        username1 = encUsername
                        KeyChainController.shared().email = username
                        KeyChainController.shared().mobileNo = ""
                    }
                    
                    let encpassword = (testFunction.call(withArguments: [password1])?.toString() ?? "")
                    
                    password1 = encpassword
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
        
        coordinator.openVerifyOtpScene(username: username1, password: password1)
    }
    
    func callUsrAuthinticationByEmailAndMobileAPI(username:String, password:String, isRememberMe:Bool) {

        // MARK: - Save email & password in keychain
        KeyChainController().savedUserEmail = username
        KeyChainController().savedUserPassword = password
        
        var username = username
        var password1 = password
 
        let jsContext = JSContext()

        if jsContext != nil, let jsSourcePath = Bundle.main.path(forResource: "FiT_Encryption", ofType: "js") {
            do {
              
                let jsSourceContents = try String(contentsOfFile: jsSourcePath)
                
                jsContext!.evaluateScript(jsSourceContents)
                
                if let testFunction = jsContext!.objectForKeyedSubscript("encrypt"){
                    if username != "" {
                      
                        var encUsername = (testFunction.call(withArguments: [username])?.toString() ?? "")

                        username = encUsername
                        KeyChainController.shared().email = username
                        KeyChainController.shared().mobileNo = ""
                    }
                    
                    let encpassword = (testFunction.call(withArguments: [password1])?.toString() ?? "")
                    
                    password1 = encpassword
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
            emailAddress: "",
            hdnKey: "",
            fingerPrintId: "",
            mainClientID: "",
            mobileNo: "",
            mobileType: "iOS/unrecognized/17.3.1/V.1",
            newUser: "",
            oldPassword: "",
            password: password1,
            password2: "",
            registrationId: "dLy7NdV_7UPosCQkg0rZ5U:APA91bHV9cChNcmI6vIiPrlOO1eL0tH4VgCZ8Ob6A6QU0tsWnPhQb76hEVNkGJCr1y-6qiP36rWQeTpZDS0XQDUQ-LxybMJonZVZyvKMAoRIDa66_4eexYsKTVUQEL5X7yuEbi4f0cty",
            sessionID: "",
            tokenID: "",
            touchToken: "",
            tradingNo: "",
            userIPAddress: AppUtility.shared.getAddress(for: .wifi) ?? "",
            userName: username,
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
                    
                    KeyChainController().authToken = cookies?.filter({$0.name == ".ASPXAUTH"}).first?.value ?? ""
                    KeyChainController().loginCookieName = cookies?.filter({$0.name == ".ASPXAUTH"}).first?.name ?? ""
                    KeyChainController().loginCookieValue = cookies?.filter({$0.name == ".ASPXAUTH"}).first?.value ?? ""



                    if success.isFirstLogin?.lowercased() ?? "" == "y" {
                        KeyChainController().resetPasswordCookies = "\(cookies?.filter({$0.name == ".ASPXAUTH"}).first?.name ?? "")=\(cookies?.filter({$0.name == ".ASPXAUTH"}).first?.value ?? "")"
                        KeyChainController().username = success.userName ?? ""
                        KeyChainController().webCode = success.webCode ?? ""
                        UserDefaultController().isFirstLogin = true

//                      self?.openResetPasswordScene(cookies: cookies)
                    }
                    
                    self?.LoginResponseModelAPIResult = .onSuccess(response: success)
                    
                case .failure(let failure):

                    self?.LoginResponseModelAPIResult = .onFailure(error: failure)
               
                }
            }
        }
    }
}
