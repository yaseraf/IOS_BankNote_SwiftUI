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
            BaseContentView(withScroll:false, content: {
                ForgotPasswordContentView(forgotType: $viewModel.forgotType, nin: "", qid: "", onBack: {
                    viewModel.onBack()
                }, onSubmit: {
                    viewModel.onSubmit()
                })
            })
        })
    }
}
