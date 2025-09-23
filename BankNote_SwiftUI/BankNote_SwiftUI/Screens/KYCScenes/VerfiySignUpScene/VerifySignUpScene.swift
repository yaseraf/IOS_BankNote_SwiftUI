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
                VerifySignUpContentView(verificationType: $viewModel.verificationType, isVLens: $viewModel.isVlens, phone: $viewModel.phone, email: $viewModel.email, pin: $viewModel.pin, onBack: {
                    
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
                })
            })
        })
    }
}
