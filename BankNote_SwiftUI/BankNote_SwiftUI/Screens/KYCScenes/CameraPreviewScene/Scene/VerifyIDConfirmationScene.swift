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
            VerifyIDConfirmationContentView(isFrontID: $viewModel.isFrontID, address: $viewModel.address, name: $viewModel.name, dateOfBirth: $viewModel.dateOfBirth, idNumber: $viewModel.idNumber, idKey: $viewModel.idKey, gender: $viewModel.gender, jobTitle: $viewModel.jobTitle, religion: $viewModel.religion, maritalStatus: $viewModel.maritalStatus, onRetakeTap: {
                viewModel.dismiss()
            }, onNextTap: {
                viewModel.openTakeSelfieScene()
            })
        }, showLoading: .constant(viewTypeAction.showLoading))
        .onViewDidLoad(){
           
        }

    }

}
