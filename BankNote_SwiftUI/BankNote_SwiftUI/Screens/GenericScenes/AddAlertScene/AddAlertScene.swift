//
//  AddAlertScene.swift
//  QSC_SwiftUI
//
//  Created by FIT on 19/08/2025.
//

import Foundation
import SwiftUI
import Combine

struct AddAlertScene: BaseSceneType {
    @ObservedObject var viewModel: AddAlertViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, content: {
                AddAlertContentView(selectedShare: $viewModel.selectedShare, selectedPriceFactor: $viewModel.selectedPriceFactor, shareValue: $viewModel.shareValue, selectedExpiryTime: $viewModel.selectedExpiryTime, onBackTap: {
                    viewModel.onBackTap()
                }, onAddTap: {
                    viewModel.onAddTap()
                }, onSelectSharesTap: {
                    viewModel.openSelectSharesScene()
                }, onSelectPriceFactorTap: {
                    viewModel.openSelectPriceFactorScene()
                }, onSelectExpiryTimeTap: {
                    viewModel.openSelectExpiryTimeScene()
                })
            })
        })
    }
}
