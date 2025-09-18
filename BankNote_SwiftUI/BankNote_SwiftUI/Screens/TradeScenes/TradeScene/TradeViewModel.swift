//
//  TradeViewModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 09/09/2025.
//

import Foundation
class TradeViewModel: ObservableObject {
    private let coordinator: TradeCoordinatorProtocol
    private let useCase: TradeUseCaseProtocol
    private let lookupsUseCase: LookupsUseCaseProtocol

    @Published var newsData: [NewsUIModel]?
    @Published var listMarketOverView:[GetExchangeSummaryUIModel]?
    @Published var getLookupsList: [GetLookupsUIModel]?
    @Published var watchlistData:[GetAllProfilesLookupsByUserCodeUIModel]?

    @Published var getExchangeSummaryAPIResult:APIResultType<[GetExchangeSummaryUIModel]>?
    @Published var getLookupsAPIResult:APIResultType<[GetLookupsUIModel]>?
    @Published var getAllProfilesLookupsByUserCodeAPIResult:APIResultType<[GetAllProfilesLookupsByUserCodeUIModel]>?

    init(coordinator: TradeCoordinatorProtocol, useCase: TradeUseCaseProtocol, lookupsUseCase: LookupsUseCaseProtocol) {
        self.coordinator = coordinator
        self.useCase = useCase
        self.lookupsUseCase = lookupsUseCase
        
        watchlistData = []
        newsData = []
        listMarketOverView = []
    }
}

// MARK: Mock Data Fetch
extension TradeViewModel {
    func getIndexData() {
//        var data: [IndexUIModel] = []
//        
//        data.append(IndexUIModel(image: "ic_indexPlaceholder", name: "EGX 30", changePerc: 0.016, value: 2262.43))
//        data.append(IndexUIModel(image: "ic_indexPlaceholder", name: "EGX 70", changePerc: -0.20, value: 9550.43))
//        data.append(IndexUIModel(image: "ic_indexPlaceholder", name: "EGX 100", changePerc: 0.016, value: 9550.43))
//        
//        indexData = data
    }
    
    func getWatchlistData() {
//        var data: [WatchlistUIModel] = []
//        data.append(WatchlistUIModel(image: "ic_fawry", name: "FWRY", fullName: "Fawry For Banking Technology", change: 35, changePerc: 3.01))
//        data.append(WatchlistUIModel(image: "ic_etel", name: "ETEL", fullName: "Telecom Egypt", change: 35, changePerc: -2.1))
//        
//        watchlistData = data
    }
    
    func getNewsData() {
        var data: [NewsUIModel] = []
        data.append(NewsUIModel(indexName: "EGX", time: "2 hours ago", title: "ADNOC Distribution Expands to Saudi Arabia", desc: "ADNOCDIST announces new fuel stations in KSA as..."))
        data.append(NewsUIModel(indexName: "EGX", time: "Yesterday", title: "Emaar Properties Reports 12% Profit Growth in Q1 2025", desc: "Strong performance driven by Dubai’s real estate..."))
        data.append(NewsUIModel(indexName: "EGX", time: "3 days ago", title: "UAE Central Bank Holds Interest Rates Steady", desc: "Decision aligns with US Fed Pol policy amid stable ..."))
        
        newsData = data
    }
}

// MARK: Routing
extension TradeViewModel {
    func openIndexScene() {
        coordinator.openIndexScene()
    }
    
    func openWatchlistScene() {
        coordinator.openWatchlistScene()
    }
    
    func openNewsScene() {
        coordinator.openNewsScene()
    }
}



// MARK: API CALLS
extension TradeViewModel {
    func GetExchangeSummaryAPI(success:Bool) {
        let requestModel = GetExchangeSummaryRequestModel()
        
        getExchangeSummaryAPIResult = .onLoading(show: true)
        
        Task.init {
            await useCase.GetExchangeSummary(requestModel: requestModel) {[weak self] result in
                
                self?.getExchangeSummaryAPIResult = .onLoading(show: false)

                switch result {
                case .success(let success):
                    self?.getExchangeSummaryAPIResult = .onSuccess(response: success)
                    debugPrint("Exchange summary success")

                    self?.listMarketOverView = success
                    
                case .failure(let failure):
                        self?.getExchangeSummaryAPIResult = .onFailure(error: failure)
                    debugPrint("Overview failure: \(failure)")
                }
            }
        }
    }
    
    func GetAllProfilesLookupsByUserCodeAPI(success:Bool) {
        let requestModel = GetAllProfilesLookupsByUserCodeRequestModel()
        
        getAllProfilesLookupsByUserCodeAPIResult = .onLoading(show: true)
        
        Task.init {
            await useCase.GetAllProfilesLookupsByUserCode(requestModel: requestModel) {[weak self] result in

                switch result {
                case .success(let success):
                    self?.getAllProfilesLookupsByUserCodeAPIResult = .onSuccess(response: success)
                    debugPrint("Watchlist success")
                    
                    self?.watchlistData = success.reversed()
                    
                case .failure(let failure):
                        self?.getAllProfilesLookupsByUserCodeAPIResult = .onFailure(error: failure)
                    debugPrint("Watchlist failure: \(failure)")
                }
            }
        }
    }
    
    func GetLookupsAPI(success:Bool) {
        let requestModel = GetLookupsRequestModel()
        
        getLookupsAPIResult = .onLoading(show: true)
        
        Task.init {
            await lookupsUseCase.GetLookups(requestModel: requestModel) {[weak self] result in
                
                switch result {
                case .success(let success):
                    self?.getLookupsAPIResult = .onSuccess(response: success)
                    
                    self?.getLookupsList = success.filter({$0.type == "MRS"})
       
                case .failure(let failure):
                        self?.getLookupsAPIResult = .onFailure(error: failure)
                    debugPrint("get lookups failure: \(failure)")

                }
            }
        }
    }

}

// MARK: SignalR
extension TradeViewModel {
    
}


// MARK: Delegates
extension TradeViewModel: ExchangeSummaryDelegate {
    func onDataFetch(model: [GetExchangeSummaryUIModel]) {
        UserDefaultController().isMarketOpen = model.first?.statusCode == "0002" || model.first?.statusCode == "0003" ? true : false
        
        for (index, item) in (listMarketOverView ?? []).enumerated() {
            if let match = model.first(where: { $0.isinCode == item.indexCode }) {
                listMarketOverView?[index].currentValue = match.currentValue
                listMarketOverView?[index].netChange = match.netChange
                listMarketOverView?[index].netChangePerc = match.netChangePerc
                listMarketOverView?[index].statusCode = match.statusCode
                
                // Handled in Coonection_Hub
//                self.filterMarketStatus()
            }
        }
    }

}

// MARK: Functions
extension TradeViewModel {
    
    // Handled in Coonection_Hub
    
//    func filterMarketStatus() {
//        for lookupItem in getLookupsList ?? [] {
//            if lookupItem.type == "MRS" && lookupItem.id == listMarketOverView.last?.statusCode ?? "" {
////                marketStatusTitle = (AppUtility.shared.isRTL ? lookupItem.descA : lookupItem.descE) ?? ""
//                
//                UserDefaultController().marketStatusTitleE = lookupItem.descE
//                UserDefaultController().marketStatusTitleA = lookupItem.descA
//                UserDefaultController().marketStatusCode = lookupItem.id
//            }
//        }
//    }
}
