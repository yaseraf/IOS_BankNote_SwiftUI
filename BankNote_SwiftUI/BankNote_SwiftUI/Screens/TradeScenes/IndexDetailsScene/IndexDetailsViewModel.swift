//
//  IndexViewModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 10/09/2025.
//

import Foundation

class IndexDetailsViewModel: ObservableObject {
    private let coordinator: TradeCoordinatorProtocol
    private let useCase: TradeUseCaseProtocol

    @Published var indexData: [IndexUIModel]?
    @Published var listMarketOverView:[GetExchangeSummaryUIModel]?

    @Published var getExchangeSummaryAPIResult:APIResultType<[GetExchangeSummaryUIModel]>?
    @Published var getMarketWatchByProfileIDAPIResult:APIResultType<[GetMarketWatchByProfileIDUIModel]>?
    @Published var subscribleMarketWatchSymbolsAPIResult:APIResultType<[GetMarketWatchByProfileIDUIModel]>?

    @Published var selectedIndex: IndexType?
    @Published var marketWatchData: [GetMarketWatchByProfileIDUIModel]?
    @Published var portfolioData: GetPortfolioUIModel?

    @Published var index: String?

    init(coordinator: TradeCoordinatorProtocol, useCase: TradeUseCaseProtocol, portfolioData: GetPortfolioUIModel, index: String) {
        self.coordinator = coordinator
        self.useCase = useCase
        self.index = index
        self.portfolioData = portfolioData

//        Connection_Hub.shared.exchangeSummaryDelegate = self
        
        indexData = []
        listMarketOverView = []
    }
    
        
}

// MARK: Routing
extension IndexDetailsViewModel {
    func popViewController() {
        coordinator.popViewController()
    }
    
    func openStockDetailsScene(symbol: String, marketType: String) {
        
        UserDefaultController().selectedSymbol = symbol
        
        let selectedStock:GetCompaniesLookupsUIModel = AppUtility.shared.loadCompanies().filter({$0.symbol == UserDefaultController().selectedSymbol ?? ""}).first ?? .testUIModel()

        let portfolioSymbol = portfolioData?.portfolioes.filter({$0.symbol == symbol}).first

        UserDefaultController().selectedSymbolID = selectedStock.symbolID
        UserDefaultController().selectedSymbolType = selectedStock.marketType ?? ""
        UserDefaultController().selectedCustodian = portfolioSymbol?.custodianID ?? "-1"
        UserDefaultController().CUSTODYID = portfolioSymbol?.custodianID ?? "-1"
        UserDefaultController().selectedCustodianName = AppUtility.shared.isRTL ? portfolioSymbol?.custodianA ?? "" : portfolioSymbol?.custodianE ?? ""
        SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getPortfolioCoordinator().openStockDetailsScene(symbol: symbol, marketType: marketType)
    }
}

// MARK: Mock Data
extension IndexDetailsViewModel {
    func getIndexData() {
        var data: [IndexUIModel] = []
        
        data.append(IndexUIModel(image: "ic_indexPlaceholder", name: "EGX 30", changePerc: 0.016, value: 2262.43))
        data.append(IndexUIModel(image: "ic_indexPlaceholder", name: "EGX 70", changePerc: -0.20, value: 9550.43))
        data.append(IndexUIModel(image: "ic_indexPlaceholder", name: "EGX 100", changePerc: 0.016, value: 9550.43))
        data.append(IndexUIModel(image: "ic_indexPlaceholder", name: "EGX 100", changePerc: 0.016, value: 9550.43))
        data.append(IndexUIModel(image: "ic_indexPlaceholder", name: "EGX 100", changePerc: 0.016, value: 9550.43))
        
        indexData = data
    }

}

// MARK: API CALLS
extension IndexDetailsViewModel {
    
