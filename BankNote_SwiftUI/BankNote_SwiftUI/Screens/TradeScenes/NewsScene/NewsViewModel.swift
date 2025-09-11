//
//  NewsViewModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 10/09/2025.
//

import Foundation

class NewsViewModel: ObservableObject {
    private let coordinator: TradeCoordinatorProtocol
    
    @Published var newsData: [NewsUIModel]?
    
    init(coordinator: TradeCoordinatorProtocol) {
        self.coordinator = coordinator
        
        newsData = []
    }
}


// MARK: Routing
extension NewsViewModel {
    func popViewController() {
        coordinator.popViewController()
    }
}

// MARK: Mock Data Fetch
extension NewsViewModel {
    func getNewsData() {
        var data: [NewsUIModel] = []
        data.append(NewsUIModel(indexName: "EGX", time: "2 hours ago", title: "ADNOC Distribution Expands to Saudi Arabia", desc: "ADNOCDIST announces new fuel stations in KSA as..."))
        data.append(NewsUIModel(indexName: "EGX", time: "Yesterday", title: "Emaar Properties Reports 12% Profit Growth in Q1 2025", desc: "Strong performance driven by Dubai’s real estate..."))
        data.append(NewsUIModel(indexName: "EGX", time: "3 days ago", title: "UAE Central Bank Holds Interest Rates Steady", desc: "Decision aligns with US Fed Pol policy amid stable ..."))
        
        newsData = data
    }
}
