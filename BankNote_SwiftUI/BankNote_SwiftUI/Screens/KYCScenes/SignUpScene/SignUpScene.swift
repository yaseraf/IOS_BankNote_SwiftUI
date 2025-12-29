//
//  SignUpScene.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 15/09/2025.
//

import Foundation
import SwiftUI
import Combine

struct SignUpScene: BaseSceneType {
    @ObservedObject var viewModel: SignUpViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(backgroundType: .clear, contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, backgroundType: .gradient, content: {
                SignUpContentView(showPasswordField: $viewModel.showPasswordField, verifyWithEmail: $viewModel.verifyWithEmail, countryCodeUIModel: $viewModel.selectCountry, locationPermission: $viewModel.locationPermissionDenied, verificationType: $viewModel.verificationType, phone: $viewModel.phone, email: $viewModel.email, onBack: {
                    viewModel.popViewController()
                }, onContinueTap: { uiModel, verifyWithEmail, phoneNumber, email, password in
                    if !verifyWithEmail {
//                        KeyChainController.shared().phoneNumberEntered = phoneNumber
                        
                        viewModel.sendPhoneOtpValifyAPI(phoneNumber: phoneNumber)
//                        if $viewModel.showPasswordField.wrappedValue == false {
//                            viewModel.checkEmailOrPhoneExistence(email: email, phoneNumber: phoneNumber, password: password, uiModel: uiModel, verifyWithEmail: verifyWithEmail)
//                        } else {
//                            viewModel.loginVlensAPI(success: true, phoneNumber: phoneNumber, password: password, uiModel: uiModel, verifyWithEmail: verifyWithEmail)
//                        }
                    } else {
                        viewModel.sendEmailOtpValifyAPI(email: email)
//                        if $viewModel.showPasswordField.wrappedValue == false {
//                            viewModel.stepVerifyEmailAPI(success: true, email: email, emailOtp: "", emailOtpRequestId: "", requestId: KeyChainController().verifyPhoneOtpRequestId ?? "", uiModel: uiModel, verifyWithEmail: verifyWithEmail)
//                        }
                    }
                }, onCountryPickerTap: { countryData in
                    viewModel.openCountryPickerScene(countryModel: countryData)
                }, onLocationAlertTap: {
                    viewModel.popViewController()
                })
            })
        }, showLoading: .constant(viewTypeAction.showLoading))
        .onAppear {
            // Dont call getAccessToken when going to Email
//            if viewModel.verifyWithEmail == false {
//                viewModel.getAccessTokenAPI(success: true)
//            }
        }
        .onViewDidLoad {
            UserData.shared.locManager.requestWhenInUseAuthorization()
            UserData.shared.locManager.startUpdatingLocation()
//            getAccessTokenAPI()
//            stepVerifyPhoneAPI()
//            stepVerifyEmailAPI()
//            loginVlensAPI()
            
            sendPhoneOtpValifyAPI()
            sendEmailOtpValifyAPI()
        }
        
    }
    
    // MARK: VALIFY
    
    private func sendPhoneOtpValifyAPI() {
        viewModel.$sendPhoneOtpValifyAPIResult.receive(on: DispatchQueue.main).sink { result  in
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
    
    private func sendEmailOtpValifyAPI() {
        viewModel.$sendEmailOtpValifyAPIResult.receive(on: DispatchQueue.main).sink { result  in
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


    
    // MARK: VLENS
    
    private func loginVlensAPI() {
        viewModel.$loginVlensAPIResult.receive(on: DispatchQueue.main).sink { result  in
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
    
    private func getAccessTokenAPI() {
        viewModel.$getAccessTokenAPIResult.receive(on: DispatchQueue.main).sink { result  in
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
    
    private func stepVerifyPhoneAPI() {
        viewModel.$stepVerifyPhoneAPIResult.receive(on: DispatchQueue.main).sink { result  in
            switch result{
            case .onFailure(let error):
                SceneDelegate.getAppCoordinator()?.showMessage(type: .failure,error.text)
            case.onLoading(let show):
                viewTypeAction.showLoading = show
            case.onSuccess(let response):
                debugPrint("")
                
            case .none:
                break
            }

        }.store(in: &anyCancellable)
    }
    
    private func stepVerifyEmailAPI() {
        viewModel.$stepVerifyEmailAPIResult.receive(on: DispatchQueue.main).sink { result  in
            switch result{
            case .onFailure(let error):
                SceneDelegate.getAppCoordinator()?.showMessage(type: .failure,error.text)
            case.onLoading(let show):
                viewTypeAction.showLoading = show
            case.onSuccess(let response):
                debugPrint("")

            case .none:
                break
            }

        }.store(in: &anyCancellable)
    }
}
