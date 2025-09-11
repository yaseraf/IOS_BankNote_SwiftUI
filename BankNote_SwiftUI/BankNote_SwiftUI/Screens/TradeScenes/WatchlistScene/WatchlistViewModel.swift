//
//  WatchlistViewModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 10/09/2025.
//

import Foundation

class WatchlistViewModel: ObservableObject {
    private let coordinator: TradeCoordinator
    
    @Published var watchlistData: [WatchlistUIModel]?
    
    init(coordinator: TradeCoordinator) {
        self.coordinator = coordinator
        
        watchlistData = []
    }
    
    
}

// MARK: Routing
extension WatchlistViewModel {
    func popViewController() {
        coordinator.popViewController()
    }
}

// MARK: Mock Data Fetch
extension WatchlistViewModel {
    func getWatchlistData() {
        var data: [WatchlistUIModel] = []
        data.append(WatchlistUIModel(image: "ic_fawry", name: "FWRY", fullName: "Fawry For Banking Technology", change: 35, changePerc: 3.01))
        data.append(WatchlistUIModel(image: "ic_etel", name: "ETEL", fullName: "Telecom Egypt", change: 35, changePerc: -2.1))
        
        watchlistData = data
    }
}
