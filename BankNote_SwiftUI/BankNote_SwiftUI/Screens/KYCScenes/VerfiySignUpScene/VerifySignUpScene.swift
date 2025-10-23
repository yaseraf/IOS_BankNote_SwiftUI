//
//  VerifySignUpScene.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 15/09/2025.
//

import Foundation
import SwiftUI
import Combine

struct VerifySignUpScene: BaseSceneType {
    @ObservedObject var viewModel: VerifySignUpViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(backgroundType: .clear, contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, backgroundType: .gradient, content: {
                VerifySignUpContentView(verificationType: $viewModel.verificationType, timerObserve: $viewModel.timerViewModel.timerObserve, isVLens: $viewModel.isVlens, phone: $viewModel.phone, email: $viewModel.email, pin: $viewModel.pin, onBack: {
                    
                }, onContinueTap: {otp, verifyWithEmail, isVlens in
                    if isVlens {
                        viewModel.validateOtpBusinessAPI(success: true, otpCode: otp)
                    } else {
                        if !verifyWithEmail {
                            viewModel.verifyPhoneOtpAPI(success: true, phoneNumber: $viewModel.phone.wrappedValue, phoneNumberOtp: otp, phoneNumberOtpRequestId: KeyChainController().phoneNumberOtpRequestId ?? "", isVerifyingWithEmail: verifyWithEmail)
                        } else {
                            viewModel.verifyEmailOtpAPI(success: true, email: $viewModel.email.wrappedValue, emailOtp: otp, emailOtpRequestId: KeyChainController().emailOtpRequestId ?? "", isVerifyingWithEmail: verifyWithEmail)
                        }
                    }
                }, onResendOtpTap: { verifyWithEmail in
                    if !verifyWithEmail {
                        viewModel.verifyPhoneOtpAPI(success: true, phoneNumber: $viewModel.phone.wrappedValue, phoneNumberOtp: "", phoneNumberOtpRequestId: KeyChainController().phoneNumberOtpRequestId ?? "", isVerifyingWithEmail: verifyWithEmail)

                        SceneDelegate.getAppCoordinator()?.showMessage(type: .success, "resend_code_status".localized)

                    } else {
                        viewModel.verifyEmailOtpAPI(success: true, email: $viewModel.email.wrappedValue, emailOtp: "", emailOtpRequestId: KeyChainController().emailOtpRequestId ?? "", isVerifyingWithEmail: verifyWithEmail)

                        SceneDelegate.getAppCoordinator()?.showMessage(type: .success, "resend_code_status".localized)
                    }
                    
                    viewModel.startTimer()

                })
            })
        }, showLoading: .constant(viewTypeAction.showLoading))
        .onViewDidLoad {
            viewModel.startTimer()
            VerifyPhoneAPI()
            VerifyEmailAPI()
            ValidateOTPBusinessAPI()
        }
    }
    
    private func VerifyPhoneAPI() {
        viewModel.$verifyPhoneOtpAPIResult.receive(on: DispatchQueue.main).sink { result  in
            switch result{
            case .onFailure(let error):
                debugPrint("")
            case.onLoading(let show):
                viewTypeAction.showLoading = show
            case.onSuccess(let listResponse):
                debugPrint("")
            case .none:
                break
            }
        }.store(in: &anyCancellable)
    }
    
    private func VerifyEmailAPI() {
        viewModel.$verifyEmailWithOtpAPIResult.receive(on: DispatchQueue.main).sink { result  in
            switch result{
            case .onFailure(let error):
                debugPrint("")
            case.onLoading(let show):
                viewTypeAction.showLoading = show
            case.onSuccess(let listResponse):
                debugPrint("")
            case .none:
                break
            }
        }.store(in: &anyCancellable)
    }

    private func ValidateOTPBusinessAPI() {
        viewModel.$validateOTPBusinessRequestAPIResult.receive(on: DispatchQueue.main).sink { result  in
            switch result{
            case .onFailure(let error):
                debugPrint("")
            case.onLoading(let show):
                viewTypeAction.showLoading = show
            case.onSuccess(let listResponse):
                debugPrint("")
            case .none:
                break
            }
        }.store(in: &anyCancellable)
    }

}
