//
//  ChangePasswordScene.swift
//  QSC_SwiftUI
//
//  Created by FIT on 23/07/2025.
//

import Foundation
import SwiftUI
import Combine

struct ChangePasswordScene: BaseSceneType {
    @ObservedObject var viewModel: ChangePasswordViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(contentView: {
            BaseContentView(withScroll:false, content: {
                ChangePasswordContentView(oldPassword: "", newPassword: "", confirmNewPassword: "", isNewPasswordHidden: false, isConfirmNewPasswordHidden: false, onBack: {
                    viewModel.onBack()
                }, onConfirmChangePassword: { oldPassword, newPassword, pin in
                    viewModel.onConfirmChangePassword(oldPassword: oldPassword, newPassword: newPassword, pin: pin)
                })
            })
        }, showLoading: .constant(viewTypeAction.showLoading))
        .onViewDidLoad(){
            changePasswordAPI()
        }
    }
    
    private func changePasswordAPI() {
        viewModel.$ChangePasswordResponseModelAPIResult.receive(on: DispatchQueue.main).sink { result  in
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
