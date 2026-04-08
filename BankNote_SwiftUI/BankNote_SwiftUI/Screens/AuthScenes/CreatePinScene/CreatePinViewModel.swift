//
//  CreatePinViewModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 05/04/2026.
//

import Foundation
import SwiftUI
import JavaScriptCore
import CryptoKit

class CreatePinViewModel: ObservableObject {
    private var coordinator: AuthCoordinator
    private var useCase: AuthUseCaseProtocol

    @Published var ChangePinResponseModelAPIResult: APIResultType<changePinUIModel>?

    var cookies: [HTTPCookie]?
    
    init(coordinator: AuthCoordinator, useCase: AuthUseCaseProtocol, cookies: [HTTPCookie]?) {
        self.coordinator = coordinator
        self.useCase = useCase
        self.cookies = cookies

    }
    
    func changePin(pin:String)  {
        
        var newPin = pin
        var webCode = KeyChainController.shared().webCode ?? ""
        
        let jsContext = JSContext()
      
        if jsContext != nil, let jsSourcePath = Bundle.main.path(forResource: "FiT_Encryption", ofType: "js") {
            do {
              
                let jsSourceContents = try String(contentsOfFile: jsSourcePath)
                
                jsContext!.evaluateScript(jsSourceContents)
                
                if let testFunction = jsContext!.objectForKeyedSubscript("encrypt"){
                    let encPin = (testFunction.call(withArguments: [newPin])?.toString() ?? "")
                    let encWebCode = (testFunction.call(withArguments: [webCode])?.toString() ?? "")
                    
                    newPin = encPin
                    webCode = encWebCode
                 
                }
            }
            catch {
                printToLog("JS error:\(error.localizedDescription)")
            }
        }
        else {
            print ("error")
        }
        
        let loginRequest = ChangePinRequestModel(
            UserName: "",
            Password: "",
            Password2: newPin,
            MobileType: "iOS_native",
            SessionID: "",
            UserIPAddress: "109.107.237.83",
            TokenID: "",
            WebCode: webCode,
            OldPassword: ""
        )
               
        ChangePinResponseModelAPIResult = .onLoading(show: true)
        
        Task.init {
            await useCase.ChangePin(requestModel: loginRequest) {[weak self] result in
                self?.ChangePinResponseModelAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                 
                    self?.ChangePinResponseModelAPIResult = .onSuccess(response: success)
                    
                    if success.status == "-1" {
                        SceneDelegate.getAppCoordinator()?.showMessage(type: .failure, "\(success.errorMsg ?? "")")
                        debugPrint("reset password failed, status: \(success.status), \(success.errorMsg)")
                    } else {
                        SceneDelegate.getAppCoordinator()?.showMessage(type: .success, "\("success".localized)")

                       self?.coordinator.dismiss(
                          complete: {
                              SceneDelegate.getAppCoordinator()?.logout()
                          }
                       )
                    }
                      
                case .failure(let failure):
                    debugPrint("reset password failed")

                    self?.ChangePinResponseModelAPIResult = .onFailure(error: failure)
                    
                    SceneDelegate.getAppCoordinator()?.showMessage(type: .failure, "\(failure)")
                }
            }
        }
    }
}
