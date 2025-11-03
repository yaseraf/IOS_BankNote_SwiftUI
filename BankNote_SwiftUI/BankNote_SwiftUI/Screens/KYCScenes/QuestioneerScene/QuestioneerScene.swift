//
//  QuestioneerScene.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 16/09/2025.
//

import Foundation
import SwiftUI
import Combine

struct QuestioneerScene: BaseSceneType {
    @ObservedObject var viewModel: QuestioneerViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(backgroundType: .clear, contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, backgroundType: .gradient, content: {
                QuestioneerContentView(onConfirmTap: {
                    viewModel.openThanksForRegisteringScene()
                })
            })
        })
    }
}
