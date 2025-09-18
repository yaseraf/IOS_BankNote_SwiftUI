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
        BaseScene(backgroundType: .clear, contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, backgroundType: .gradient, content: {
                TradeContentView(indexData: $viewModel.listMarketOverView, watchlistData: $viewModel.watchlistData, newsData: $viewModel.newsData, onIndexViewAllTap: {
                    viewModel.openIndexScene()
                }, onWatchlistViewAllTap: {
                    viewModel.openWatchlistScene()
                }, onNewsViewAllTap: {
                    viewModel.openNewsScene()
                })
            })
            .onAppear {
                viewModel.GetExchangeSummaryAPI(success: true)
                viewModel.GetAllProfilesLookupsByUserCodeAPI(success: true)
            }
        }, showLoading: .constant(viewTypeAction.showLoading))
        .onViewDidLoad {
            ExchangeDataAPI()
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
}
