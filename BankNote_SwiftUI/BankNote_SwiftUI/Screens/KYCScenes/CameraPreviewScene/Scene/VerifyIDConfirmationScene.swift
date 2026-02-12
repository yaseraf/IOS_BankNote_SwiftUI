//
//  CameraPreviewScene.swift
//  mahfazati
//
//  Created by FIT on 09/08/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

struct VerifyIDConfirmationScene: BaseSceneType{
    @ObservedObject var viewModel: VerifyIDConfirmationViewModel
    @State var anyCancellable = Set<AnyCancellable>()

    @State var viewTypeAction:BaseSceneViewType  = DefaultBaseSceneViewType()
    var body: some View {
        BaseScene( backgroundType: .colorBGSecondary,contentView: {
            VerifyIDConfirmationContentView(fullName: $viewModel.fullName, address: $viewModel.address, dateOfBirth: $viewModel.dateOfBith, idNumber: $viewModel.idNumber, idKey: $viewModel.idKey, onRetakeTap: {
                viewModel.dismiss()
            }, onNextTap: {
                viewModel.openLivenessCheckScene()
            })
        }, showLoading: .constant(viewTypeAction.showLoading))
        .onAppear {
            viewModel.getValifyDataAPI(success: true)
        }
        .onViewDidLoad(){
           
        }

    }

}
