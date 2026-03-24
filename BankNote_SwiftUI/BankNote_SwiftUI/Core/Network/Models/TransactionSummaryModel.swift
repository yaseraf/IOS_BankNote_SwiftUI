//
//  TransactionSummaryModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 10/03/2026.
//

import Foundation

struct GetTransactionSummaryRequestModel: Codable {
    
}

struct GetTransactionSummaryResponseModel: Codable {
    let avCost: Double?
    let aDesc: String?
    let accountType: String?
    let bal: Double?
    let bQty: Double?
    let bTotal: Double?
    let clientID: Int64?
    let compID: Int?
    let curName: String?
    let dResult: Double?
    let docCode: String?
    let exchange: String?
    let eCurName: String?
    let eDesc: String?
    let eInvRemarks: String?
    let invNo: String?
    let invRemarks: String?
    let isinCode: String?
    let islamic: String?
    let lastTradePrice: Double?
    let price: Double?
    let profit: Double?
    let precision: String?
    let scaLongName: String?
    let sceLongName: String?
    let sellCost: Double?
    let sQty: Double?
    let sTotal: Double?
    let shareCurrency: String?
    let total: Double?
    let trDate: String?
    let tickerID: String? // symbol
    let orderID: Int64?
    let remainingQt: Int64?
}

extension GetTransactionSummaryResponseModel {
    
    enum CodingKeys: String, CodingKey {
        case avCost = "AV_COST"
        case aDesc = "A_DESC"
        case accountType = "AccountType"
        case bal = "BAL"
        case bQty = "B_QTY"
        case bTotal = "B_total"
        case clientID = "CLIENT_ID"
        case compID = "COMP_ID"
        case curName = "CUR_NAME"
        case dResult = "D_RESULT"
        case docCode = "Doc_code"
        case exchange = "EXCHANGE"
        case eCurName = "E_CUR_NAME"
        case eDesc = "E_DESC"
        case eInvRemarks = "E_INV_REMARKS"
        case invNo = "INV_NO"
        case invRemarks = "INV_REMARKS"
        case isinCode = "ISIN_CODE"
        case islamic = "ISLAMIC"
        case lastTradePrice = "LastTradePrice"
        case price = "PRICE"
        case profit = "PROFIT"
        case precision = "Precision"
        case scaLongName = "SCA_LONG_NAME"
        case sceLongName = "SCE_LONG_NAME"
        case sellCost = "SELL_COST"
        case sQty = "S_QTY"
        case sTotal = "S_TOTAL"
        case shareCurrency = "ShareCurrency"
        case total = "TOTAL"
        case trDate = "TR_DATE"
        case tickerID = "Ticker_ID"
        case orderID = "order_id"
        case remainingQt = "remaining_qt"
    }
}


struct GetTransactionSummaryUIModel {
    
    var id = UUID().uuidString
    
    var avCost: Double?
    var aDesc: String?
    var accountType: String?
    var bal: Double?
    var bQty: Double?
    var bTotal: Double?
    var clientID: Int64?
    var compID: Int?
    var curName: String?
    var dResult: Double?
    var docCode: String?
    var exchange: String?
    var eCurName: String?
    var eDesc: String?
    var eInvRemarks: String?
    var invNo: String?
    var invRemarks: String?
    var isinCode: String?
    var islamic: String?
    var lastTradePrice: Double?
    var price: Double?
    var profit: Double?
    var precision: String?
    var scaLongName: String?
    var sceLongName: String?
    var sellCost: Double?
    var sQty: Double?
    var sTotal: Double?
    var shareCurrency: String?
    var total: Double?
    var trDate: String?
    var tickerID: String?
    var orderID: Int64?
    var remainingQt: Int64?

    
    static func mapToUIModel(_ model: GetTransactionSummaryResponseModel) -> Self {
        return GetTransactionSummaryUIModel(
            avCost: model.avCost,
            aDesc: model.aDesc,
            accountType: model.accountType,
            bal: model.bal,
            bQty: model.bQty,
            bTotal: model.bTotal,
            clientID: model.clientID,
            compID: model.compID,
            curName: model.curName,
            dResult: model.dResult,
            docCode: model.docCode,
            exchange: model.exchange,
            eCurName: model.eCurName,
            eDesc: model.eDesc,
            eInvRemarks: model.eInvRemarks,
            invNo: model.invNo,
            invRemarks: model.invRemarks,
            isinCode: model.isinCode,
            islamic: model.islamic,
            lastTradePrice: model.lastTradePrice,
            price: model.price,
            profit: model.profit,
            precision: model.precision,
            scaLongName: model.scaLongName,
            sceLongName: model.sceLongName,
            sellCost: model.sellCost,
            sQty: model.sQty,
            sTotal: model.sTotal,
            shareCurrency: model.shareCurrency,
            total: model.total,
            trDate: model.trDate,
            tickerID: model.tickerID,
            orderID: model.orderID,
            remainingQt: model.remainingQt
        )
    }
    
    static func initializer() -> Self {
        return GetTransactionSummaryUIModel()
    }
}
