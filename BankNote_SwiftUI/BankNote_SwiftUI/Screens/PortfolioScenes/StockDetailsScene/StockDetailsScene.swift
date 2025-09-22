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
                StockDetailsContentView(stockData: $viewModel.stockData, chartLoaded: $viewModel.chartLoaded, marketNews: $viewModel.marketNewsBySymbol, ownedShares: $viewModel.ownedShares, onBackTap: {
                    viewModel.popViewController()
                }, onBuyTap: {
                    viewModel.openOrderEntryScene()
                }, onSellTap: {
                    viewModel.openOrderEntryScene()
                })
            })
            .onAppear {
                viewModel.GetAllMarketWatchBySymbolAPI(success: true)
                viewModel.GetAllMarketNewsBySymbol(success: true)
                viewModel.GetExpectedProfitLossAPI(success: true)
            }
        }, showLoading: .constant(viewTypeAction.showLoading))
        .onViewDidLoad {
            marketAPI()

        }
    }
    
    private func marketAPI() {
        viewModel.$getAllMarketWatchBySymbolAPIResult.receive(on: DispatchQueue.main).sink { result  in
            switch result{
            case .onFailure(let error):
                debugPrint("")
            case.onLoading(let show):
                viewTypeAction.showLoading = show
            case.onSuccess(let listResponse):
                debugPrint("")
            case .none:
                break
            }
        }.store(in: &anyCancellable)
    }

}
