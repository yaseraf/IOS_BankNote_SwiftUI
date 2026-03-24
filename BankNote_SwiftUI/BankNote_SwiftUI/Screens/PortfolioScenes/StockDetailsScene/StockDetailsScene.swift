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
        BaseScene(
            backgroundType: .clear,
            contentView: {
                BaseContentView(
                    withScroll:false,
                    paddingValue: 0,
                    backgroundType: .gradient,
                    content: {
                        StockDetailsContentView(
                            ordersData: $viewModel.ordersData,
                            stockData: $viewModel.stockData,
                            chartLoaded: $viewModel.chartLoaded,
                            marketNews: $viewModel.marketNewsBySymbol,
                            ownedShares: $viewModel.ownedShares,
                            onBackTap: {
                                viewModel.popViewController()
                            }, onBuyTap: {
                                viewModel.openOrderEntryScene(placeOrderType: .buy)
                            }, onSellTap: {
                                viewModel.openOrderEntryScene(placeOrderType: .sell)
                            }
                        )
                    }
                )
                .onAppear {
                    viewModel.GetAllMarketWatchBySymbolAPI(success: true)
                    viewModel.GetAllMarketNewsBySymbol(success: true)
                    viewModel.GetExpectedProfitLossAPI(success: true)
                }
                .onDisappear {
                    viewModel.UnSubscribleMarketWatchSymbols()
                }
            },
            showLoading: .constant(viewTypeAction.showLoading)
        )
        .onViewDidLoad {
            marketAPI()
            sendOrdersSignalR()
        }
    }
    
    private func sendOrdersSignalR() {
        viewModel.$sendOrdersAPIResult.receive(on: DispatchQueue.main).sink { result  in
            switch result{
            case .onFailure(let error):
                SceneDelegate.getAppCoordinator()?.showMessage(type: .failure,error.text)
            case.onLoading(let show):
                viewTypeAction.showLoading = show
            case.onSuccess(_):
                debugPrint("Loading..")
                
            case .none:
                break
            }
            
        }.store(in: &anyCancellable)
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