    func GetMarketWatchByProfileIDAPI(success:Bool) {
        let requestModel = GetMarketWatchByProfileIDRequestModel()
        getMarketWatchByProfileIDAPIResult = .onLoading(show: true)
        
        
        if index == "EGX30" {
            UserDefaultController().profileID = "2" // Static
        } else if index == "EGX70" {
            UserDefaultController().profileID = "4" // Static
        } else if index == "EGX100" {
            UserDefaultController().profileID = "5" // Static
        }
    
        Task.init {
            await useCase.GetMarketWatchByProfileID(requestModel: requestModel) {[weak self] result in
                self?.getMarketWatchByProfileIDAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    self?.getMarketWatchByProfileIDAPIResult = .onSuccess(response: success)
                    debugPrint("market overview stocks success")
                    self?.marketWatchData = success
                    
                    self?.getSubscribeMarketWatchSymbols()
                    
                case .failure(let failure):
                    self?.getMarketWatchByProfileIDAPIResult = .onFailure(error: failure)
                    debugPrint("market overview stocks failure: \(failure)")
                }
            }
        }
    }
}
    
// MARK: - SignalR
extension IndexDetailsViewModel {
    func getSubscribeMarketWatchSymbols(){
        if marketWatchData?.count ?? 0 <= 0 {return}

        var arraySymbols: [String] = []
        
        for i in 0...(marketWatchData?.count ?? 0) - 1 {
            if i == 4 { break }
            arraySymbols.append(marketWatchData?[i].symbol ?? "")
        }
        
        subscribleMarketWatchSymbolsAPIResult = .onLoading(show:  true)
        
        debugPrint("Username sent SignalR: \(UserDefaultController().username ?? "")")
        debugPrint("symbols sent SignalR: \(arraySymbols)")
    
        if Connection_Hub.shared.chatHub != nil {
            do {
                debugPrint("test invoke subscribeMarketWatchSymbols '\(arraySymbols)'")
                try Connection_Hub.shared.chatHub?.invoke("SubscribeMarketWatchSymbols", arguments: [UserDefaultController().username ?? "", arraySymbols]) { (result, error) in
                    if let e = error {
                        debugPrint("SubscribeMarketWatchSymbols invoke '\(arraySymbols)' Error: \(e)")
                        self.subscribleMarketWatchSymbolsAPIResult = .onLoading(show:  false)
                    } else {
                        debugPrint("SubscribeMarketWatchSymbols invoke '\(arraySymbols)' Success!, appDelegate.userNameNotEncryptrd\("info3@fitmena.com")")
                        self.subscribleMarketWatchSymbolsAPIResult = .onLoading(show:  false)
                    }
                }
            } catch let error {
                debugPrint("SubscribeMarketWatchSymbols chatHub '\(arraySymbols)' error: \(error.localizedDescription)")
                self.subscribleMarketWatchSymbolsAPIResult = .onLoading(show:  false)

            }
        }
    }
    
    func UnSubscribleMarketWatchSymbols() {
        subscribleMarketWatchSymbolsAPIResult = .onLoading(show:  true)
        
        if Connection_Hub.shared.chatHub != nil {
            do {
                debugPrint("test invoke unSubscribeMarketWatchSymbols")
                try Connection_Hub.shared.chatHub?.invoke(HubMethodType.unSubscribeMarketWatchSymbols.rawValue, arguments: [UserDefaultController().username ?? ""]) { (result, error) in
                    if let e = error {
                        debugPrint("unSubscribeMarketWatchSymbols invoke Error: \(e)")
                    } else {
                        debugPrint("unSubscribeMarketWatchSymbols invoke Success!, appDelegate.userNameNotEncryptrd\("info3@fitmena.com")")
                        debugPrint("unSubscribeMarketWatchSymbols invoke result: \(result)")
                    }
                }
            } catch let error {
                debugPrint("unSubscribeMarketWatchSymbols chatHub error: \(error.localizedDescription)")
            }
        }
    }}


// MARK: Delegates
extension IndexDetailsViewModel: ExchangeSummaryDelegate {
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
