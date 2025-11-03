//
//  NewsViewModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 10/09/2025.
//

import Foundation

class NewsViewModel: ObservableObject {
    private let coordinator: TradeCoordinatorProtocol
    private let useCase: TradeUseCaseProtocol

    @Published var newsData: [NewsUIModel]?
    @Published var marketNews:[GetAllMarketNewsUIModel]?

    @Published var getAllMarketNewsAPIResult:APIResultType<[GetAllMarketNewsUIModel]>?

    init(coordinator: TradeCoordinatorProtocol, useCase: TradeUseCaseProtocol) {
        self.coordinator = coordinator
        self.useCase = useCase
        
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

// MARK: API Calls
extension NewsViewModel {
    func GetFullMarketNews(success:Bool) {
        let requestModel = GetAllMarketNewsRequestModel()
        getAllMarketNewsAPIResult = .onLoading(show: true)
        
        Task.init {
            await useCase.GetFullMarketNews(requestModel: requestModel) {[weak self] result in
                self?.getAllMarketNewsAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    self?.getAllMarketNewsAPIResult = .onSuccess(response: success)
                    debugPrint("market news succcess")
                    
                    self?.marketNews = success
                    
                case .failure(let failure):
                        self?.getAllMarketNewsAPIResult = .onFailure(error: failure)
                    debugPrint("market news failure: \(failure)")
                }
            }
        }
    }
}

