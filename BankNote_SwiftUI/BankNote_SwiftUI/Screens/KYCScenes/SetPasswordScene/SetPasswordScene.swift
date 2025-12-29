//
//  LoginInformationScene.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 15/09/2025.
//

import Foundation
import SwiftUI
import Combine

struct SetPasswordScene: BaseSceneType {
    @ObservedObject var viewModel: SetPasswordViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(backgroundType: .clear, contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, backgroundType: .gradient, content: {
                SetPasswordContentView(listPasswordValidation: $viewModel.listPasswordValidation, onPasswordTextChange: { text in
                    viewModel.checkValidation(text: text)
                    withAnimation{
                        viewModel.checkIsAllPasswordMatch()
                    }
                }, onContinueTap: { password in
                    viewModel.setPasswordValifyAPI(success: true, password: password)
                }, onBack: {
                    viewModel.popViewController()
                })
            })
            .onAppear {
                
            }
        }, showLoading: .constant(viewTypeAction.showLoading))
        .onViewDidLoad {
            SetPasswordValifyAPI()
        }
    }
        
    private func SetPasswordValifyAPI() {
        viewModel.$setPasswordValifyAPIResult.receive(on: DispatchQueue.main).sink { result  in
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
    
}
