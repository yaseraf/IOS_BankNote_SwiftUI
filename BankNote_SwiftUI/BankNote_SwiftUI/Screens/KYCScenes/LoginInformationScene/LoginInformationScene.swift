//
//  LoginInformationScene.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 15/09/2025.
//

import Foundation
import SwiftUI
import Combine

struct LoginInformationScene: BaseSceneType {
    @ObservedObject var viewModel: LoginInformationViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(backgroundType: .clear, contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, backgroundType: .gradient, content: {
                LoginInformationContentView(listPasswordValidation: $viewModel.listPasswordValidation, onPasswordTextChange: { text in
                    viewModel.checkValidation(text: text)
                    withAnimation{
                        viewModel.checkIsAllPasswordMatch()
                    }
                }, onContinueTap: { username, password in
                    viewModel.getKYCCibcAPI(success: true, requestItems: [GetKYCCibcRequestItems(ID: "211", Value: username)], password: password)
                })
            })
            .onAppear {
                
            }
        }, showLoading: .constant(viewTypeAction.showLoading))
        .onViewDidLoad {
            StepCreateAPI()
            getKYCCibcAPI()
        }
    }
    
    private func StepCreateAPI() {
        viewModel.$stepCreateAPIResult.receive(on: DispatchQueue.main).sink { result  in
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
    
    private func getKYCCibcAPI() {
        viewModel.$getKYCCibcAPIResult.receive(on: DispatchQueue.main).sink { result  in
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
