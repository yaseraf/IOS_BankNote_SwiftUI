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

    @Published var symbol:String?
    @Published var netChange:String = ""
    @Published var netChangePerc:String = ""
    @Published var lastTradePrice:String = ""
    @Published var price: String = "0"
    @Published var shares: String = "0"
    @Published var orderValue: String = ""
    @Published var placeOrderType: PlaceOrderType = .buy
    @Published var orderPriceType: OrderPriceType = .limit
    @Published var stockData:GetALLMarketWatchBySymbolUIModel?
    @Published var newMarketSymbol:GetALLMarketWatchBySymbolUIModel?
    @Published var orderDetails: OrderListUIModel?
    @Published var riskManagementData: GetRiskManagementUIModel?
    @Published var availableAmount: String?
    @Published var isEditOrder: Bool = false
    @Published var flagMessage: String = ""
    @Published var isRiskManagementLoading: Bool = false
    @Published var portfolioData: GetPortfolioUIModel?

    @Published var arrayOfQuantities: [ArrayOfQuantities] = []
    struct ArrayOfQuantities {
        var quantity: Double
    }

    @Published var getAllMarketWatchBySymbolAPIResult:APIResultType<GetALLMarketWatchBySymbolUIModel>?
    @Published var subscribleMarketWatchSymbolsAPIResult:APIResultType<[GetMarketWatchByProfileIDUIModel]>?
    @Published var getCompaniesLookupsAPIResult:APIResultType<[GetCompaniesLookupsUIModel]>?
    @Published var getRiskManagementAPIResult:APIResultType<GetRiskManagementUIModel>?
    @Published var getPortfolioAPIResult:APIResultType<GetPortfolioUIModel>?

    init(coordinator: OrdersCoordinatorProtocol, useCase: HomeUseCaseProtocol, lookupsUseCase: LookupsUseCaseProtocol, orderDetails: OrderListUIModel, placeOrderType: PlaceOrderType, isEditOrder: Bool) {
        self.coordinator = coordinator
        self.useCase = useCase
        self.lookupsUseCase = lookupsUseCase
        self.orderDetails = orderDetails
        self.placeOrderType = placeOrderType
        self.isEditOrder = isEditOrder
        
        Connection_Hub.shared.marketWatchDelegate = self
        Connection_Hub.shared.notifyOrderDelegate = self

        if isEditOrder {
            shares = orderDetails.TotalVolume ?? ""
            price = orderDetails.Price ?? ""
            
            orderPriceType = orderDetails.OrderTypeCode == "1" ? .market : .limit
            self.placeOrderType = orderDetails.SellBuyFlag?.lowercased() == "b" ? .buy : .sell
        }
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
     
    func openOrderDetailsScene() {
        
        let doubleShares = Double(shares) ?? 0
        let doubleTotalVolume = Double(orderDetails?.TotalVolume ?? "") ?? 0
        let doubleRemaining = Double(orderDetails?.Remaining ?? "") ?? 0

        let orderPreview = OrderListUIModel(
            AccountID: KeyChainController.shared().accountID,
            AccountNameA: UserDefaultController().selectedUserAccount?.ClientNameA ?? "",
            AccountNameE: UserDefaultController().selectedUserAccount?.ClientNameE ?? "",
            AvgExePrice: "",
            ClientID: KeyChainController.shared().clientID ?? "",
//            ClientID: "-1",
            CompanyShortNameA: "",
            CompanyShortNameE: "",
            EntryDate: isEditOrder ? orderDetails?.EntryDate ?? "" : Date().toString(dateFormat: .ddMMyyyyHHmmss),
            Exchange: newMarketSymbol?.exchange ?? "",
            ExecOrderComm: "",
            ExecQty: shares,
            MaxPrice: "",
            MinFillQty: isEditOrder ? orderDetails?.MinFillQty ?? "" : "0",
            MinPrice: "",
            ModifyDate: "",
            NIN: UserDefaultController().selectedUserAccount?.NIN ?? "",
            OrdComm: "",
            OrderID: isEditOrder ? orderDetails?.OrderID ?? "" : "",
//            OrderValue: isEditOrder ? orderDetails?.LocalValue ?? "" : orderValue,
            OrderValue: orderValue,
            OrderTypeCode: orderPriceType == .limit ? "2" : "1",
            OriginCode: "",
            Precision: "",
            Price: isEditOrder ? orderDetails?.Price ?? "" : price.isEmpty ? "0" : price,
            RejectReason: "",
            Remaining: shares,
            Remark: "",
            SMART_ORDER_ID: "",
            SellBuyFlag: placeOrderType == .buy ? "B" : "S",
            StatusCode: orderDetails?.StatusCode ?? "",
            StopLossPx: "",
            Symbol: newMarketSymbol?.symbol ?? "",
            TotalVolume: isEditOrder ? String(doubleShares + (doubleTotalVolume - doubleRemaining)) : shares,
            ValidityCode: "0001", // Today
            ValidityDate: Date().toString(dateFormat: .ddMMyyyyHHmmss),
            VisibleQty: isEditOrder ? orderDetails?.VisibleQty ?? "" : "0",
            BANK_ACCOUNT_NO: "",
            SmartOrderID: "",
            Sett_type: "2",
            CustodianID: UserDefaultController().CUSTODYID ?? "",
//            CustodianID: "-1",
            cur_Code: "",
            TrxnID: isEditOrder ? orderDetails?.TrxnID ?? "0" : "0",
            SymbolCode: UserDefaultController().selectedSymbolID ?? "",
            BookCode: "",
            BrokerID: "",
            SourceCode: "",
            UserID: "",
            OrigUserID: "",
            MarketTypeCode: newMarketSymbol?.marketType ?? "",
            Source2Code: "",
            ProcSentFlag: "",
            MarketOrderID: isEditOrder ? orderDetails?.MarketOrderID ?? "" : "",
            IntOrderID: "",
            MsgCode: "",
            SenderSubID: "",
            BuyerMember: "",
            SellerMember: "",
            IsinCode: "",
            FIXOrderID: isEditOrder ? orderDetails?.FIXOrderID ?? "" : "",
            TP_price: isEditOrder ? orderDetails?.TP_price ?? "" : "0",
            SL_price: isEditOrder ? orderDetails?.SL_price ?? "" : "0",
            TR_price: "",
            Max_TR_price: "",
            TR_Price_is_perc: "",
            BE_Price: "",
            SPL_Order_flag: "",
            ApprovalStatusCode: "",
            ApprovalTypeCode: "",
            SenderCompanyID: "",
            LocalValue: "",
            SymbolLongName: "",
            B_OutOfMarketType: "",
            B_OutOfMarketDate: "",
            B_GroupName: "",
            IP_Address: "",
            LastUpdateTime: "",
            SmartOrderTypeDesc_E: "",
            SmartOrderTypeDesc_A: "",
            SymbolNameE: "",
            SymbolNameA: ""
            )
        
        coordinator.openOrderDetailsScene(orderPreview: orderPreview, riskManagementData: riskManagementData ?? .initializer(), isEditOrder: isEditOrder)
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
                    self?.newMarketSymbol = success

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
    
//    func GetCompaniesLookupsAPI(success:Bool) {
//        
//        let requestModel = GetCompaniesLookupsRequestModel()
//        getCompaniesLookupsAPIResult = .onLoading(show: true)
//        
//        Task.init {
//            await lookupsUseCase.GetCompaniesLookups(requestModel: requestModel) {[weak self] result in
//                self?.getCompaniesLookupsAPIResult = .onLoading(show: false)
//                switch result {
//                case .success(let success):
//                    self?.getCompaniesLookupsAPIResult = .onSuccess(response: success)
//                    
//                    UserData.shared.saveCompanies(newCompanies: success)
//                    
//                    UserDefaultController().selectedSymbol = self?.orderDetails?.Symbol
//                    UserDefaultController().selectedSymbolType = success.filter({$0.symbol == self?.symbol}).first?.marketType ?? ""
//                    
//                    self?.GetAllMarketWatchBySymbolAPI(success: true)
//
//                case .failure(let failure):
//                        self?.getCompaniesLookupsAPIResult = .onFailure(error: failure)
//                    debugPrint("Edit watchlist list failure: \(failure)")
//
//                }
//            }
//        }
//    }
    
    func getRiskManagementAPI(success: Bool) {
        let totalVolume = Double(orderDetails?.TotalVolume ?? "") ?? 0 // Modify
        let remaining = Double(orderDetails?.Remaining ?? "") ?? 0 // Modify
        
        let requestModel = GetRiskManagementRequestModel(
            accountID: UserDefaultController().selectedUserAccount?.AccountID,
            clientID: KeyChainController.shared().clientID,
            compInit: KeyChainController.shared().compInit,
            custodyID: "-1",
            includeFacil: "Y",
            includeMargin: "Y",
            leverage: "0",
            mainClientID: KeyChainController.shared().mainClientID,
            memberID: KeyChainController.shared().brokerID,
            nin: UserDefaultController().selectedUserAccount?.NIN,
            orderID: (isEditOrder ? orderDetails?.OrderID : "-1"),
            orderType: placeOrderType == .buy ? "B" : "S",
            portMang: KeyChainController.shared().brokerID,
//            price: isEditOrder ? orderDetails?.Price : price,
            price: price,
//            qty: isEditOrder ? orderDetails?.ExecQty : shares,
            qty: shares,
//            symbol: (isEditOrder ? newMarketSymbol?.symbol : placeOrderUIModel?.symbol),
            symbol: (newMarketSymbol?.symbol),
//            typeCode: (isEditOrder ? newMarketSymbol?.marketType : placeOrderUIModel?.marketType),
            typeCode: (newMarketSymbol?.marketType),
            uCode: KeyChainController.shared().UCODE,
            userCat: KeyChainController.shared().userType,
            validity: Date().toString(dateFormat: .ddMMyyyyHHmmss),
//            validityCode: UserDefaultController().tifList?.filter({$0.id?.lowercased() == "0001"}).first?.id, // GTD
            validityCode: "0001", // GTD
            settType: "2",
            webCode: KeyChainController.shared().webCode)
        
        isRiskManagementLoading = true
        getRiskManagementAPIResult = .onLoading(show: true)
        
        Task.init {
            await useCase.GetRiskManagement(requestModel: requestModel) {[weak self] result in
                self?.getRiskManagementAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    self?.getRiskManagementAPIResult = .onSuccess(response: success)
                    self?.isRiskManagementLoading = false
                    self?.riskManagementData = success
                    self?.availableAmount = success.buyPower ?? "0"
                    self?.orderValue = success.orderValue ?? ""
                    self?.flagMessage = AppUtility.shared.isRTL ? success.flagMsgA ?? "" : success.flagMsgE ?? ""
                   
                case .failure(let failure):
                    self?.getRiskManagementAPIResult = .onFailure(error: failure)
                    self?.isRiskManagementLoading = false
                    debugPrint("risk management failure: \(failure)")
                }
            }
        }

    }

    func callGetPortfolioAPI(success: Bool) {
                
        let requestModel = GetPortfolioRequestModel()
        
        getPortfolioAPIResult = .onLoading(show: true)
        
        Task.init {
            await useCase.getPortfolio(requestModel: requestModel) {[weak self] result in
                
                self?.getPortfolioAPIResult = .onLoading(show: false)
                
                switch result {
                case .success(let success):
                    
                    debugPrint("Success to get user portfolio")
                        self?.getPortfolioAPIResult = .onSuccess(response: success)
                    
                    self?.portfolioData = success
                    self?.prepareOrders()
                    
                case .failure(let failure):
                        debugPrint("Failed to get user portfolio")
                        self?.getPortfolioAPIResult = .onFailure(error: failure)
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
                try Connection_Hub.shared.chatHub?.invoke("SubscribeMarketWatchSymbols", arguments: [UserDefaultController().username ?? "", [self.stockData?.symbol ?? ""]]) { (result, error) in
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

// MARK: Functions
extension OrderEntryViewModel {
    func prepareOrders() {
        for item in portfolioData?.portfolioes ?? [] {
            if item.symbol == UserDefaultController().selectedSymbol {
                arrayOfQuantities.append(ArrayOfQuantities(quantity: item.qty ?? 0))
            }
        }
    }

    func onMaxTap() {
        if placeOrderType == .buy {
            shares = availableAmount ?? ""
        } else {
            var allShares = 0
            
            for item in arrayOfQuantities {
                allShares += Int(item.quantity)
            }
            
            shares = String(allShares)
        }
    }
    func CheckPriceWithinRange() {
        if orderPriceType == .market {
            flagMessage = ""
            getRiskManagementAPI(success: true)
            return
        }
        
        if Double(price) ?? 0 >= Double(newMarketSymbol?.minPrice ?? "") ?? 0 && Double(price) ?? 0 <= Double(newMarketSymbol?.maxPrice ?? "") ?? 0 {
            flagMessage = ""
            getRiskManagementAPI(success: true)
            return
        } else {
            flagMessage = AppUtility.shared.isRTL ? "يجب أن يكون السعر المحدد بين \(newMarketSymbol?.minPrice ?? "") و \(newMarketSymbol?.maxPrice ?? "")" : "Limit price must be between \(newMarketSymbol?.minPrice ?? "") and \(newMarketSymbol?.maxPrice ?? "")"
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
        self.newMarketSymbol?.minPrice = data.minPrice
        self.newMarketSymbol?.maxPrice = data.maxPrice

    }
}

extension OrderEntryViewModel: NotifyOrderDelegate {
    func onNotifyOrder(newOrder: SendOrdersUIModel) {
        
    }
    
    func onNewOrder(newOrder: OrderListUIModel) {
        if orderDetails?.OrderID == newOrder.OrderID {
            orderDetails = newOrder
            
            if newOrder.StatusCode == "s" || newOrder.StatusCode == "c" {
                SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getTradeCoordinator().start()
            } else {
                getRiskManagementAPI(success: true)
            }
        }
    }
}
