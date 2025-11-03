//
//  OrderEditViewModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 26/10/2025.
//

import Foundation

class OrderEditViewModel: ObservableObject {
    private let coordinator: OrdersCoordinatorProtocol
    private let delegate: OrderEditDelegate
    
    @Published var orderDetails: OrderListUIModel?
    
    init(coordinator: OrdersCoordinatorProtocol, orderDetails: OrderListUIModel, delegate: OrderEditDelegate) {
        
        self.coordinator = coordinator
        self.orderDetails = orderDetails
        self.delegate = delegate
    }
}

// MARK: Routing
extension OrderEditViewModel {
    
}

// MARK: SignalR
extension OrderEditViewModel {
    func cancelOrderRequest(order: [String: String]){
        
        if Connection_Hub.shared.chatHub != nil {
            do {
                debugPrint("test invoke cancel order request")
                
                var strData = "[{"

                
                order.forEach { (key, value) in
                    strData += " \"\(key)\": \"\(value)\","
                }
                
                strData.removeLast()
                strData += "}]"
                debugPrint("cancel order request strData: \(strData)")
                
                let data = strData.data(using: .utf8)!
                do {
                    if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [Dictionary<String,String>] {
                        debugPrint("cancel order request jsonArray:\(jsonArray)") // use the json here
                        
                        if jsonArray.count > 0 {
                            try Connection_Hub.shared.chatHub?.invoke(HubMethodType.sendAddOrderRequest.rawValue, arguments: [KeyChainController().username ?? "", jsonArray[0]]) { (result, error) in
                                if let e = error {
                                    debugPrint("cancel order request invoke Error: \(e)")
                                } else {
                                    debugPrint("cancel order request invoke, \([UserDefaultController().username ?? "", jsonArray[0]]) Success!, appDelegate.userNameNotEncryptrd\("info3@fitmena.com")")
                                    self.coordinator.dismiss()
                                    self.delegate.onCancelOrder()
                                }
                            }
                        }
                        else {
                        }
                    } else {
                        debugPrint("cancel order request bad json")
                    }
                } catch let error as NSError {
                    debugPrint("cancel order request JSONSerialization error:\(error)")
                }
            } catch let error {
                debugPrint("cancel order request chatHub error: \(error.localizedDescription)")
            }
        }
    }

}

// MARK: Functions
extension OrderEditViewModel {
    func cancelOrder() {
        setCancelOrder()
    }
    
    func editOrder() {
        coordinator.dismiss()
        delegate.onEditOrder(order: orderDetails ?? .initializer())
    }
    
    func dismiss() {
        coordinator.dismiss()
    }
    
