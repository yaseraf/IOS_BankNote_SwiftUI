//
//  OrderEntryViewModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 14/09/2025.
//

import Foundation

class OrderEntryViewModel: ObservableObject {
    private let coordinator: OrdersCoordinatorProtocol
    private let useCase: HomeUseCaseProtocol
    private let lookupsUseCase: LookupsUseCaseProtocol

    @Published var symbol:String
    @Published var netChange:String = ""
    @Published var netChangePerc:String = ""
    @Published var lastTradePrice:String = ""
    @Published var stockData:GetALLMarketWatchBySymbolUIModel?

    @Published var getAllMarketWatchBySymbolAPIResult:APIResultType<GetALLMarketWatchBySymbolUIModel>?
    @Published var subscribleMarketWatchSymbolsAPIResult:APIResultType<[GetMarketWatchByProfileIDUIModel]>?
    @Published var getCompaniesLookupsAPIResult:APIResultType<[GetCompaniesLookupsUIModel]>?

    init(coordinator: OrdersCoordinatorProtocol, useCase: HomeUseCaseProtocol, lookupsUseCase: LookupsUseCaseProtocol, symbol: String) {
        self.coordinator = coordinator
        self.useCase = useCase
        self.lookupsUseCase = lookupsUseCase
        self.symbol = symbol
    }
}

// MARK: Routing
extension OrderEntryViewModel {
    func popViewController() {
        coordinator.popViewController()
    }
    
    func openPaymentMethodScene() {
        SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getHomeCoordinator().openPaymentMethodScene(transactionType: .topUp)
    }
}

// MARK: API Calls
extension OrderEntryViewModel {
    func GetAllMarketWatchBySymbolAPI(success:Bool) {
        let requestModel = GetALLMarketWatchBySymbolRequestModel()
        getAllMarketWatchBySymbolAPIResult = .onLoading(show: true)
        
        Task.init {
            await useCase.GetALLMarketWatchBySymbol(requestModel: requestModel) {[weak self] result in
                self?.getAllMarketWatchBySymbolAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    self?.getAllMarketWatchBySymbolAPIResult = .onSuccess(response: success)
                    
                    self?.stockData = success
                    UserDefaultController().selectedMarket = success.exchange
                    
                    self?.symbol = success.symbol ?? ""
                    self?.netChange = success.netChange ?? ""
                    self?.netChangePerc = success.netChangePerc ?? ""
                    self?.lastTradePrice = success.lastTradePrice ?? ""
                    
                    self?.getSubscribeMarketWatchSymbols()
                    
                    debugPrint("market Symbol success: ")
                    
                case .failure(let failure):
                        self?.getAllMarketWatchBySymbolAPIResult = .onFailure(error: failure)
                    debugPrint("market Symbol failure: \(failure)")
                }
            }
        }
    }
    
    func GetCompaniesLookupsAPI(success:Bool) {
        
        let requestModel = GetCompaniesLookupsRequestModel()
        getCompaniesLookupsAPIResult = .onLoading(show: true)
        
        Task.init {
            await lookupsUseCase.GetCompaniesLookups(requestModel: requestModel) {[weak self] result in
                self?.getCompaniesLookupsAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    self?.getCompaniesLookupsAPIResult = .onSuccess(response: success)
                    
                    UserData.shared.saveCompanies(newCompanies: success)
                    
                    UserDefaultController().selectedSymbol = self?.symbol
                    UserDefaultController().selectedSymbolType = success.filter({$0.symbol == self?.symbol}).first?.marketType ?? ""
                    
                    self?.GetAllMarketWatchBySymbolAPI(success: true)

                case .failure(let failure):
                        self?.getCompaniesLookupsAPIResult = .onFailure(error: failure)
                    debugPrint("Edit watchlist list failure: \(failure)")

                }
            }
        }
    }


}

// MARK: SignalR
extension OrderEntryViewModel {
    func getSubscribeMarketWatchSymbols(){
        subscribleMarketWatchSymbolsAPIResult = .onLoading(show:  true)
        
        debugPrint("Username sent SignalR: \(UserDefaultController().username ?? "")")
        debugPrint("symbols sent SignalR: \(self.stockData?.symbol ?? "")")
    
        if Connection_Hub.shared.chatHub != nil {
            do {
                printToLog("test invoke subscribeMarketWatchSymbols '\(self.stockData?.symbol ?? "")'")
                try Connection_Hub.shared.chatHub?.invoke("SubscribeMarketWatchSymbols", arguments: [UserDefaultController().username ?? "", self.stockData?.symbol ?? ""]) { (result, error) in
                    if let e = error {
                        printToLog("SubscribeMarketWatchSymbols invoke '\(self.stockData?.symbol ?? "")' Error: \(e)")
                        self.subscribleMarketWatchSymbolsAPIResult = .onLoading(show:  false)
                    } else {
                        printToLog("SubscribeMarketWatchSymbols invoke '\(self.stockData?.symbol ?? "")' Success!, appDelegate.userNameNotEncryptrd\("info3@fitmena.com")")
                        self.subscribleMarketWatchSymbolsAPIResult = .onLoading(show:  false)
                    }
                }
            } catch let error {
                printToLog("SubscribeMarketWatchSymbols chatHub '\(self.stockData?.symbol ?? "")' error: \(error.localizedDescription)")
                self.subscribleMarketWatchSymbolsAPIResult = .onLoading(show:  false)

            }
        }
    }
    
    func UnSubscribleMarketWatchSymbols() {
        subscribleMarketWatchSymbolsAPIResult = .onLoading(show:  true)
        
        if Connection_Hub.shared.chatHub != nil {
            do {
                printToLog("test invoke unSubscribeMarketWatchSymbols")
                try Connection_Hub.shared.chatHub?.invoke(HubMethodType.unSubscribeMarketWatchSymbols.rawValue, arguments: [UserDefaultController().username ?? ""]) { (result, error) in
                    if let e = error {
                        printToLog("unSubscribeMarketWatchSymbols invoke Error: \(e)")
                    } else {
                        printToLog("unSubscribeMarketWatchSymbols invoke Success!, appDelegate.userNameNotEncryptrd\("info3@fitmena.com")")
                        printToLog("unSubscribeMarketWatchSymbols invoke result: \(result)")
                    }
                }
            } catch let error {
                printToLog("unSubscribeMarketWatchSymbols chatHub error: \(error.localizedDescription)")
            }
        }
    }

}

// MARK: Delegates
extension OrderEntryViewModel: MarketWatchDelegate {
    func onWatchlistDataReceive(data: GetMarketWatchByProfileIDUIModel) {
        self.subscribleMarketWatchSymbolsAPIResult = .onLoading(show:  false)
        
        self.stockData?.lastTradePrice = data.lastTradePrice
        self.stockData?.netChange = data.netChange
        self.stockData?.netChangePerc = data.netChangePerc

    }
}
