//
//  CreatePinScene.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 05/04/2026.
//

import Foundation
import SwiftUI
import Combine

struct CreatePinScene: BaseSceneType{
    @ObservedObject var viewModel: CreatePinViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType  = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(
            backgroundType: .colorBGSecondary,
            contentView: {
                BaseContentView(
                    withScroll:false, content: {
                        CreatePinContentView(
                            onCreatePinTap: { pinValue in
                                viewModel.changePin(pin: pinValue)
                            }
                        )
                    }
                )
            },
            showLoading: .constant(viewTypeAction.showLoading)
        )
        .onViewDidLoad() {
            ChangePinAPI()
        }
        
    }
    
    private func ChangePinAPI() {
        viewModel.$ChangePinResponseModelAPIResult.receive(on: DispatchQueue.main).sink { result  in
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
