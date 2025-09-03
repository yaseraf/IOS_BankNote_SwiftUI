//
//  SelectSharesScene.swift
//  QSC_SwiftUI
//
//  Created by FIT on 03/08/2025.
//

import Foundation
import SwiftUI
import Combine

struct SelectSharesScene: BaseSceneType {
    @ObservedObject var viewModel: SelectSharesViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, content: {
                SelectSharesContentView(sharesDataTelecom: $viewModel.sharesDataTelecom, sharesDataInsurance: $viewModel.sharesDataInsurance, selectedShare: $viewModel.selectedShare, onConfirm: { share in
                    viewModel.onConfirm(share: share)
                }, onDismiss: {
                    viewModel.onDismiss()
                })
                .onAppear {
                    viewModel.getSharesData()
                }
            })
        })
    }
}
