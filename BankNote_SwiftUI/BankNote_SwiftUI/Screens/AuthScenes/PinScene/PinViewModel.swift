//
//  PinViewModel.swift
//  mahfazati
//
//  Created by Mohammmed on 11/08/2024.
//  Copyright © 2024 Mohammed Mathkour. All rights reserved.
//

import LocalAuthentication
import Foundation
import JavaScriptCore
import CryptoKit

class PinViewModel:ObservableObject{
    @Inject var userDefaultController : UserDefaultController?
    private let coordinator: AuthCoordinatorProtocol
    private let useCase: AuthUseCase
    private let getDeviceConfigsUseCase: GetDeviceConfigsUseCaseProtocol
   
    @Published var OTPModelAPIResult: APIResultType<otpUIModel>?
    @Published var GetDeviceConfigsAPIResult: APIResultType<GetDeviceConfigsUIModel>?
    @Published var pinsValue: String = ""
    @Published var isWrongPinInput: Bool = false
   
    init(coordinator: AuthCoordinatorProtocol , useCase : AuthUseCase, getDeviceConfigsUseCase: GetDeviceConfigsUseCaseProtocol) {
        self.coordinator = coordinator
        self.useCase = useCase
        self.getDeviceConfigsUseCase = getDeviceConfigsUseCase
        
        connectAndSetupSignalR()

    }
    
    func GetDeviceConfigs(success:Bool) {
        let requestModel = GetDeviceConfigsRequestModel()
        GetDeviceConfigsAPIResult = .onLoading(show: true)
        
        Task.init {
            await getDeviceConfigsUseCase.GetDeviceConfigs(requestModel: requestModel) {[weak self] result in
                self?.GetDeviceConfigsAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    self?.GetDeviceConfigsAPIResult = .onSuccess(response: success)
                    
                    UserDefaultController().iconPath = success.iconPath
                    UserDefaultController().BackgroundWatchList = success.BackgroundWatchList
                    UserDefaultController().sessiontimeoutPerSec = success.sessiontimeoutPerSec

                case .failure(let failure):
                    self?.GetDeviceConfigsAPIResult = .onFailure(error: failure)
                }
            }
        }
    }

    func checkPinValue(_ pinValue:String){
//        printToLog("checkPinValue pinValue:\(pinValue)")
        if isWrongPinInput {
            pinsValue = ""
        } else {
            pinsValue = pinValue
            KeyChainController().userPin = pinValue
        }
//        openWelcomeWithInvestInScene()
    }

    func forgetPassword(){

    }
    
    class LocalAuthenticationService {
        class func authenticateWithBiometrics(_ completion: @escaping (Result<Void, Error>) -> Void) {
            let context = LAContext()
            var error: NSError?

            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "We need to unlock your data."

                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                    if success {
                        completion(.success(()))
                    } else {
                        //completion(.failure(AppError.error(error?.localizedDescription ?? "Error Undefined")))
                        debugPrint("Error evaluating biometrics policy")
                    }
                }
            } else {
                //completion(.failure(AppError.error("No Biometrics Available")))
                debugPrint("Error: No biometrics available")
            }
        }
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

    func faceId(){
        if UserDefaultController().isBiometricEnabled ?? false {
            LocalAuthenticationService.authenticateWithBiometrics { result in
                        switch result {
                        case .success():
                            // If successful, unlock the view
                            //isUnlocked = true
                            DispatchQueue.main.async {
                                self.otpAPI(KeyChainController().userPin ?? "")
                            }
                        case .failure(let error):
                            // If failed, print the error message
                            print(error.localizedDescription)
                        }
                    }
        } else {
            SceneDelegate.getAppCoordinator()?.showMessage(type: .failure, "biometric_failed".localized)
        }
        
    }
    
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
    
    func otpAPI(_ pinValue:String )  {
        
        let email = KeyChainController.shared().savedUserEmail
        let phoneNo = KeyChainController.shared().savedUserPhoneNo
        let password = KeyChainController.shared().savedUserPassword
        var pin = pinValue
        
        let jsContext = JSContext()

        if jsContext != nil, let jsSourcePath = Bundle.main.path(forResource: "FiT_Encryption", ofType: "js") {
            do {
              
                let jsSourceContents = try String(contentsOfFile: jsSourcePath)
                
                jsContext!.evaluateScript(jsSourceContents)
                
                if let testFunction = jsContext!.objectForKeyedSubscript("encrypt"){
                    let encPin = (testFunction.call(withArguments: [pin])?.toString() ?? "")
//                    pin = encPin
                }
            }
            catch {
                printToLog("JS error:\(error.localizedDescription)")
            }
        }
        else {
            debugPrint ("error")
        }
        
        let OTPRequest = OTPRequestModel(emailAddress: encParam(item: email ?? "") , hdnKey: "", mobileNo: encParam(item: phoneNo ?? ""), mobileType: "", password: encParam(item: password ?? ""), sessionID: "", tokenID: encParam(item: pin), tradingNo: "" , userIPAddress: "10.0.2.15", userName: "", versionNumber: "", isAuthorizeOnly: "Y", fingerPrintID: "", fingerPrintLevel: "", FingerPrintEnabled: "", RegistrationId: "")
        
        
//        let OTPRequest = OTPRequestModel(emailAddress: "Test5458@test.com", hdnKey: "", mobileNo: "", mobileType: "", password: "Test@123", sessionID: "", tokenID: pin, tradingNo: "" , userIPAddress: "10.0.2.15", userName: "", versionNumber: "", isAuthorizeOnly: "Y", fingerPrintID: "", fingerPrintLevel: "", FingerPrintEnabled: "", RegistrationId: "")
                
        OTPModelAPIResult = .onLoading(show: true)
        Task.init {
            await useCase.OTPMap(requestModel: OTPRequest) {[weak self] result in
                self?.OTPModelAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    self?.userDefaultController?.username = success.userName
                    self?.OTPModelAPIResult = .onSuccess(response: success)
                    
                    KeyChainController.shared().webCode = success.webCode
                    UserDefaultController.instance.currentDate = self?.getCurrentDateString()
                    UserDefaultController.instance.yesterdayDate = self?.getYesterdayDateString()
                    KeyChainController.shared().brokerID = success.brokerID
                    KeyChainController.shared().UCODE = success.uCode
                    KeyChainController.shared().compInit = success.compInit
                    KeyChainController.shared().email = success.email
                    KeyChainController.shared().username = success.userName
                    KeyChainController.shared().userType = success.userType
                    UserDefaultController.instance.nameFullNameA = success.nameFullNameA
                    UserDefaultController.instance.nameFullNameE = success.nameFullNameE
                    KeyChainController.shared().mobileNo = success.mobileNo
                    UserDefaultController().isLoggedIn = true
                    UserDefaultController().isFirstLogin = false
                    
                    
                case .failure(let failure):

                    self?.OTPModelAPIResult = .onFailure(error: failure)               
                }
            }
        }
    }
}

func connectAndSetupSignalR() {
        if !Connection_Hub.shared.isConnected() {
            Connection_Hub.shared.setupHubSignalR()
            Connection_Hub.shared.connection?.start()
        }
}

extension PinViewModel{
    func openWelcomeWithInvestInScene(){
//        coordinator.openWelcomeWithInvestInScene()
    }
}

extension PinViewModel{
    func finishAndStartHomeFlow(){
        SceneDelegate.getAppCoordinator()?.showHomeFlow()
    }
}
