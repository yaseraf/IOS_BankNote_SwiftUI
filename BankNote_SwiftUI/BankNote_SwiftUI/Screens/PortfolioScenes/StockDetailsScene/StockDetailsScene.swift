//
//  StockDetailsScene.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 11/09/2025.
//

import Foundation
import SwiftUI
import Combine

struct StockDetailsScene: BaseSceneType {
    @ObservedObject var viewModel: StockDetailsViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(backgroundType: .clear, contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, backgroundType: .gradient, content: {
                StockDetailsContentView(onBackTap: {
                    viewModel.popViewController()
                }, onBuyTap: {
                    viewModel.openOrderEntryScene()
                }, onSellTap: {
                    viewModel.openOrderEntryScene()
                })
            })
        })
    }
}