    func setCancelOrder() {
        var msgCode = ""
        
        if self.orderDetails?.SellBuyFlag?.lowercased() == "b" {
            if orderDetails?.StatusCode?.lowercased() == "w" || orderDetails?.StatusCode?.lowercased() == "t" {
                msgCode = "C27"
            } else {
                msgCode = "C19"
            }
        } else {
            if orderDetails?.StatusCode?.lowercased() == "w" || orderDetails?.StatusCode?.lowercased() == "t" {
                msgCode = "C26"
            } else {
                msgCode = "C18"
            }
        }
        
        let bracketOrderParam = BracketOrderParam(ReferencePrice: "1", isStopLoss: false, StopLossValue: 0, StopLossValueType: "1", isTakeProfit: false, TakeProfitValue: 0, TakeProfitValueType: "1")
        
        let conditionalParams: [ConditionalParameters] = []
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        
        
        let rqAccountID = orderDetails?.AccountID
//        let rqAccountNameA = orderDetails?.AccountNameA
        let rqAccountNameA = ""
        let rqAccountNameE = orderDetails?.AccountNameE
        let rqApprovalStatusCode = KeyChainController.shared().webCode
        let rqApprovalTypeCode = "" // Empty
        let rqAvgExePrice = "" // Empty
        let rqBEPrice = "" // Empty
        let rqBookCode = "0001"
        let rqBrokerID = KeyChainController.shared().brokerID
        let rqBuyerMember = "" // Empty
        let rqClientID = orderDetails?.ClientID
        let rqCustodianID = orderDetails?.CustodianID
        let rqEntryDate = convertDateString(orderDetails?.EntryDate ?? "")
        let rqExchange = orderDetails?.Exchange
        let rqFixOrderID = orderDetails?.FIXOrderID // Default Empty
        let rqIPAddress = "109.107.237.83" // From Ubhar code
        let rqIntOrderID = "" // Empty
        let rqIsinCode = "" // Empty
        let rqLastUpdateTime = "0001-01-01T00:00:00" // weird
        let rqLocalValue = orderDetails?.LocalValue // Empty
        let rqMarketOrderID = orderDetails?.MarketOrderID // Default Empty
        let rqMarketTypeCode = orderDetails?.MarketTypeCode
        let rqMaxTRPrice = orderDetails?.MaxPrice // EDITED
        let rqMinFillQty = orderDetails?.MinFillQty
        let rqModifyDate = Date().toString(dateFormat: .ddMMyyyyHHmmss)
        let rqNin = orderDetails?.NIN
        let rqOrderID = orderDetails?.OrderID
        let rqOrderTypeCode = orderDetails?.OrderTypeCode
        let rqOrigUserID = KeyChainController.shared().UCODE
        let rqOriginCode = "1"
        let rqPrice = orderDetails?.Price
        let rqProcSentFlag = "Y"
        let rqRejectReason = "" // Empty
        let rqRemaining = orderDetails?.Remaining ?? ""
        let rqRemark = orderDetails?.Remark // Default empty
        let rqSLPrice = orderDetails?.SL_price
        let rqSPLOrderFlag = "N"
        let rqSellBuyFlag = orderDetails?.SellBuyFlag
        let rqSellerMember = "" // Empty
        let rqSenderCompanyID = "" // Empty
        let rqSenderSubID = "" // Empty
        let rqSettType = orderDetails?.Sett_type?.replacingOccurrences(of: "T+", with: "")
        let rqSmartOrderID = "" // Empty
        let rqSource2Code = "c"
        let rqSourceCode = "c"
        let rqStatusCode = "W"
        let rqStopLossPx = "" // Empty
        let rqSymbol = orderDetails?.Symbol // This should not be empty
        let rqSymbolCode = orderDetails?.Symbol // EDITED
        let rqSymbolLongName = "" // Empty
        let rqTPPrice = orderDetails?.TP_price
        let rqtRPriceIsPerc = "" // Empty
        let rqTRPrice = "" // Emptyto
        let rqTotalVolume = orderDetails?.TotalVolume // EDITED
        let rqTrxnID = orderDetails?.TrxnID // Default Empty
        let rqUserID = KeyChainController.shared().UCODE
        let rqValidityCode = orderDetails?.ValidityCode
        let rqValidityDate = orderDetails?.ValidityDate
        let rqVisibilityQty = orderDetails?.VisibleQty
        let rqMsgCode = msgCode
        let rqSmartOrderType = "" // Empty
        let rqIstConditionalParameters = conditionalParams
        let rqBracketOrdParam = bracketOrderParam
                
        
        let requestOrderHubItem = RequestOrderHubItem(accountID: rqAccountID, accountNameA: rqAccountNameA, accountNameE: rqAccountNameE, approvalStatusCode: rqApprovalStatusCode, approvalTypeCode: rqApprovalTypeCode, avgExePrice: rqAvgExePrice, bEPrice: rqBEPrice, bookCode: rqBookCode, brokerID: rqBrokerID, buyerMember: rqBuyerMember, clientID: rqClientID, custodianID: rqCustodianID, entryDate: rqEntryDate, exchange: rqExchange, fIXOrderID: rqFixOrderID, iPAddress: rqIPAddress, intOrderID: rqIntOrderID, isinCode: rqIsinCode, lastUpdateTime: rqLastUpdateTime, localValue: rqLocalValue, marketOrderID: rqMarketOrderID, marketTypeCode: rqMarketTypeCode, maxTRPrice: rqMaxTRPrice, minFillQty: rqMinFillQty, modifyDate: rqModifyDate, nIN: rqNin, orderID: rqOrderID, orderTypeCode: rqOrderTypeCode, origUserID: rqOrigUserID, originCode: rqOriginCode, price: rqPrice, procSentFlag: rqProcSentFlag, rejectReason: rqRejectReason, remaining: rqRemaining, remark: rqRemark, sLPrice: rqSLPrice, sPLOrderFlag: rqSPLOrderFlag, sellBuyFlag: rqSellBuyFlag, sellerMember: rqSellerMember, senderCompanyID: rqSenderCompanyID, senderSubID: rqSenderSubID, settType: rqSettType, smartOrderID: rqSmartOrderID, source2Code: rqSource2Code, sourceCode: rqSourceCode, statusCode: rqStatusCode, stopLossPx: rqStopLossPx, symbol: rqSymbol, symbolCode: rqSymbolCode, symbolLongName: rqSymbolLongName, tPPrice: rqTPPrice, tRPriceIsPerc: rqtRPriceIsPerc, tRPrice: rqTRPrice, totalVolume: rqTotalVolume, trxnID: rqTrxnID, userID: rqUserID, validityCode: rqValidityCode, validityDate: rqValidityDate, visibleQty: rqVisibilityQty, msgCode: rqMsgCode, SmartOrderType: rqSmartOrderType, lstConditionalParameters: rqIstConditionalParameters, bracketOrdParam: rqBracketOrdParam)
        debugPrint("Request cancel order hub item created with: \(requestOrderHubItem)")
        
        cancelOrderRequest(order: requestOrderHubItem.toDictData())
        
    }
    
    func convertDateString(_ input: String) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        guard let date = inputFormatter.date(from: input) else {
            print("❌ Could not parse date")
            return nil
        }
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "ddMMyyyyHHmmss"
        
        return outputFormatter.string(from: date)
    }

}

