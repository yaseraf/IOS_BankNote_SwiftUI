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
                WatchlistContentView(watchlistData: $viewModel.watchlistData, onBackTap: {
                    viewModel.popViewController()
                })
                .onAppear {
                    viewModel.getWatchlistData()
                }
            })
        })
    }
}
