//
//  OrderDetailsViewModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 22/10/2025.
//

import Foundation

class OrderDetailsViewModel: ObservableObject {
    private let coordinator: OrdersCoordinatorProtocol
    private let useCase: HomeUseCaseProtocol
    
    @Published var orderPreview:OrderListUIModel?
    @Published var riskManagementData: GetRiskManagementUIModel?
    @Published var isEditOrder: Bool = false
    @Published var sendOrdersAPIResult: APIResultType<OrderListUIModel>?
    @Published var GetExpectedProfitLossAPIResult:APIResultType<[GetExpectedProfitLossUIModel]>?
    @Published var updateBankNotesTransQtyAPIResult:APIResultType<UpdateBankNotesTransQTYUIModel>?
    @Published var getPortfolioAPIResult:APIResultType<GetPortfolioUIModel>?

    @Published var portfolioData: GetPortfolioUIModel?
    @Published var getExpectedProfitLossList: [GetExpectedProfitLossUIModel]?
    @Published var expectedProfitLoss: GetExpectedProfitLossUIModel?
    @Published var ownedShares: Int?
    
    @Published var qtyT0: Int = 0
    @Published var qtyT1: Int = 0
    @Published var qtyT2: Int = 0
    
    @Published var sharesToTrade = ""
    @Published var tradeOnT0 = ""
    @Published var tradeOnT1 = ""
    @Published var tradeOnT2 = ""
    
    struct ArrayOfOrders {
        var custodianID: String
        var clientID: String
        var t0: Double
        var t1: Double
        var t2: Double
    }
    
    struct ReadyToSendOrders {
        var custodianID: String
        var clientID: String
        var settlement: String
        var quantity: Int
    }

    @Published var arrayOfOrders: [ArrayOfOrders] = []
    @Published var readyToSendOrders: [ReadyToSendOrders] = []
    

    init(coordinator: OrdersCoordinatorProtocol, useCase: HomeUseCaseProtocol, orderPreview: OrderListUIModel, riskManagementData: GetRiskManagementUIModel, isEditOrder: Bool) {
        self.coordinator = coordinator
        self.useCase = useCase
        self.orderPreview = orderPreview
        self.riskManagementData = riskManagementData
        self.isEditOrder = isEditOrder
        
        if !isEditOrder {
            callGetPortfolioAPI(success: true)
        }
    }
}


// MARK: Routing
extension OrderDetailsViewModel {
    func popViewController() {
        coordinator.popViewController()
    }
}

// MARK: API Calls
extension OrderDetailsViewModel {
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

