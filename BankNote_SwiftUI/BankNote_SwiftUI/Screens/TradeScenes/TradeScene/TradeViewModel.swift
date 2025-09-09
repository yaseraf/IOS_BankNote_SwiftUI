//
//  TradeViewModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 09/09/2025.
//

import Foundation
class TradeViewModel: ObservableObject {
    private let coordinator: TradeCoordinatorProtocol
    
    @Published var indexData: [IndexUIModel]?
    @Published var watchlistData: [WatchlistUIModel]?
    @Published var newsData: [NewsUIModel]?
    
    init(coordinator: TradeCoordinatorProtocol) {
        self.coordinator = coordinator
        
        indexData = []
    }
    
    func getIndexData() {
        var data: [IndexUIModel] = []
        
        data.append(IndexUIModel(image: "ic_indexPlaceholder", name: "EGX 30", changePerc: 0.016, value: 2262.43))
        data.append(IndexUIModel(image: "ic_indexPlaceholder", name: "EGX 70", changePerc: -0.20, value: 9550.43))
        data.append(IndexUIModel(image: "ic_indexPlaceholder", name: "EGX 100", changePerc: 0.016, value: 9550.43))
        
        indexData = data
    }
    
    func getWatchlistData() {
        var data: [WatchlistUIModel] = []
        data.append(WatchlistUIModel(image: "ic_fawry", name: "FWRY", fullName: "Fawry For Banking Technology", change: 35, changePerc: 3.01))
        data.append(WatchlistUIModel(image: "ic_etel", name: "ETEL", fullName: "Telecom Egypt", change: 35, changePerc: -2.1))
        
        watchlistData = data
    }
    
    func getNewsData() {
        var data: [NewsUIModel] = []
        data.append(NewsUIModel(indexName: "EGX", time: "2 hours ago", title: "ADNOC Distribution Expands to Saudi Arabia", desc: "ADNOCDIST announces new fuel stations in KSA as..."))
        data.append(NewsUIModel(indexName: "EGX", time: "Yesterday", title: "Emaar Properties Reports 12% Profit Growth in Q1 2025", desc: "Strong performance driven by Dubai’s real estate..."))
        data.append(NewsUIModel(indexName: "EGX", time: "3 days ago", title: "UAE Central Bank Holds Interest Rates Steady", desc: "Decision aligns with US Fed Pol policy amid stable ..."))
        
        newsData = data
    }
}
