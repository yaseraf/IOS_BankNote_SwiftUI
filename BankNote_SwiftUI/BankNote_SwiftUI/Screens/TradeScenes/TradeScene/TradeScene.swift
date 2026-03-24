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
                            newsData: $viewModel.marketNews,
                            onIndexViewAllTap: {
                                viewModel.openIndexScene()
                            }, onWatchlistViewAllTap: { watchlist in
                                viewModel.openWatchlistScene(watchlist: watchlist)
                            }, onWatchlistTap: { watchlist in
                                viewModel.openStockDetailsScene(symbol: watchlist.symbol ?? "", marketType: watchlist.marketType ?? "")
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
