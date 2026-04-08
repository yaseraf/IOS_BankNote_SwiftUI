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
    private var homeUseCase: HomeUseCaseProtocol
    
    @Published var LoginResponseModelAPIResult: APIResultType<LoginUIModel>?
    @Published var urlAPIAddressAPIResult: APIResultType<UrlIPAddressResponseModel>?
    @Published var getTiersAPIResult: APIResultType<GetTiersUIModel>?

    init(coordinator: AuthCoordinatorProtocol, useCase: AuthUseCase, homeUseCase: HomeUseCaseProtocol) {
        self.coordinator = coordinator
        self.useCase = useCase
        self.homeUseCase = homeUseCase
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
        // MARK: Primary
        coordinator.openSignUpScene(verificationType: .phone, verifyWithEmail: false)
        
//        coordinator.openQuestioneerScene()
//        coordinator.openScanIDFrontScene()
//        coordinator.openCameraPreviewFor(type: .scanMode(.nationalId), savedImageOne: nil, stepIndexBind: 0, isFrontBind: true)
//        coordinator.openVerifyIDConfirmation()
//        coordinator.openLoginInformationScene()
//        coordinator.openSetPasswordScene()
//        coordinator.openQuestionsScene()
//        coordinator.openScanIDFrontScene(type: .scanMode(.nationalId), savedImageOne: nil, stepIndexBind: 0, isFrontBind: true)
//        coordinator.openLivenessCheckScene()
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
    
    func openCreatePinScene(cookies: [HTTPCookie]?) {
        coordinator.openCreatePinScene(cookies: cookies)
    }

}

// MARK: Functions
extension LandingViewModel {
    func getCurrentDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ddMMyyyyHHmmss"
        var dateComponents = DateComponents()
        dateComponents.day = -1
        let currentDate = Date()
        let dateString = dateFormatter.string(from: currentDate)
        return dateString
    }
    
    func getYesterdayDateString() -> String {
        var dayComponent = DateComponents()
            dayComponent.day = -365
            let calendar = Calendar.current
            let nextDay =  calendar.date(byAdding: dayComponent, to: Date())!
            let formatter = DateFormatter()
            formatter.locale = .current
            formatter.dateFormat = "ddMMyyyyHHmmss"
            return formatter.string(from: nextDay)
    }
}

// MARK: API Calling
extension LandingViewModel {
    func callUrlIPAddressAPI(success:Bool) {
        urlAPIAddressAPIResult = .onLoading(show: true)
        Task.init {
            await useCase.urlIPAddress(requestModel: "") {[weak self] result in
                self?.urlAPIAddressAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    self?.urlAPIAddressAPIResult = .onSuccess(response: success)
                    
                    if success.origin?.isEmpty == true {
                        SceneDelegate.getAppCoordinator()?.showMessage(type: .failure, "Sorry, We Cannot get you IP Address, Please Close VPN if you use and try again")
                    } else {
                        UserDefaultController().userIPAddress = success.origin ?? ""
                    }
                    
                case .failure(let failure):
                    self?.urlAPIAddressAPIResult = .onFailure(error: failure)
                }
            }
        }
    }
    
    func callGetTiersAPI(success:Bool) {
        let requestModel = GetTiersRequestModel(WebCode: KeyChainController().webCode ?? "")
        
        getTiersAPIResult = .onLoading(show: true)
        
        Task.init {
            await homeUseCase.GetTiers(requestModel: requestModel) {[weak self] result in
                self?.getTiersAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    self?.getTiersAPIResult = .onSuccess(response: success)
                    debugPrint("get tiers success")
                    
                    let myTier = success.data?.filter({$0.code == UserDefaultController().tierCode ?? ""}).first
                    
                    if myTier?.ALLOW_MARGIN?.lowercased() == "y" {
                        UserDefaultController().isMarginableAccount = "y"
                    } else {
                        UserDefaultController().isMarginableAccount = "n"
                    }

                    
                case .failure(let failure):
                        self?.getTiersAPIResult = .onFailure(error: failure)
                    debugPrint("get tiers failed")
                }
            }
        }
    }

    
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
            mobileType: "iOS/\(UIDevice.current.identifierForVendor?.uuidString ?? "")/OS Version: \(UIDevice.current.systemVersion)/App Version: \(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "0.0.0")",
            newUser: "",
            oldPassword: "",
            password: encParam(item: password1),
            password2: "",
            registrationId: "dLy7NdV_7UPosCQkg0rZ5U:APA91bHV9cChNcmI6vIiPrlOO1eL0tH4VgCZ8Ob6A6QU0tsWnPhQb76hEVNkGJCr1y-6qiP36rWQeTpZDS0XQDUQ-LxybMJonZVZyvKMAoRIDa66_4eexYsKTVUQEL5X7yuEbi4f0cty",
            sessionID: "",
            tokenID: "",
            touchToken: "",
            tradingNo: "",
            userIPAddress: "212.35.74.210",
            userName: "",
            versionNumber: "100",
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
                    
//                    KeyChainController().loginCookieName = cookies?.filter({$0.name == ".ASPXAUTH"}).first?.name ?? ""
//                    KeyChainController().loginCookieValue = cookies?.filter({$0.name == ".ASPXAUTH"}).first?.value ?? ""

                    
                    if success.isFirstLogin?.lowercased() ?? "" == "y" {
                        
                        KeyChainController().resetPasswordCookies = "\(cookies?.filter({$0.name == ".ASPXAUTH"}).first?.name ?? "")=\(cookies?.filter({$0.name == ".ASPXAUTH"}).first?.value ?? "")"
                        KeyChainController().username = success.userName ?? ""
                        KeyChainController().webCode = success.webCode ?? ""
                        
                        if success.status == "0" || success.status == "-3" {
                            UserDefaultController().isFirstLogin = true
                            self?.openCreatePinScene(cookies: cookies)
                            
                            return
                        }

//                        self?.openResetPasswordScene(cookies: cookies)
                    }

                    KeyChainController().username = success.userName ?? ""
                    UserDefaultController().tierCode = success.TIERS_CODE ?? ""
                    UserDefaultController().mainBadgeCodes = success.MAIN_BADGES_CODE ?? ""
                    UserDefaultController().subBadgeCodes = success.SUB_BADGES_CODE ?? ""
                    UserDefaultController().birthdate = success.BIRTHDATE ?? ""
                    UserDefaultController().gender = success.GENDER ?? ""

                    self?.callGetTiersAPI(success: true)

//                    SceneDelegate.getAppCoordinator()?.showMessage(type: .success, "login_success".localized)
                    self?.LoginResponseModelAPIResult = .onSuccess(response: success)
                    
                case .failure(let failure):

                    self?.LoginResponseModelAPIResult = .onFailure(error: failure)
               
                }
            }
        }
    }

}
