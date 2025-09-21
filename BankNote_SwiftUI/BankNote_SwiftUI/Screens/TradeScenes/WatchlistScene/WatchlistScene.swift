//
//  WatchlistScene.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 10/09/2025.
//

import Foundation
import SwiftUI
import Combine

struct WatchlistScene: BaseSceneType {
    @ObservedObject var viewModel: WatchlistViewModel
    @State var anyCancellable = Set<AnyCancellable>()
    @State var viewTypeAction:BaseSceneViewType = DefaultBaseSceneViewType()
    
    var body: some View {
        BaseScene(backgroundType: .clear, contentView: {
            BaseContentView(withScroll:false, paddingValue: 0, backgroundType: .gradient, content: {
                WatchlistContentView(watchlistData: $viewModel.list, onBackTap: {
                    viewModel.popViewController()
                })
            })
            .onAppear {
                viewModel.GetMarketWatchByProfileIDAPI(success: true)
            }
            .onDisappear {
                viewModel.UnSubscribleMarketWatchSymbols()
            }
        }, showLoading: .constant(viewTypeAction.showLoading))
        .onViewDidLoad {
            WatchlistAPI()
        }
    }
    
    private func WatchlistAPI() {
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
