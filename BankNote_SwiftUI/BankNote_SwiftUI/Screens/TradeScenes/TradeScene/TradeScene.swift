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
                TradeContentView(indexData: $viewModel.indexData, watchlistData: $viewModel.watchlistData, newsData: $viewModel.newsData, onIndexViewAllTap: {
                    viewModel.openIndexScene()
                }, onWatchlistViewAllTap: {
                    viewModel.openWatchlistScene()
                }, onNewsViewAllTap: {
                    viewModel.openNewsScene()
                })
            })
            .onAppear {
                viewModel.getIndexData()
                viewModel.getWatchlistData()
                viewModel.getNewsData()
            }
            
        })
    }
}
