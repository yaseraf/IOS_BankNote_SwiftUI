//
//  SelectSharesScene.swift
//  QSC_SwiftUI
//
//  Created by FIT on 03/08/2025.
//

import Foundation
import SwiftUI
import Combine

struct CancelConfirmationScene: BaseSceneType {
    @ObservedObject var viewModel: CancelConfirmationViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, content: {
                CancelConfirmationContentView(transactionTypes: $viewModel.transactionType, onConfirm: {
                    viewModel.onConfirm()
                }, onDismiss: {
                    viewModel.onDismiss()
                })
            })
        })
    }
}
