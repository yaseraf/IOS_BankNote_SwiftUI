//
//  LandingScene.swift
//  QSC_SwiftUI
//
//  Created by FIT on 21/07/2025.
//

import Foundation
import SwiftUI
import Combine

struct LandingScene: BaseSceneType {
    @ObservedObject var viewModel: LandingViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, backgroundType: .gradient, content: {
                LandingContentView(onLanguageSelected: {
                    viewModel.openLoginScene()
                }, onForgotPasswordTap: {
                    viewModel.openForgotPasswordScene()
                }, onLoginTap: { email, password, isRememberMe in
//                    viewModel.openPinScene()
                    viewModel.UsrAuthinticationByEmailAndMobileAPI(email: email, phoneNo: "", Password: password, isRememberMe: isRememberMe)
//                    viewModel.UsrAuthinticationByEmailAndMobileAPI(email: "Mohamed.kamal@cicapital.com", phoneNo: "", Password: "Mahfazty@123", isRememberMe: isRememberMe)
                }, onSignUpTap: {
                    viewModel.openSignUpScene()
                })
            })
        }, showLoading: .constant(viewTypeAction.showLoading))
        .onAppear {
            viewModel.callUrlIPAddressAPI(success: true)
        }
        .onViewDidLoad {
            loginAPI()
            UrlIpAddressAPI()
        }
    }
    
    private func UrlIpAddressAPI() {
        viewModel.$urlAPIAddressAPIResult.receive(on: DispatchQueue.main).sink { result  in
            switch result{
            case .onFailure(let error):
                SceneDelegate.getAppCoordinator()?.showMessage(type: .failure,error.text)
            case.onLoading(let show):
                viewTypeAction.showLoading = show
            case.onSuccess(_):
                debugPrint("Loading..")
                

            case .none:
                break
            }

        }.store(in: &anyCancellable)
    }

    
    private func loginAPI() {
        viewModel.$LoginResponseModelAPIResult.receive(on: DispatchQueue.main).sink { result  in
            switch result{
            case .onFailure(let error):
                SceneDelegate.getAppCoordinator()?.showMessage(type: .failure,error.text)
            case.onLoading(let show):
                viewTypeAction.showLoading = show
            case.onSuccess(let data):
                
//                KeyChainController.shared().webCode = data.webCode
//                UserDefaultController.instance.currentDate = getCurrentDateString()
//                UserDefaultController.instance.yesterdayDate = getYesterdayDateString()
//                UserDefaultController.instance.brokerID = data.brokerID
//                UserDefaultController.instance.UCODE = data.uCode
//                UserDefaultController.instance.compInit = data.compInit
//                UserDefaultController.instance.email = data.email
//                UserDefaultController.instance.username = data.userName
//                UserDefaultController.instance.userType = data.userType
//                UserDefaultController.instance.nameFullNameA = data.nameFullNameA
//                UserDefaultController.instance.nameFullNameE = data.nameFullNameE
//                UserDefaultController.instance.mobileNo = data.mobileNo
//
//
//                UserDefaultController().isLoggedIn = true
//                UserDefaultController().isFirstLogin = false
               
                  var isAllGood = true
                  var msg = ""
                  
                  let status = Int(data.status ?? "") ?? 0
                  if(!(data.errorMsg ?? "").isEmpty) {
                      isAllGood = false
                      msg = (data.errorMsg ?? "")
                  }
                  else if status < 0 {
                      isAllGood = false
                      
                      if(status == loginState.invalidLogin) {
                          msg = "invalid_username_password".localized // "Status = -1, invalidLogin"
                      }
                      else if(status == loginState.invalidTokenID) {
                          msg =  "invalid_token_ID".localized  // "Status = -2, invalidTokenID"
                      }
                      else if(status == loginState.tokenSent) {
                          msg = "please_enter_token".localized // "Status = -3, tokenSent"
                      }
                      else if(status == loginState.tokenExpire) {
                          msg = "token_expired".localized // "Status = -4, tokenExpire"
                      }
                      else if(status == loginState.noPermetions) {
                          msg = "no_permissions".localized // "Status = -5, noPermetions"
                      }
                      else if(status == loginState.userLocked) {
                          msg = "user_locked".localized // "Status = -6, userLocked"
                      }
                      else if(status == loginState.anotherUserLogin) {
                          msg = "user_already_logged_in".localized // "Status = -7, anotherUserLogin"
                      }
                      else if(status == loginState.userNotAgreeTermCondtion) {
                          msg = "not_agreed_terms_conditions".localized // "Status = -8, userNotAgreeTermCondtion"
                      }
                      else if(status == loginState.unknowError) {
                          msg = "Status = -10, unknowError"
                      }
                      else if((data.webCode ?? "").elementsEqual("-1")) {
                          msg = "webCode = -1"
                      }
                      else {
                          msg = "Status = " + String(status)
                      }
                  }
                  else if((data.webCode ?? "").elementsEqual("-1")) {
                      isAllGood = false
                      msg = "WebCode = -1"
                  }
                  else if((data.webCode ?? "").isEmpty) {
                      isAllGood = false // true false
                      msg = "WebCode is Empty"
                  }
                                    
                  if status == -3 {
//                      let newMsg = "success \(String(describing: Date().toString(dateFormat: .MMMdd_yyyy)))"
//                      SceneDelegate.getAppCoordinator()?.showMessage(type: .success,msg)
   
                      if data.isFirstLogin?.lowercased() ?? "" == "y" {
                        
                      } else if data.isFirstLogin?.lowercased() ?? "" == "n" {
                          DispatchQueue.main.async {
                              viewModel.openPinScene()
                          }
                      }
                      
                  }
                  else if !isAllGood {
                      
                      if ((msg == "WebCode = -1") || (msg == "WebCode is Empty"))  {
                          msg = NSLocalizedString("request_rejected", comment: "")
                      }
                      
                      let newMsg = "success \(String(describing: Date().toString(dateFormat: .MMMdd_yyyy)))"
                      SceneDelegate.getAppCoordinator()?.showMessage(type: .failure,msg)
                      
                  }

            case .none:
                break
            }

        }.store(in: &anyCancellable)
    }

}
