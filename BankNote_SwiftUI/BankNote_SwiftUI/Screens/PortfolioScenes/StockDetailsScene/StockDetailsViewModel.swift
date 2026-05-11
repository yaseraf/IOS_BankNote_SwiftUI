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
    private let tradeUseCase: TradeUseCaseProtocol

    @Published var symbol = ""
    @Published var marketType = ""
    @Published var stockData:GetALLMarketWatchBySymbolUIModel?
    @Published var chartLoaded:Bool? = false
    @Published var marketNewsBySymbol:[GetAllMarketNewsBySymbolUIModel]?
    @Published var getExpectedProfitLossList: [GetExpectedProfitLossUIModel]?
    @Published var expectedProfitLoss: GetExpectedProfitLossUIModel?
    @Published var ownedShares: Int?
    @Published var ordersData: [OrderListUIModel]?
    @Published var favoriteWatchlist:[GetMarketWatchByProfileIDUIModel] = []
    @Published var depthByPriceData: [StatisticsMarketUIModel]?
    @Published var fullMDData: SubscribeMarketWatchSymbolsUIModel?

    @Published var getAllMarketWatchBySymbolAPIResult:APIResultType<GetALLMarketWatchBySymbolUIModel>?
    @Published var subscribleMarketWatchSymbolsAPIResult:APIResultType<[GetMarketWatchByProfileIDUIModel]>?
    @Published var getAllMarketNewsBySymbolAPIResult:APIResultType<[GetAllMarketNewsBySymbolUIModel]>?
    @Published var GetExpectedProfitLossAPIResult:APIResultType<[GetExpectedProfitLossUIModel]>?
    @Published var getAllProfilesLookupsByUserCodeAPIResult:APIResultType<[GetAllProfilesLookupsByUserCodeUIModel]>?
    @Published var addMarketWatchProfileNameAPIResult:APIResultType<AddMarketWatchProfileNameUIModel>?
    @Published var getMarketWatchByProfileIDAPIResult:APIResultType<[GetMarketWatchByProfileIDUIModel]>?
    @Published var AddMarketWatchProfileSymbolsAPIResult:APIResultType<[AddMarketWatchProfileSymbolsUIModel]>?
    @Published var DeleteMarketWatchProfileSymbolsAPIResult:APIResultType<DeleteMarketWatchProfileSymbolsUIModel>?

    @Published var sendOrdersAPIResult: APIResultType<OrderListUIModel>?
    
    @Published var qtyT0: Int = 0
    @Published var qtyT1: Int = 0
    @Published var qtyT2: Int = 0

    init(coordinator: PortfolioCoordinatorProtocol, useCase: HomeUseCaseProtocol, tradeUseCase: TradeUseCaseProtocol, symbol: String, marketType: String) {
        self.coordinator = coordinator
        self.useCase = useCase
        self.tradeUseCase = tradeUseCase
        self.symbol = symbol
        self.marketType = marketType
        
        Connection_Hub.shared.marketWatchDelegate = self
        Connection_Hub.shared.orderListDelegate = self
        Connection_Hub.shared.keyStatisticsDelegate = self

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
    
    func initialGetAllProfilesLookupsByUserCodeAPI(success:Bool) {
        let requestModel = GetAllProfilesLookupsByUserCodeRequestModel()
        
        getAllProfilesLookupsByUserCodeAPIResult = .onLoading(show: true)
        
        Task.init {
            await tradeUseCase.GetAllProfilesLookupsByUserCode(requestModel: requestModel) {[weak self] result in
                switch result {
                case .success(let success):
                    self?.getAllProfilesLookupsByUserCodeAPIResult = .onSuccess(response: success)

                    if success.contains(where: {$0.profileName == "fav"}) {
                        UserDefaultController().profileID = success.first(where: {$0.profileName == "fav"})?.profileID ?? ""
                        self?.GetMarketWatchByProfileIDAPI(success: true)
                    } else {
                        self?.favoriteWatchlist = []
                    }
                    
                    debugPrint("Watchlist success")
                    
                case .failure(let failure):
                        self?.getAllProfilesLookupsByUserCodeAPIResult = .onFailure(error: failure)
                    debugPrint("Watchlist failure: \(failure)")
                }
            }
        }
    }

    func GetAllProfilesLookupsByUserCodeAPI(success:Bool, selectedSymbol: String) {
        let requestModel = GetAllProfilesLookupsByUserCodeRequestModel()
        
        getAllProfilesLookupsByUserCodeAPIResult = .onLoading(show: true)
        
        Task.init {
            await tradeUseCase.GetAllProfilesLookupsByUserCode(requestModel: requestModel) {[weak self] result in
                switch result {
                case .success(let success):
                    self?.getAllProfilesLookupsByUserCodeAPIResult = .onSuccess(response: success)

                    if success.contains(where: {$0.profileName == "fav"}) {
                        UserDefaultController().profileID = success.first(where: {$0.profileName == "fav"})?.profileID ?? ""
                        
                        self?.filterGetMarketWatchByProfileIDAPI(success: true, selectedSymbol: selectedSymbol)

                    } else {
                        UserDefaultController().profileName = "fav"
                        self?.AddMarketWatchProfileNameAPI(success: true, selectedSymbol: selectedSymbol)
                    }
                    
                    debugPrint("Watchlist success")
                    
                case .failure(let failure):
                        self?.getAllProfilesLookupsByUserCodeAPIResult = .onFailure(error: failure)
                    debugPrint("Watchlist failure: \(failure)")
                }
            }
        }
    }
    
    func AddMarketWatchProfileNameAPI(success:Bool, selectedSymbol: String) {
        let requestModel = AddMarketWatchProfileNameRequestModel()
        addMarketWatchProfileNameAPIResult = .onLoading(show: true)
        
        Task.init {
            await tradeUseCase.AddMarketWatchProfileName(requestModel: requestModel) {[weak self] result in
                self?.addMarketWatchProfileNameAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    self?.addMarketWatchProfileNameAPIResult = .onSuccess(response: success)
                    UserDefaultController().profileID = success.profileID ?? ""

                    self?.AddMarketWatchProfileSymbols(success:true, selectedSymbol: selectedSymbol)
                    
                    debugPrint("New watchlist added successfulll")
                    
                case .failure(let failure):
                        self?.addMarketWatchProfileNameAPIResult = .onFailure(error: failure)
                    debugPrint("New watchlist added failed")

                }
            }
        }
    }
    
    func filterGetMarketWatchByProfileIDAPI(success:Bool, selectedSymbol:String) {
        let requestModel = GetMarketWatchByProfileIDRequestModel()
        getMarketWatchByProfileIDAPIResult = .onLoading(show: true)
        
        Task.init {
            await tradeUseCase.GetMarketWatchByProfileID(requestModel: requestModel) {[weak self] result in
                self?.getMarketWatchByProfileIDAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    self?.getMarketWatchByProfileIDAPIResult = .onSuccess(response: success)
                    debugPrint("Get market watch by profile id success")

                    if success.contains(where: {$0.symbol == selectedSymbol}) {
                        self?.DeleteMarketWatchProfileSymbols(success: true, selectedSymbol: selectedSymbol)
                    } else {
                        self?.AddMarketWatchProfileSymbols(success: true, selectedSymbol: selectedSymbol)
                    }
                    
                    self?.favoriteWatchlist = success
                    
                case .failure(let failure):
                        self?.getMarketWatchByProfileIDAPIResult = .onFailure(error: failure)
                    debugPrint("Get market watch by profile id success: \(failure)")
                }
            }
        }
    }
    
    func AddMarketWatchProfileSymbols(success:Bool, selectedSymbol: String) {
        
        let requestModel = AddMarketWatchProfileSymbolsRequestModel(profileID: UserDefaultController().profileID ?? "", symbols: [selectedSymbol], webCode: KeyChainController.shared().webCode ?? "")
        
        AddMarketWatchProfileSymbolsAPIResult = .onLoading(show: true)
        
        Task.init {
            await tradeUseCase.AddMarketWatchProfileSymbols(requestModel: requestModel) {[weak self] result in
                self?.AddMarketWatchProfileSymbolsAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    self?.AddMarketWatchProfileSymbolsAPIResult = .onSuccess(response: success)

                    self?.GetMarketWatchByProfileIDAPI(success: true)

                    debugPrint("Add market wtach profile symbols success")
                    
                case .failure(let failure):
                        self?.AddMarketWatchProfileSymbolsAPIResult = .onFailure(error: failure)
                    debugPrint("Add market wtach profile symbols success: \(failure)")

                }
            }
        }
    }
    
    func DeleteMarketWatchProfileSymbols(success:Bool, selectedSymbol: String) {
        
        let requestModel = DeleteMarketWatchProfileSymbolsRequestModel(profileID: UserDefaultController().profileID ?? "", symbols: [selectedSymbol], webCode: KeyChainController.shared().webCode ?? "")
        
        DeleteMarketWatchProfileSymbolsAPIResult = .onLoading(show: true)
        
        Task.init {
            await tradeUseCase.DeleteMarketWatchProfileSymbols(requestModel: requestModel) {[weak self] result in
                self?.AddMarketWatchProfileSymbolsAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    self?.DeleteMarketWatchProfileSymbolsAPIResult = .onSuccess(response: success)
                    self?.GetMarketWatchByProfileIDAPI(success: true)

                    debugPrint("Delete market wtach profile symbols success")
                    
                case .failure(let failure):
                        self?.DeleteMarketWatchProfileSymbolsAPIResult = .onFailure(error: failure)
                    debugPrint("Delete market wtach profile symbols success: \(failure)")

                }
            }
        }
    }
    
    func GetMarketWatchByProfileIDAPI(success:Bool) {
        let requestModel = GetMarketWatchByProfileIDRequestModel()
        getMarketWatchByProfileIDAPIResult = .onLoading(show: true)
        
        Task.init {
            await tradeUseCase.GetMarketWatchByProfileID(requestModel: requestModel) {[weak self] result in
                self?.getMarketWatchByProfileIDAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    self?.getMarketWatchByProfileIDAPIResult = .onSuccess(response: success)
                    debugPrint("Get market watch by profile id success")
                    
                    self?.favoriteWatchlist = success
                    
                case .failure(let failure):
                        self?.getMarketWatchByProfileIDAPIResult = .onFailure(error: failure)
                    debugPrint("Get market watch by profile id success: \(failure)")
                }
            }
        }
    }

}

