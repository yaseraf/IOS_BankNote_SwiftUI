//
//  ChangePinScene.swift
//  QSC_SwiftUI
//
//  Created by FIT on 23/07/2025.
//

import Foundation
import SwiftUI
import Combine

struct ChangePinScene: BaseSceneType {
    @ObservedObject var viewModel: ChangePinViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(contentView: {
            BaseContentView(withScroll:false, content: {
                ChangePinContentView(onBack: {
                    viewModel.onBack()
                }, onCreatePin: {
                    viewModel.onCreatePin()
                })
            })
        })
    }
}
