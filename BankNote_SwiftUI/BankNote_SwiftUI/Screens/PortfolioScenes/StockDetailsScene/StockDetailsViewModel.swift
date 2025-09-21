//
//  StockDetailsViewModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 11/09/2025.
//

import Foundation

class StockDetailsViewModel: ObservableObject {
    private let coordinator: PortfolioCoordinatorProtocol
    private let useCase: HomeUseCaseProtocol

    @Published var symbol = ""
    @Published var marketType = ""
    @Published var stockData:GetALLMarketWatchBySymbolUIModel?
    @Published var chartLoaded:Bool? = false

    @Published var getAllMarketWatchBySymbolAPIResult:APIResultType<GetALLMarketWatchBySymbolUIModel>?
    @Published var subscribleMarketWatchSymbolsAPIResult:APIResultType<[GetMarketWatchByProfileIDUIModel]>?

    init(coordinator: PortfolioCoordinatorProtocol, useCase: HomeUseCaseProtocol, symbol: String, marketType: String) {
        self.coordinator = coordinator
        self.useCase = useCase
        self.symbol = symbol
        self.marketType = marketType
        
        Connection_Hub.shared.marketWatchDelegate = self
    }
}

// MARK: Routing
extension StockDetailsViewModel {
    func popViewController() {
        coordinator.popViewController()
    }
    
    func goBack() {
        coordinator.popViewController()
    }
    
    func openOrderEntryScene() {
        SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getTradeCoordinator().openOrderEntryScene()
    }
}

// MARK: API Calls
extension StockDetailsViewModel {
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
                    
                    self?.getSubscribeMarketWatchSymbols()
                    
                    debugPrint("market Symbol success: ")
                    
                case .failure(let failure):
                        self?.getAllMarketWatchBySymbolAPIResult = .onFailure(error: failure)
                    debugPrint("market Symbol failure: \(failure)")
                }
            }
        }
    }
}

// MARK: SignalR
extension StockDetailsViewModel {
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
extension StockDetailsViewModel: MarketWatchDelegate {
    func onWatchlistDataReceive(data: GetMarketWatchByProfileIDUIModel) {
        self.subscribleMarketWatchSymbolsAPIResult = .onLoading(show:  false)
        
        self.stockData?.lastTradePrice = data.lastTradePrice
        self.stockData?.netChange = data.netChange
        self.stockData?.netChangePerc = data.netChangePerc

    }
}

