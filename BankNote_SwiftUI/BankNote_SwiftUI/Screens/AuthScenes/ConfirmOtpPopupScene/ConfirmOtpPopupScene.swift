//
//  VerifyOtpPopupScene.swift
//  QSC_SwiftUI
//
//  Created by FIT on 22/07/2025.
//

import Foundation
import SwiftUI
import Combine

struct ConfirmOtpPopupScene: BaseSceneType {
    @ObservedObject var viewModel: ConfirmOtpPopupViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(contentView: {
            BaseContentView(withScroll:false, paddingValue:0, paddingVerticalValue: 0, content: {
                ConfirmOtpPopupContentView(timerObserve: $viewModel.timerViewModel.timerObserve, onDismiss: {
                    viewModel.onDismiss()
                }, onResendOtpTap: {
                    viewModel.startTimer()
                }, onVerify: { otp in
                    viewModel.onVerify(otp: otp)
                })
            })
        }, showLoading: .constant(viewTypeAction.showLoading))
        .onViewDidLoad(){
            registrationsOTPResetAPI()
        }
        .background(Color.clear)
        .ignoresSafeArea()
    }
    
    private func registrationsOTPResetAPI() {
        viewModel.$registrationsOTPResetAPIResult.receive(on: DispatchQueue.main).sink { result  in
            switch result{
            case .onFailure(let error):
                SceneDelegate.getAppCoordinator()?.showMessage(type: .failure,error.text)
            case.onLoading(let show):
                viewTypeAction.showLoading = show
            case.onSuccess(let listResponse):
                debugPrint("Loading..")

            case .none:
                break
            }

        }.store(in: &anyCancellable)
    }
}
