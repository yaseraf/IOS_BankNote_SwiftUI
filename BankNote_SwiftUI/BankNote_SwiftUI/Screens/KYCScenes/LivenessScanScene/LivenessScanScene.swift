//
//  LivenessScanScene.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 16/09/2025.
//

import Foundation
import SwiftUI
import Combine

struct LivenessScanScene: BaseSceneType {
    @ObservedObject var viewModel: LivenessScanViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(backgroundType: .clear, contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, backgroundType: .gradient, content: {
                LivenessScanContentView(onNextTap: {
                    viewModel.openQuestioneerScene()
                })
            })
            .onAppear {
                UserDefaultController().cameraType = .front
            }
        })
    }
}
