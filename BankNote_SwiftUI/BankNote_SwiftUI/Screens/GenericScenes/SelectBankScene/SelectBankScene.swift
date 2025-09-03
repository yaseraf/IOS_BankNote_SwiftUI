//
//  SelectSharesScene.swift
//  QSC_SwiftUI
//
//  Created by FIT on 03/08/2025.
//

import Foundation
import SwiftUI
import Combine

struct SelectBankScene: BaseSceneType {
    @ObservedObject var viewModel: SelectBankViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, content: {
                SelectBankContentView(banksData: $viewModel.banksData, selectedBank: $viewModel.selectedBank, onConfirm: { bank in
                    viewModel.onConfirm(bank: bank)
                }, onDismiss: {
                    viewModel.onDismiss()
                })
                .onAppear {
                    viewModel.getBanksData()
                }
            })
        })
    }
}