    func callUpdateBankNotesTransQTYAPI(success:Bool, quantity: String) {
        let requestModel = UpdateBankNotesTransQTYRequestModel(
            ClientID: KeyChainController().clientID ?? "",
            DOC_NO: "", // Empty
            MainClientID: KeyChainController().mainClientID ?? "",
            PORDER_ID: "", // Empty
            QTY: "1",
            Source: "T", // B Bank notes / T Transactions
            TRANSTYPE: "U", // A Add / U Used
            WebCode: KeyChainController().webCode ?? ""
        )
        
        updateBankNotesTransQtyAPIResult = .onLoading(show: true)
        
        Task.init {
            await useCase.UpdateBankNotesTransQTY(requestModel: requestModel) {[weak self] result in
                self?.updateBankNotesTransQtyAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    self?.updateBankNotesTransQtyAPIResult = .onSuccess(response: success)
                    debugPrint("update BankNotesTransQty success")
                    
//                    self?.coordinator.popViewController()
                    SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getOrdersCoordinator().start()

                    
                case .failure(let failure):
                        self?.updateBankNotesTransQtyAPIResult = .onFailure(error: failure)
                    debugPrint("update BankNotesTransQty failed")
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
extension OrderDetailsViewModel {
    func sendAddOrderRequest(order: [String: String]){
        sendOrdersAPIResult = .onLoading(show: true)
        
        if Connection_Hub.shared.chatHub != nil {
            do {
                printToLog("test invoke sendAddOrderRequest")
                // Invoke server method and handle response
                
                var strData = "[{"
                //\"ClientID\": \"\(clientId)\" , \"Symbol\": \"\(symbol)\"  , \"WebUserID\": \"\(appDelegate.WebCode)\"}]"
                
                order.forEach { (key, value) in
                    strData += " \"\(key)\": \"\(value)\","
                }
                
                strData.removeLast()
                strData += "}]"
                debugPrint("sendAddOrderRequest strData: \(strData)")
                
                let data = strData.data(using: .utf8)!
                do {
                    if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [Dictionary<String,String>] {
                        debugPrint("sendAddOrderRequest jsonArray:\(jsonArray)") // use the json here
                        
                        if jsonArray.count > 0 {
                            try Connection_Hub.shared.chatHub?.invoke(HubMethodType.sendAddOrderRequest.rawValue, arguments: [KeyChainController().username ?? "", jsonArray[0]]) { (result, error) in
                                if let e = error {
                                    debugPrint("sendAddOrderRequest invoke Error: \(e)")
                                } else {
                                    debugPrint("sendAddOrderRequest invoke, \([KeyChainController().username ?? "", jsonArray[0]]) Success!, appDelegate.userNameNotEncryptrd\("info3@fitmena.com")")
                                    
                                    self.callUpdateBankNotesTransQTYAPI(success: true, quantity: "1")
                                    
//                                    UserDefaultController().price = nil
//                                    UserDefaultController().qty = nil
//                                    UserDefaultController().isMarketPrice = nil
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        self.sendOrdersAPIResult = .onLoading(show: false)
//                                        self.coordinator.dismiss()
//                                        SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getOrdersCoordinator().start()
                                    }
                                }
                            }
                        }
                        else {
                        }
                    } else {
                        debugPrint("sendAddOrderRequest bad json")
                    }
                } catch let error as NSError {
                    debugPrint("sendAddOrderRequest JSONSerialization error:\(error)")
                }
                
            } catch let error {
                debugPrint("sendAddOrderRequest chatHub error: \(error.localizedDescription)")
            }
          }
        }

}

func convertDateFormat(_ dateString: String) -> String? {
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
    inputFormatter.locale = Locale(identifier: "en_US_POSIX")

    let outputFormatter = DateFormatter()
    outputFormatter.dateFormat = "ddMMyyyyHHmmss"
    outputFormatter.locale = Locale(identifier: "en_US_POSIX")

    if let date = inputFormatter.date(from: dateString) {
        return outputFormatter.string(from: date)
    }

    return dateString
}

// MARK: Functions
extension OrderDetailsViewModel {
    func orderCountToTrade(orderQty: Int) {
        
        var remaining = orderQty
                
        // T0
        let takeT0 = min(remaining, qtyT0)
        readyToSendOrders.append(
            ReadyToSendOrders(
                custodianID: UserDefaultController().selectedCustodian ?? "",
                clientID: KeyChainController().clientID ?? "",
                settlement: "0",
                quantity: takeT0
            )
        )
        remaining -= takeT0
        
        // T1
        if remaining > 0 {
            let takeT1 = min(remaining, qtyT1)
            readyToSendOrders.append(
                ReadyToSendOrders(
                    custodianID: UserDefaultController().selectedCustodian ?? "",
                    clientID: KeyChainController().clientID ?? "",
                    settlement: "1",
                    quantity: takeT1
                )
            )
            remaining -= takeT1
        }
        
        // T2
        if remaining > 0 {
            let takeT2 = min(remaining, qtyT2)
            readyToSendOrders.append(
                ReadyToSendOrders(
                    custodianID: UserDefaultController().selectedCustodian ?? "",
                    clientID: KeyChainController().clientID ?? "",
                    settlement: "2",
                    quantity: takeT2
                )
            )
            remaining -= takeT2
        }
        
        if remaining > 0 {
            // Case Multi-Custodian
            // Go through custodians
            CheckMultiCustodian(remaining: remaining)
        }
    }
    
    func CheckMultiCustodian(remaining: Int) {
        // Ignore the selected custodian, look for others, store them in array and store their settlements
        var remain = remaining
        
        let tempExpectedList = getExpectedProfitLossList?.filter({$0.custodianID != UserDefaultController().selectedCustodian ?? ""})
        
        for i in 0..<(tempExpectedList?.count ?? 0) {
            if getExpectedProfitLossList?[i].symbol == UserDefaultController().selectedSymbol ?? "" {
                arrayOfOrders.append(
                    ArrayOfOrders(
                        custodianID: tempExpectedList?[i].custodianID ?? "",
                        clientID: tempExpectedList?[i].clientID ?? "",
                        t0: tempExpectedList?[i].qtyT0 ?? 0,
                        t1: tempExpectedList?[i].qtyT1 ?? 0,
                        t2: tempExpectedList?[i].qtyT2 ?? 0
                    )
                )
            }
        }
        
        for i in 0..<arrayOfOrders.count {
            
            // T0
            let takeT0 = min(remain, Int(arrayOfOrders[i].t0))
            readyToSendOrders.append(
                ReadyToSendOrders(
                    custodianID: arrayOfOrders[i].custodianID,
                    clientID: arrayOfOrders[i].clientID,
                    settlement: "0",
                    quantity: takeT0
                )
            )
            remain -= takeT0
            
            // T1
            if remain > 0 {
                let takeT1 = min(remain, Int(arrayOfOrders[i].t1))
                readyToSendOrders.append(
                    ReadyToSendOrders(
                        custodianID: arrayOfOrders[i].custodianID,
                        clientID: arrayOfOrders[i].clientID,
                        settlement: "1",
                        quantity: takeT1
                    )
                )
                remain -= takeT1
            }
            
            // T2
            if remain > 0 {
                let takeT2 = min(remain, Int(arrayOfOrders[i].t2))
                readyToSendOrders.append(
                    ReadyToSendOrders(
                        custodianID: arrayOfOrders[i].custodianID,
                        clientID: arrayOfOrders[i].clientID,
                        settlement: "2",
                        quantity: takeT2
                    )
                )
                remain -= takeT2
            }

        }
        
    }
    
    func prepareOrders() {
        for item in portfolioData?.portfolioes ?? [] {
            if item.symbol == UserDefaultController().selectedSymbol {
                arrayOfOrders.append(
                    ArrayOfOrders(
                        custodianID: item.custodianID ?? "",
                        clientID: item.clientID ?? "",
                        t0: item.qtyT0 ?? 0,
                        t1: item.qtyT1 ?? 0,
                        t2: item.qtyT2 ?? 0
                    )
                )
            }
        }
        
        var remaining:Int = Int(orderPreview?.Remaining ?? "") ?? 0 // The quantity we want to sell
        
        // We take the quantity we have in this symbol from all sub accounts and from all custodians on their all settlements
        for item in arrayOfOrders {
            
            // T0
            if remaining > 0 {
                let takeT0 = min(remaining, Int(item.t0))
                readyToSendOrders.append(
                    ReadyToSendOrders(
                        custodianID: item.custodianID,
                        clientID: item.clientID,
                        settlement: "0",
                        quantity: takeT0
                    )
                )
                remaining -= takeT0
            } else {
                break
            }

            // T1
            if remaining > 0 {
                let takeT1 = min(remaining, Int(item.t1))
                readyToSendOrders.append(
                    ReadyToSendOrders(
                        custodianID: item.custodianID,
                        clientID: item.clientID,
                        settlement: "1",
                        quantity: takeT1
                    )
                )
                remaining -= takeT1
            } else {
                break
            }
            
            // T2
            if remaining > 0 {
                let takeT2 = min(remaining, Int(item.t2))
                readyToSendOrders.append(
                    ReadyToSendOrders(
                        custodianID: item.custodianID,
                        clientID: item.clientID,
                        settlement: "2",
                        quantity: takeT2
                    )
                )
                remaining -= takeT2
            } else {
                break
            }
        }
    }
    
    func trade() {
        if isEditOrder {
            defaultTrade()
        } else {
            if orderPreview?.SellBuyFlag?.lowercased() == "s" {
                for item in readyToSendOrders {
                    if item.quantity > 0 {
                        setOrder(
                            custodian: item.custodianID,
                            clientID: item.clientID,
                            quantity: String(item.quantity),
                            settlement: item.settlement
                        )
                    }
                }
            } else {
                checkMarginTrade()
            }
        }
    }
    
    func checkMarginTrade() {
        let selectedStock:GetCompaniesLookupsUIModel = AppUtility.shared.loadCompanies().filter({$0.symbol == UserDefaultController().selectedSymbol ?? ""}).first ?? .testUIModel()
        
        let isMarginStock = selectedStock.isMargin
        
        if UserDefaultController().isMarginableAccount?.lowercased() == "y" && isMarginStock?.lowercased() == "y" {
            let marginSubAccount = UserDefaultController().allSubAccounts?.filter({$0.AccType?.lowercased() == "m"}).first
            setOrder(
                custodian: UserDefaultController().selectedCustodian ?? "",
                clientID: marginSubAccount?.ClientID ?? "",
                quantity: orderPreview?.Remaining ?? "",
                settlement: orderPreview?.Sett_type?.replacingOccurrences(of: "T+", with: "") ?? ""
            )
        } else {
            defaultTrade()
        }
    }
    
    func defaultTrade() {
        setOrder(
            custodian: UserDefaultController().selectedCustodian ?? "",
            clientID: KeyChainController().clientID ?? "",
            quantity: orderPreview?.Remaining ?? "",
            settlement: orderPreview?.Sett_type?.replacingOccurrences(of: "T+", with: "") ?? ""
        )
    }
    
    func setOrder(custodian: String, clientID: String, quantity: String, settlement: String) {
        
        var msgCode = ""
        
        if orderPreview?.SellBuyFlag?.lowercased() == "b" {
            msgCode = self.isEditOrder ? "C15" : "C11"
        } else {
            msgCode = self.isEditOrder ? "C14" : "C10"
        }
        
        let bracketOrderParam = BracketOrderParam(ReferencePrice: "1", isStopLoss: false, StopLossValue: 0, StopLossValueType: "1", isTakeProfit: false, TakeProfitValue: 0, TakeProfitValueType: "1")
        
        let conditionalParams: [ConditionalParameters] = []
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "en")
        
        
        let rqAccountID = orderPreview?.AccountID
//        let rqAccountNameA = orderDetails?.AccountNameA
        let rqAccountNameA = ""
        let rqAccountNameE = orderPreview?.AccountNameE
        let rqApprovalStatusCode = KeyChainController.shared().webCode
        let rqApprovalTypeCode = riskManagementData?.msValidation
        let rqAvgExePrice = "" // Empty
        let rqBEPrice = "" // Empty
        let rqBookCode = "0001"
        let rqBrokerID = KeyChainController.shared().brokerID
        let rqBuyerMember = "" // Empty
//        let rqClientID = orderPreview?.ClientID
        let rqClientID = clientID
//        let rqClientID = "-1"
        let rqCustodianID = orderPreview?.SellBuyFlag?.lowercased() == "b" ? orderPreview?.CustodianID : custodian
//        let rqCustodianID = "-1"
        let rqEntryDate = isEditOrder ? convertDateFormat(orderPreview?.EntryDate ?? "") ?? Date().toString(dateFormat: .ddMMyyyyHHmmss) : Date().toString(dateFormat: .ddMMyyyyHHmmss) // NEW EDITED
        let rqExchange = orderPreview?.Exchange
        let rqFixOrderID = orderPreview?.FIXOrderID // NEW EDIT
        let rqIPAddress = "109.107.237.83" // From Ubhar code
        let rqIntOrderID = "" // Empty
        let rqIsinCode = "" // Empty
        let rqLastUpdateTime = "0001-01-01T00:00:00" // weird
//        let rqLocalValue = orderPreview?.orderValue // Empty
        let rqLocalValue = "" // Empty
        let rqMarketOrderID = orderPreview?.MarketOrderID // Default Empty
        let rqMarketTypeCode = orderPreview?.MarketTypeCode
        let rqMaxTRPrice = orderPreview?.Price
        let rqMinFillQty = orderPreview?.MinFillQty
        let rqModifyDate = Date().toString(dateFormat: .ddMMyyyyHHmmss)
        let rqNin = orderPreview?.NIN
        let rqOrderID = isEditOrder ? orderPreview?.OrderID : ""
        let rqOrderTypeCode = orderPreview?.OrderTypeCode
        let rqOrigUserID = KeyChainController.shared().UCODE
        let rqOriginCode = "A"
        let rqPrice = orderPreview?.OrderTypeCode == "1" ? "0.0" : orderPreview?.Price // 1 = Market / 2 = Limit
        let rqProcSentFlag = "Y"
        let rqRejectReason = "" // Empty
        let rqRemaining = orderPreview?.Remaining ?? ""
        let rqRemark = orderPreview?.Remark // Default empty
        let rqSLPrice = orderPreview?.SL_price
        let rqSPLOrderFlag = "N"
        let rqSellBuyFlag = orderPreview?.SellBuyFlag
        let rqSellerMember = "" // Empty
        let rqSenderCompanyID = "" // Empty
        let rqSenderSubID = "" // Empty
//        let rqSettType = orderPreview?.Sett_type?.replacingOccurrences(of: "T+", with: "")
        let rqSettType = settlement
        let rqSmartOrderID = "" // Empty
        let rqSource2Code = "c"
        let rqSourceCode = "c"
        let rqStatusCode = (isEditOrder ? orderPreview?.StatusCode : "W") // NEW EDITED
        let rqStopLossPx = "" // Empty
        let rqSymbol = orderPreview?.Symbol // This should not be empty
        let rqSymbolCode = orderPreview?.SymbolCode // This should not be empty
        let rqSymbolLongName = "" // Empty
        let rqTPPrice = orderPreview?.TP_price
        let rqtRPriceIsPerc = "" // Empty
        let rqTRPrice = "" // Empty
        
        // The modify issue is not from totalVolume
        
//        let rqTotalVolume = isEditOrder ? orderPreview?.TotalVolume ?? "" : orderPreview?.Remaining ?? ""
        let rqTotalVolume = isEditOrder ? orderPreview?.TotalVolume ?? "" : orderPreview?.SellBuyFlag?.lowercased() == "b" ? orderPreview?.Remaining ?? "" : quantity
        let rqTrxnID = orderPreview?.TrxnID // NEW EDIT
        let rqUserID = KeyChainController.shared().UCODE
        // Ensure that the validityCode is the same validityCode in the orderDetails
        let rqValidityCode = orderPreview?.ValidityCode
        let rqValidityDate = orderPreview?.ValidityDate
        let rqVisibilityQty = orderPreview?.VisibleQty
        let rqMsgCode = msgCode
        let rqSmartOrderType = "" // Empty
        let rqIstConditionalParameters = conditionalParams
        let rqBracketOrdParam = bracketOrderParam
                
        let requestOrderHubItem = RequestOrderHubItem(accountID: rqAccountID, accountNameA: rqAccountNameA, accountNameE: rqAccountNameE, approvalStatusCode: rqApprovalStatusCode, approvalTypeCode: rqApprovalTypeCode, avgExePrice: rqAvgExePrice, bEPrice: rqBEPrice, bookCode: rqBookCode, brokerID: rqBrokerID, buyerMember: rqBuyerMember, clientID: rqClientID, custodianID: rqCustodianID, entryDate: rqEntryDate, exchange: rqExchange, fIXOrderID: rqFixOrderID, iPAddress: rqIPAddress, intOrderID: rqIntOrderID, isinCode: rqIsinCode, lastUpdateTime: rqLastUpdateTime, localValue: rqLocalValue, marketOrderID: rqMarketOrderID, marketTypeCode: rqMarketTypeCode, maxTRPrice: rqMaxTRPrice, minFillQty: rqMinFillQty, modifyDate: rqModifyDate, nIN: rqNin, orderID: rqOrderID, orderTypeCode: rqOrderTypeCode, origUserID: rqOrigUserID, originCode: rqOriginCode, price: rqPrice, procSentFlag: rqProcSentFlag, rejectReason: rqRejectReason, remaining: rqRemaining, remark: rqRemark, sLPrice: rqSLPrice, sPLOrderFlag: rqSPLOrderFlag, sellBuyFlag: rqSellBuyFlag, sellerMember: rqSellerMember, senderCompanyID: rqSenderCompanyID, senderSubID: rqSenderSubID, settType: rqSettType, smartOrderID: rqSmartOrderID, source2Code: rqSource2Code, sourceCode: rqSourceCode, statusCode: rqStatusCode, stopLossPx: rqStopLossPx, symbol: rqSymbol, symbolCode: rqSymbolCode, symbolLongName: rqSymbolLongName, tPPrice: rqTPPrice, tRPriceIsPerc: rqtRPriceIsPerc, tRPrice: rqTRPrice, totalVolume: rqTotalVolume, trxnID: rqTrxnID, userID: rqUserID, validityCode: rqValidityCode, validityDate: rqValidityDate, visibleQty: rqVisibilityQty, msgCode: rqMsgCode, SmartOrderType: rqSmartOrderType, lstConditionalParameters: rqIstConditionalParameters, bracketOrdParam: rqBracketOrdParam)
        
        if isEditOrder {
//            UserDefaultController().isModifyOrderNotification = true
            debugPrint("Request modify order hub item created with: \(requestOrderHubItem)")
        } else {
//            UserDefaultController().isModifyOrderNotification = false
            debugPrint("Request order hub item created with: \(requestOrderHubItem)")
        }
        
        
        sendAddOrderRequest(order: requestOrderHubItem.toDictData())
    }
    
    func filterExpectedProfitLossList() {
        for i in 0..<(getExpectedProfitLossList?.count ?? 0) {
            if getExpectedProfitLossList?[i].symbol == UserDefaultController().selectedSymbol ?? "" && getExpectedProfitLossList?[i].custodianID == UserDefaultController().selectedCustodian ?? "" {
                expectedProfitLoss = getExpectedProfitLossList?[i]
                ownedShares = Int(expectedProfitLoss?.qtyT0 ?? 0) + Int(expectedProfitLoss?.qtyT1 ?? 0) + Int(expectedProfitLoss?.qtyT2 ?? 0)
                
                qtyT0 = Int(expectedProfitLoss?.qtyT0 ?? 0)
                qtyT1 = Int(expectedProfitLoss?.qtyT1 ?? 0)
                qtyT2 = Int(expectedProfitLoss?.qtyT2 ?? 0)
                
                orderCountToTrade(orderQty: ownedShares ?? 0)

            } else if getExpectedProfitLossList?[i].symbol == UserDefaultController().selectedSymbol ?? "" && (UserDefaultController().selectedCustodian == "" || UserDefaultController().selectedCustodian == nil) {
                UserDefaultController().selectedCustodian = getExpectedProfitLossList?[i].custodianID
                expectedProfitLoss = getExpectedProfitLossList?[i]
                ownedShares = Int(expectedProfitLoss?.qtyT0 ?? 0) + Int(expectedProfitLoss?.qtyT1 ?? 0) + Int(expectedProfitLoss?.qtyT2 ?? 0)
                
                qtyT0 = Int(expectedProfitLoss?.qtyT0 ?? 0)
                qtyT1 = Int(expectedProfitLoss?.qtyT1 ?? 0)
                qtyT2 = Int(expectedProfitLoss?.qtyT2 ?? 0)
                
                orderCountToTrade(orderQty: ownedShares ?? 0)

            }
        }
    }
}
