//
//  LivenessCheckScene.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 15/09/2025.
//

import Foundation
import SwiftUI
import Combine

struct LivenessCheckScene: BaseSceneType {
    @ObservedObject var viewModel: LivenessCheckViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(backgroundType: .clear, contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, backgroundType: .gradient, content: {
                LivenessCheckContentView(onContinueTap: {
                    
                })
            })
        })
    }
}
