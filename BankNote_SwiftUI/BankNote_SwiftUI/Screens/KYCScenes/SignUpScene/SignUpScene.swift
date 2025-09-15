//
//  SignUpScene.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 15/09/2025.
//

import Foundation
import SwiftUI
import Combine

struct SignUpScene: BaseSceneType {
    @ObservedObject var viewModel: SignUpViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(backgroundType: .clear, contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, backgroundType: .gradient, content: {
                SignUpContentView(verificationType: viewModel.verificationType, phone: $viewModel.phone, email: $viewModel.email, onBack: {
                    
                }, onContinueTap: {
                    viewModel.openVerifySignUpScene()
                }, onCountryPickerTap: {
                    
                })
            })
        })
    }
}
