//
//  PinScene.swift
//  mahfazati
//
//  Created by Mohammmed on 11/08/2024.
//  Copyright © 2024 Mohammed Mathkour. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
struct PinScene: BaseSceneType{
    @ObservedObject var viewModel: PinViewModel
    
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType  = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene( backgroundType: .colorBGSecondary,contentView: {
            BaseContentView(withScroll:false, content: {
                PinContentView(isWrongPinInput: $viewModel.isWrongPinInput, pinsValue: $viewModel.pinsValue.wrappedValue, onPinTextFilled: {pinValue in
                   viewModel.checkPinValue(pinValue)
                    viewModel.otpAPI(pinValue)
                }, onForgetTap: {
                    viewModel.forgetPassword()

                }, onFaceIdTap: {
                    viewModel.faceId()

                }, onFailure: {
                    
                })
            })
        }, showLoading: .constant(viewTypeAction.showLoading))
        .onViewDidLoad(){
     OTPAPI()
            viewModel.GetDeviceConfigs(success: true)
        }

    }
    private func OTPAPI() {
        viewModel.$OTPModelAPIResult.receive(on: DispatchQueue.main).sink { result  in
            switch result{
            case .onFailure(let error):
                SceneDelegate.getAppCoordinator()?.showMessage(type: .failure,error.text)
            case.onLoading(let show):
                viewTypeAction.showLoading = show
            case.onSuccess(let data ):
                if data.status == "0" {
//                    let newMsg = "success \(String(describing: Date().toString(dateFormat: .MMMdd_yyyy)))"

//                        SceneDelegate.getAppCoordinator()?.showMessage(type: .success,newMsg)
                            
                    var isUserSaved = false
                    
                    for item in UserData.shared.savedEntities {
                        if (item.userWithSelection == (UserDefaultController().username ?? "") + "stocks" ) || (item.userWithSelection == (UserDefaultController().username ?? "") + "mutualFundsAndBonds" ){
                            isUserSaved = true
                            break
                        }
                    }
                    
                    viewModel.finishAndStartHomeFlow()
//                    if isUserSaved {
//                        viewModel.finishAndStartHomeFlow()
//                    } else {
//                        viewModel.openWelcomeWithInvestInScene()
//                    }
                    
                } else {
                    // Invalid OTP
//                    let newMsg = "success \(String(describing: Date().toString(dateFormat: .MMMdd_yyyy)))"
                    SceneDelegate.getAppCoordinator()?.showMessage(type: .failure, "invalid_pin".localized)

                }
            case .none:
                break
            }

        }.store(in: &anyCancellable)
    }
}
