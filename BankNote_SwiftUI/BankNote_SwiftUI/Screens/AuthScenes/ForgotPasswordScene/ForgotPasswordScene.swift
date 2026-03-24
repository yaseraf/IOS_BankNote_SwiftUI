//
//  ForgotPasswordScene.swift
//  QSC_SwiftUI
//
//  Created by FIT on 22/07/2025.
//

import Foundation
import SwiftUI
import Combine

struct ForgotPasswordScene: BaseSceneType {
    @ObservedObject var viewModel: ForgotPasswordViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(contentView: {
            BaseContentView(withScroll:false, backgroundType: .gradient, content: {
                ForgotPasswordContentView(forgotType: $viewModel.forgotType, authenticationType: $viewModel.authenticationType, nin: "", qid: "", phoneNumber: $viewModel.mobileInputValue, email: $viewModel.emailInputValue, onBack: {
                    viewModel.onBack()
                }, onSubmit: {
                    viewModel.onSubmit()
                }, onLoginTap: {
                    
                }, onCountryPickerTap: {
                    viewModel.openCountryPickerScene()
                }, onResendLinkTap: {
                    
                })
            })
        }, showLoading: .constant(viewTypeAction.showLoading))
        .onViewDidLoad(){
            forgetPasswordAPI()
        }
    }
    
    private func forgetPasswordAPI() {
        viewModel.$forgetPasswordAPIResult.receive(on: DispatchQueue.main).sink { result  in
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
