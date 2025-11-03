//
//  TakeSelfieScene.swift
//  mahfazati
//
//  Created by FIT on 07/08/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation
import SwiftUI
struct TakeSelfieScene: BaseSceneType{
    @ObservedObject var viewModel: TakeSelfieViewModel

    @State var viewTypeAction:BaseSceneViewType  = DefaultBaseSceneViewType()
    var body: some View {
        BaseScene( backgroundType: .colorBGSecondary,contentView: {
            BaseContentView(withScroll:false, content: {
                TakeSelfieContentView(isLivenessCheck: $viewModel.isLivenessCheck) {
                    viewModel.openCameraPreviewForTakeSelfieScene()
                }

            })
        }, showLoading: .constant(viewTypeAction.showLoading))
        .onViewDidLoad(){
           
        }

    }


}
