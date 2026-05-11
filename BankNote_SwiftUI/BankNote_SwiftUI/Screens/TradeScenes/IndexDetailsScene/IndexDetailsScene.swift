//
//  IndexScene.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 10/09/2025.
//

import Foundation
import SwiftUI
import Combine

struct IndexDetailsScene: BaseSceneType {
    @ObservedObject var viewModel: IndexDetailsViewModel
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
                        IndexDetailsContentView(
                            title: $viewModel.index,
                            marketWatchData: $viewModel.marketWatchData,
                            onWatchlistTap: { watchlist in
                                viewModel.openStockDetailsScene(symbol: watchlist.symbol ?? "", marketType: watchlist.marketType ?? "")
                            },
                            onBackTap: {
                                viewModel.popViewController()
                            }
                        )
                        .onAppear {
                            viewModel.GetMarketWatchByProfileIDAPI(success: true)
                        }
                    }
                )
               
            },
            showLoading: .constant(viewTypeAction.showLoading)
        )
        .onViewDidLoad {
            ExchangeDataAPI()
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
