//
//  TradeScene.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 09/09/2025.
//

import Foundation
import SwiftUI
import Combine

struct TradeScene: BaseSceneType {
    @ObservedObject var viewModel: TradeViewModel
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
                        TradeContentView(
                            indexData: $viewModel.listMarketOverView,
                            watchlistData: $viewModel.list,
                            topGainersData: $viewModel.listTopGainers,
                            topLosersData: $viewModel.listTopLosers,
                            mostActiveData: $viewModel.listMostActive,
                            newsData: $viewModel.marketNews,
                            onIndexTap: { index in
                                viewModel.openIndexDetailsScene(index: index)
                            }, onIndexViewAllTap: {
                                viewModel.openIndexScene()
                            }, onWatchlistViewAllTap: { watchlist in
                                viewModel.openWatchlistScene(title: "watchlist".localized, watchlist: watchlist)
                            }, onTopGainerViewAllTap: { watchlist in
                                viewModel.openWatchlistScene(title: "top_gainers".localized, watchlist: watchlist.map {$0.toWatchlistUIModel()})
                            }, onTopLoserViewAllTap: { watchlist in
                                viewModel.openWatchlistScene(title: "top_losers".localized, watchlist: watchlist.map {$0.toWatchlistUIModel()})
                            }, onMostActiveViewAllTap: { watchlist in
                                viewModel.openWatchlistScene(title: "most_active".localized, watchlist: watchlist.map {$0.toWatchlistUIModel()})
                            }, onWatchlistTap: { watchlist in
                                viewModel.openStockDetailsScene(symbol: watchlist.symbol ?? "", marketType: watchlist.marketType ?? "")
                            }, onTopGainerTap: { symbol in
                                viewModel.openStockDetailsScene(symbol: symbol, marketType: "")
                            }, onTopLoserTap: { symbol in
                                viewModel.openStockDetailsScene(symbol: symbol, marketType: "")
                            }, onMostActiveTap: { symbol in
                                viewModel.openStockDetailsScene(symbol: symbol, marketType: "")
                            }, onNewsViewAllTap: {
                                viewModel.openNewsScene()
                            }
                        )
                    }
                )
                .onAppear {
                    viewModel.GetExchangeSummaryAPI(success: true)
                    viewModel.GetAllProfilesLookupsByUserCodeAPI(success: true)
                    viewModel.GetFullMarketNews(success: true)
                    viewModel.callGetPortfolioAPI(success: true)
                    
                    viewModel.sendTopGainerObject()
                    viewModel.sendTopLoserObject()
                    viewModel.sendMostActiveObject()
                }
                .onDisappear {
                    viewModel.UnSubscribleMarketWatchSymbols()
                }
            },
            showLoading: .constant(viewTypeAction.showLoading)
        )
        .onViewDidLoad {
//            ExchangeDataAPI()
//            GetAllProfilesLookupsByUserCodeAPI()
            GetMarketWatchByProfileIDAPI()
        }
    }
    
    private func ExchangeDataAPI() {
        viewModel.$getExchangeSummaryAPIResult.receive(on: DispatchQueue.main).sink { result  in
            switch result {
            case .onFailure(let error):
                SceneDelegate.getAppCoordinator()?.showMessage(type: .failure,error.text)
            case.onLoading(let show):
                viewTypeAction.showLoading = show
            case.onSuccess(let listResponse):
                debugPrint("Loading..")
            case .none:
                break
            }
        }.store(in: &anyCancellable)
    }
    
    private func GetAllProfilesLookupsByUserCodeAPI() {
        viewModel.$getAllProfilesLookupsByUserCodeAPIResult.receive(on: DispatchQueue.main).sink { result  in
            switch result {
            case .onFailure(let error):
                SceneDelegate.getAppCoordinator()?.showMessage(type: .failure,error.text)
            case.onLoading(let show):
                viewTypeAction.showLoading = show
            case.onSuccess(let listResponse):
                debugPrint("Loading..")
            case .none:
                break
            }
        }.store(in: &anyCancellable)
    }

    
    private func GetMarketWatchByProfileIDAPI() {
        viewModel.$getMarketWatchByProfileIDAPIResult.receive(on: DispatchQueue.main).sink { result  in
            switch result {
            case .onFailure(let error):
                SceneDelegate.getAppCoordinator()?.showMessage(type: .failure,error.text)
            case.onLoading(let show):
                viewTypeAction.showLoading = show
            case.onSuccess(let listResponse):
                debugPrint("Loading..")
            case .none:
                break
            }
        }.store(in: &anyCancellable)
    }

}