// MARK: SignalR
extension StockDetailsViewModel {
    func subscribeMDSymbol() {
    
        if Connection_Hub.shared.chatHub != nil {
            do {
                debugPrint("test invoke SubscribeFullMDSymbol '\(UserDefaultController().selectedSymbol ?? "")'")
                
                try Connection_Hub.shared.chatHub?.invoke(HubMethodType.subscribeMDSymbol.rawValue, arguments: [UserDefaultController().username ?? "", UserDefaultController().selectedSymbol ?? ""]) { (result, error) in
                    if let e = error {
                        debugPrint("SubscribeFullMDSymbol invoke '\(UserDefaultController().selectedSymbol ?? "")' Error: \(e)")
                    } else {
                        debugPrint("SubscribeFullMDSymbol invoke '\(UserDefaultController().selectedSymbol ?? "")' Success!")
                    }
                }
            } catch let error {
                debugPrint("SubscribeFullMDSymbol chatHub '\(UserDefaultController().selectedSymbol ?? "")' error: \(error.localizedDescription)")
            }
        }
    }

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
    
    private func extractUsableDepthByPrice(mBP: String){
        
        var listMarketByPrice:[StatisticsMarketUIModel] = []

        // Algorithm for cut the market data
        if(mBP != nil && mBP.components(separatedBy: ">").count > 3) {
            printToLog("setMarketDepthValue depthByPrice: \(mBP ?? "")")
            
            let depthByPrice = (mBP ?? "").replacingOccurrences(of: ">D10>", with: "").replacingOccurrences(of: ">D11>", with: "").replacingOccurrences(of: ">0001", with: "").replacingOccurrences(of: ">0002", with: "").replacingOccurrences(of: ">0003", with: "").replacingOccurrences(of: ">0004", with: "").replacingOccurrences(of: ">0005", with: "").replacingOccurrences(of: ">0006", with: "").replacingOccurrences(of: ">0007", with: "").replacingOccurrences(of: ">0008", with: "").replacingOccurrences(of: ">0009", with: "").replacingOccurrences(of: "#", with: "")
            print("setMarketDepthValue depthByPrice:",mBP)
            
            // if(appDelegate.isConnected && selectedSymbol.isFromTops && depthByPrice.components(separatedBy: ">").count > 6){
            //     let arrayData = depthByPrice.components(separatedBy: ">")
            //     let replaceString = ">" + arrayData[1] + ">" + arrayData[2] + ">" + arrayData[3] + ">" + arrayData[4]
            //     let replaceWithString = arrayData[2]
            //     depthByPrice = depthByPrice.replacingOccurrences(of: replaceString, with: replaceWithString)
            // }
            
            // ">DFM >0 >10 >1.18>9>1213663 >1.19>1>110000 >1.2>4>300000 >1.21>4>662000 >1.22>3>1103495 >1.23>5>1555300 >1.24>5>1002300 >1.25>17>3507770 >1.26>9>919394 >1.27>9>884500>#",
            

            let maxRow = Int(depthByPrice.components(separatedBy: ">")[1]) ?? 0
            printToLog("maxRow =\(maxRow)")
            
            if(maxRow > 0) {
                for i in 0..<maxRow {
                    let bidQty = (depthByPrice.components(separatedBy: ">")[(i * 3) + 4])
                    let bid = (depthByPrice.components(separatedBy: ">")[(i * 3) + 2])
                    listMarketByPrice.append(StatisticsMarketUIModel(bidQty: bidQty, bid: bid, askQty: "0", ask: "0"))
                }
                // "ARMX  >5  >2.78 >3>12500  >2.77>1 >80000  >2.75>4>216006  >2.74>1>100000  >2.72>2>77000   >4  >2.8  >1>126503 >2.83>1>250000  >2.85 >2>37000  >2.86>1>10000>",
                // "TAQA  >5  >0.435>1>50000  >0.432>2>88453  >0   >0>0       >0   >0>0       >0   >0>0       >5  >0.479>1>173611 >0.48>2>250498  >0.481>1>300000 >0.482>1>150000 >0.494>1>28000>",
            }
            
            var secondMaxRow = 0
            var offerIndex = 2 + (maxRow * 3)
            printToLog("depthByPrice offerIndex = \(offerIndex)")
            
            if depthByPrice.components(separatedBy: ">").count > offerIndex {
                
                secondMaxRow = Int(depthByPrice.components(separatedBy: ">")[offerIndex]) ?? 0
                printToLog("depthByPrice secondMaxRow = \(secondMaxRow)")
                
                while (secondMaxRow == 0) && (depthByPrice.components(separatedBy: ">").count > offerIndex)
                        && (depthByPrice.components(separatedBy: ">")[offerIndex].isEmpty) {
                    
                    if (secondMaxRow == 0) && (depthByPrice.components(separatedBy: ">")[offerIndex].isEmpty) {
                        if depthByPrice.components(separatedBy: ">").count > (offerIndex + 3) {
                            if depthByPrice.components(separatedBy: ">")[offerIndex + 1].isEmpty
                                && depthByPrice.components(separatedBy: ">")[offerIndex + 2].isEmpty {
                                
                                offerIndex += 3
                                secondMaxRow = Int(depthByPrice.components(separatedBy: ">")[offerIndex]) ?? 0
                                
                                printToLog("depthByPrice new offerIndex = \(offerIndex)")
                                printToLog("depthByPrice new secondMaxRow = \(secondMaxRow)")
                            }
                        }
                    }
                }
                
                for i in 0..<secondMaxRow {
                    let cnstnt = offerIndex + 1
                    let clientOfferQty = (depthByPrice.components(separatedBy: ">")[cnstnt + (i * 3) + 1])
                    let askQty = (depthByPrice.components(separatedBy: ">")[cnstnt + (i * 3) + 2])
                    let ask = (depthByPrice.components(separatedBy: ">")[cnstnt + (i * 3)])
                    
                    if i < listMarketByPrice.count {
                        listMarketByPrice[i].ask = ask
                        listMarketByPrice[i].askQty = askQty
                    }
                    else {
                        listMarketByPrice.append(StatisticsMarketUIModel(bidQty: "0", bid: "0", askQty: askQty, ask: ask))
                    }
                }
            }
            
            if max(maxRow, secondMaxRow) < 15 {
                for _ in max(maxRow, secondMaxRow)..<15{
                    listMarketByPrice.append(StatisticsMarketUIModel(bidQty: "0", bid: "0", askQty: "0", ask: "0"))
                }
            }
            

        }
        else {
            for _ in 0..<15{
                listMarketByPrice.append(StatisticsMarketUIModel(bidQty: "0", bid: "0", askQty: "0", ask: "0"))
            }

        }

        depthByPriceData = listMarketByPrice

        
        debugPrint("Print here")
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

extension StockDetailsViewModel: KeyStatisticsDelegate {
    func onSubscribeMDSymbol(model: SubscribeMarketWatchSymbolsUIModel) {
        fullMDData = model
        extractUsableDepthByPrice(mBP: model.MBP ?? "")
    }
}
