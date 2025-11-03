//
//  RequestOrderHubItem.swift
//  mahfazati
//
//  Created by FIT on 27/10/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation

struct RequestOrderHubItem: Codable {
    var accountID: String?
    var accountNameA: String?
    var accountNameE: String?
    var approvalStatusCode: String?
    var approvalTypeCode: String?
    var avgExePrice: String?
    var bEPrice: String?
    var bookCode: String?
    var brokerID: String?
    var buyerMember: String?
    var clientID: String?
    var custodianID: String?
    var entryDate: String?
    var exchange: String?
    var fIXOrderID: String?
    var iPAddress: String?
    var intOrderID: String?
    var isinCode: String?
    var lastUpdateTime: String?
    var localValue: String?
    var marketOrderID: String?
    var marketTypeCode: String?
    var maxTRPrice: String?
    var minFillQty: String?
    var modifyDate: String?
    var nIN: String?
    var orderID: String?
    var orderTypeCode: String?
    var origUserID: String?
    var originCode: String?
    var price: String?
    var procSentFlag: String?
    var rejectReason: String?
    var remaining: String?
    var remark: String?
    var sLPrice: String?
    var sPLOrderFlag: String?
    var sellBuyFlag: String?
    var sellerMember: String?
    var senderCompanyID: String?
    var senderSubID: String?
    var settType: String?
    var smartOrderID: String?
    var source2Code: String?
    var sourceCode: String?
    var statusCode: String?
    var stopLossPx: String?
    var symbol: String?
    var symbolCode: String?
    var symbolLongName: String?
    var tPPrice: String?
    var tRPriceIsPerc: String?
    var tRPrice: String?
    var totalVolume: String?
    var trxnID: String?
    var userID: String?
    var validityCode: String?
    var validityDate: String?
    var visibleQty: String?
    var msgCode: String?
    var SmartOrderType: String?
    var lstConditionalParameters: [ConditionalParameters]?
    var bracketOrdParam: BracketOrderParam?
    
    func toDictData() -> [String : String] {
        var data = [String : String]()
        
        data["OrderID"] = orderID
        data["SymbolCode"] = symbolCode
        data["BookCode"] = bookCode
        data["BrokerID"] = brokerID
        data["AccountID"] = accountID
        data["Symbol"] = symbol
        data["Price"] = price
        data["ValidityCode"] = validityCode
        data["ValidityDate"] = validityDate
        data["TotalVolume"] = totalVolume
        data["Remaining"] = remaining
        data["SourceCode"] = sourceCode
        data["StatusCode"] = statusCode
        data["EntryDate"] = entryDate
        data["ModifyDate"] = modifyDate
        data["UserID"] = userID
        data["OrigUserID"] = origUserID
        data["MarketTypeCode"] = marketTypeCode
        data["Source2Code"] = source2Code
        data["MinFillQty"] = minFillQty
        data["VisibleQty"] = visibleQty
        data["OrderTypeCode"] = orderTypeCode
        data["NIN"] = nIN
        data["ProcSentFlag"] = procSentFlag
        data["MarketOrderID"] = marketOrderID
        data["OriginCode"] = originCode
        data["IntOrderID"] = intOrderID
        data["TrxnID"] = trxnID
        data["SellBuyFlag"] = sellBuyFlag
        data["msgCode"] = msgCode
        data["AccountNameA"] = accountNameA
        data["AccountNameE"] = accountNameE
        data["Remark"] = remark
        data["SenderSubID"] = senderSubID
        data["BuyerMember"] = buyerMember
        data["SellerMember"] = sellerMember
        data["AvgExePrice"] = avgExePrice
        data["IsinCode"] = isinCode
        data["FIXOrderID"] = fIXOrderID
        data["ClientID"] = clientID
        data["Exchange"] = exchange
        data["RejectReason"] = rejectReason
        data["TP_price"] = tPPrice
        data["SL_price"] = sLPrice
        data["TR_price"] = tRPrice
        data["Max_TR_price"] = maxTRPrice
        data["TR_Price_is_perc"] = tRPriceIsPerc
        data["BE_Price"] = bEPrice
        data["SPL_Order_flag"] = sPLOrderFlag
        data["ApprovalStatusCode"] = approvalStatusCode
        data["ApprovalTypeCode"] = approvalTypeCode
        data["StopLossPx"] = stopLossPx
        data["SenderCompanyID"] = senderCompanyID
        data["LocalValue"] = localValue
        data["SymbolLongName"] = symbolLongName
        data["IP_Address"] = iPAddress
        data["LastUpdateTime"] = lastUpdateTime
        data["SmartOrderID"] = smartOrderID
        data["Sett_Type"] = settType
        data["CustodianID"] = custodianID
        
        return data
    }

}
