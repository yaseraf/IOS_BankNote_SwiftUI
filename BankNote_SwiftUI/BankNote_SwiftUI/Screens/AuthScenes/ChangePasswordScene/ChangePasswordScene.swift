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
                ChangePasswordContentView(newPassword: "", confirmNewPassword: "", isNewPasswordHidden: false, isConfirmNewPasswordHidden: false, onBack: {
                    viewModel.onBack()
                }, onConfirmChangePassword: {
                    viewModel.onConfirmChangePassword()
                })
            })
        })
    }
}
