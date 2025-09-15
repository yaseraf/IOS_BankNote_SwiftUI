//
//  VerifyScanIDFrontScene.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 15/09/2025.
//

import Foundation
import SwiftUI
import Combine

struct VerifyScanIDFrontScene: BaseSceneType {
    @ObservedObject var viewModel: VerifyScanIDFrontViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(backgroundType: .clear, contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, backgroundType: .gradient, content: {
                VerifyScanIDFrontContentView(stepNumber: $viewModel.stepNumber, onNextTap: {
                    viewModel.openScanIDBackScene()
                }, onRetakeTap: {
                    viewModel.popViewController()
                })
            })
        })
    }
}
