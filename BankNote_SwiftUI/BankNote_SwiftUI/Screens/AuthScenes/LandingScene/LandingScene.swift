//
//  LandingScene.swift
//  QSC_SwiftUI
//
//  Created by FIT on 21/07/2025.
//

import Foundation
import SwiftUI
import Combine

struct LandingScene: BaseSceneType {
    @ObservedObject var viewModel: LandingViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, backgroundType: .gradient, content: {
                LandingContentView(onLanguageSelected: {
                    viewModel.openLoginScene()
                }, onForgotPasswordTap: {
                    viewModel.openForgotPasswordScene()
                }, onLoginTap: {
                    viewModel.openHomeScene()
                }, onSignUpTap: {
                    viewModel.openSignUpScene()
                })
            })
        })
    }
}
