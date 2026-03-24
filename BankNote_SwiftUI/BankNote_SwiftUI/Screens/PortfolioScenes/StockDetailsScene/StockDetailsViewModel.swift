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
    @Published var marketNewsBySymbol:[GetAllMarketNewsBySymbolUIModel]?
    @Published var getExpectedProfitLossList: [GetExpectedProfitLossUIModel]?
    @Published var expectedProfitLoss: GetExpectedProfitLossUIModel?
    @Published var ownedShares: Int?
    @Published var ordersData: [OrderListUIModel]?

    @Published var getAllMarketWatchBySymbolAPIResult:APIResultType<GetALLMarketWatchBySymbolUIModel>?
    @Published var subscribleMarketWatchSymbolsAPIResult:APIResultType<[GetMarketWatchByProfileIDUIModel]>?
    @Published var getAllMarketNewsBySymbolAPIResult:APIResultType<[GetAllMarketNewsBySymbolUIModel]>?
    @Published var GetExpectedProfitLossAPIResult:APIResultType<[GetExpectedProfitLossUIModel]>?

    @Published var sendOrdersAPIResult: APIResultType<OrderListUIModel>?
    
    @Published var qtyT0: Int = 0
    @Published var qtyT1: Int = 0
    @Published var qtyT2: Int = 0

    init(coordinator: PortfolioCoordinatorProtocol, useCase: HomeUseCaseProtocol, symbol: String, marketType: String) {
        self.coordinator = coordinator
        self.useCase = useCase
        self.symbol = symbol
        self.marketType = marketType
        
        Connection_Hub.shared.marketWatchDelegate = self
        Connection_Hub.shared.orderListDelegate = self

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.sendOrdersSignalR()
        }

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
    
    func openOrderEntryScene(placeOrderType: PlaceOrderType) {
        SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getOrdersCoordinator().openOrderEntryScene(orderDetails: .initializer(), placeOrderType: placeOrderType, isEditOrder: false)
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
    
    func GetAllMarketNewsBySymbol(success:Bool) {
        let requestModel = GetAllMarketNewsBySymbolRequestModel()
        getAllMarketNewsBySymbolAPIResult = .onLoading(show: true)
        
        Task.init {
            await useCase.GetAllMarketNewsBySymbol(requestModel: requestModel) {[weak self] result in
                self?.getAllMarketNewsBySymbolAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    self?.getAllMarketNewsBySymbolAPIResult = .onSuccess(response: success)
                    debugPrint("market news by symbol stocks success")
                    self?.marketNewsBySymbol = success

                case .failure(let failure):
                        self?.getAllMarketNewsBySymbolAPIResult = .onFailure(error: failure)
                    debugPrint("market news by symbol stocks failure")
                }
            }
        }
    }
    
    func GetExpectedProfitLossAPI(success:Bool) {
        let requestModel = GetExpectedProfitLossRequestModel()
        
        GetExpectedProfitLossAPIResult = .onLoading(show: true)

        Task.init {
            await useCase.GetExpectedProfitLoss(requestModel: requestModel) {[weak self] result in

                self?.GetExpectedProfitLossAPIResult = .onLoading(show: false)

                switch result {
                case .success(let success):
                    self?.GetExpectedProfitLossAPIResult = .onSuccess(response: success)
                    debugPrint("get expected profit loss success")
                    
                    self?.getExpectedProfitLossList = success
                    
                    self?.filterExpectedProfitLossList()
                    
                    
                case .failure(let failure):
                        self?.GetExpectedProfitLossAPIResult = .onFailure(error: failure)
                    debugPrint("get expected profit loss failure: \(failure)")

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
                debugPrint("test invoke subscribeMarketWatchSymbols '\(self.stockData?.symbol ?? "")'")
                try Connection_Hub.shared.chatHub?.invoke("SubscribeMarketWatchSymbols", arguments: [UserDefaultController().username ?? "", [self.stockData?.symbol ?? ""]]) { (result, error) in
                    if let e = error {
                        debugPrint("SubscribeMarketWatchSymbols invoke '\(self.stockData?.symbol ?? "")' Error: \(e)")
                        self.subscribleMarketWatchSymbolsAPIResult = .onLoading(show:  false)
                    } else {
                        debugPrint("SubscribeMarketWatchSymbols invoke '\(self.stockData?.symbol ?? "")' Success!, appDelegate.userNameNotEncryptrd\("info3@fitmena.com")")
                        self.subscribleMarketWatchSymbolsAPIResult = .onLoading(show:  false)
                    }
                }
            } catch let error {
                debugPrint("SubscribeMarketWatchSymbols chatHub '\(self.stockData?.symbol ?? "")' error: \(error.localizedDescription)")
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
    }
    
    func sendOrdersSignalR(){
        debugPrint("Trying signalR method")
        if Connection_Hub.shared.isConnected() {
            debugPrint("SignalR is connected")
        } else {
            debugPrint("SignalR is not connected")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.sendOrdersSignalR()
            }
        }
        
        sendOrdersAPIResult = .onLoading(show:  true)
        
        if Connection_Hub.shared.chatHub != nil {
            do {
                
                let string = "[{\"ClientID\": \"\(KeyChainController.shared().clientID ?? "")\" , \"WebUserID\": \"\(KeyChainController.shared().webCode ?? "")\" , \"Exchange\": \"\" , \"Symbol\": \"\" , \"OrderID\": \"\" , \"SellBuyFlag\": \"\"}]"
                
                let data = string.data(using: .utf8)!
                do {
                    if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [Dictionary<String,Any>] {

                        try Connection_Hub.shared.chatHub?.invoke(HubMethodType.sendOrders.rawValue, arguments: [UserDefaultController().username ?? "", jsonArray[0]]) { (result, error) in
                            if let e = error {
                                printToLog("sendOrders invoke Error: \(e)")
                            } else {
                                self.sendOrdersAPIResult = .onLoading(show: false)
                                printToLog("sendOrders invoke, \([UserDefaultController().username ?? "", jsonArray[0]]) Success!")
//                                self.GetLookupsAPI(success: true)

                            }
                        }
                    } else {
                        printToLog("sendOrders bad json")
                    }
                } catch let error {
                        printToLog("sendOrders chatHub error: \(error.localizedDescription)")
                    }
                  }  catch let error {
                      printToLog("sendOrders chatHub error: \(error.localizedDescription)")
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

// MARK: Functions
extension StockDetailsViewModel {
    func filterExpectedProfitLossList() {
        for i in 0..<(getExpectedProfitLossList?.count ?? 0) {
            if getExpectedProfitLossList?[i].symbol == UserDefaultController().selectedSymbol ?? "" && getExpectedProfitLossList?[i].custodianID == UserDefaultController().selectedCustodian ?? "" {
                expectedProfitLoss = getExpectedProfitLossList?[i]
                ownedShares = Int(expectedProfitLoss?.qtyT0 ?? 0) + Int(expectedProfitLoss?.qtyT1 ?? 0) + Int(expectedProfitLoss?.qtyT2 ?? 0)
            } else if getExpectedProfitLossList?[i].symbol == UserDefaultController().selectedSymbol ?? "" && (UserDefaultController().selectedCustodian == "" || UserDefaultController().selectedCustodian == nil) {
                UserDefaultController().selectedCustodian = getExpectedProfitLossList?[i].custodianID
                expectedProfitLoss = getExpectedProfitLossList?[i]
                ownedShares = Int(expectedProfitLoss?.qtyT0 ?? 0) + Int(expectedProfitLoss?.qtyT1 ?? 0) + Int(expectedProfitLoss?.qtyT2 ?? 0)
                
            }
        }
    }
}

// MARK: Delegates
extension StockDetailsViewModel: OrderListDelegate {
    func onOrderReceived(orders: [OrderListUIModel]) {
        ordersData = orders.sorted { first, second in
            let firstDate = AppUtility.shared.orderDateFromString(first.ModifyDate) ?? .distantPast
            let secondDate = AppUtility.shared.orderDateFromString(second.ModifyDate) ?? .distantPast
            return firstDate > secondDate // NEWEST FIRST
        }
        
        ordersData = ordersData?.filter({$0.Symbol == stockData?.symbol})

    }
}
