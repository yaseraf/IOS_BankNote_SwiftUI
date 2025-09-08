//
//  ExchangeSummaryModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 24/08/2025.
//

import Foundation

struct GetExchangeSummaryRequestModel {
    
}

struct GetExchangeSummaryResponseModel: Codable {
    let aboutDescA, aboutDescE: String?
    let avg5Days: [String]?
    let buyCashFlowPerc, companyDIVIDENDYIELDPERC, companyFACEVALUE, companyMARKETCAP: String?
    let companyPERATIO, confirmMessage, confirmMessageAR, currentValue: String?
    let dayRange, depthAvailable, eMName, equityTransferComm: String?
    let exchangeID, exchangeNameA, exchangeNameE, exchangeType: String?
    let high, indexCode, indexAvailable, k: String?
    let lastUpdateTime, low, mName, netChange: String?
    let netChangePerc, orderIndex, r1, r2: String?
    let s1, s2, statusCode, symbolsDown: String?
    let symbolsTraded, symbolsUP, symbolsUnChange, totalExecuted: String?
    let turnOver, volume, isDefault: String?
    let orderBy: Int?
    let wk52High, wk52Low: Double?
    let wk52Range: String?
    let isinCode: String?

        enum CodingKeys: String, CodingKey {
            case aboutDescA = "ABOUT_DESC_A"
            case aboutDescE = "ABOUT_DESC_E"
            case avg5Days = "Avg5days"
            case buyCashFlowPerc = "BuyCashFlowPerc"
            case companyDIVIDENDYIELDPERC = "Company_DIVIDEND_YIELD_PERC"
            case companyFACEVALUE = "Company_FACE_VALUE"
            case companyMARKETCAP = "Company_MARKET_CAP"
            case companyPERATIO = "Company_PE_RATIO"
            case confirmMessage = "ConfirmMessage"
            case confirmMessageAR = "ConfirmMessageAR"
            case currentValue = "CurrentValue"
            case dayRange = "DayRange"
            case depthAvailable = "DepthAvailable"
            case eMName = "E_M_NAME"
            case equityTransferComm = "EquityTransferComm"
            case exchangeID = "ExchangeID"
            case exchangeNameA = "ExchangeNameA"
            case exchangeNameE = "ExchangeNameE"
            case exchangeType = "ExchangeType"
            case high = "High"
            case indexCode = "INDEX_CODE"
            case indexAvailable = "IndexAvailable"
            case k = "K"
            case lastUpdateTime = "LastUpdateTime"
            case low = "Low"
            case mName = "M_NAME"
            case netChange = "NetChange"
            case netChangePerc = "NetChangePerc"
            case orderIndex = "ORDER_INDEX"
            case r1 = "R1"
            case r2 = "R2"
            case s1 = "S1"
            case s2 = "S2"
            case statusCode = "StatusCode"
            case symbolsDown = "SymbolsDown"
            case symbolsTraded = "SymbolsTraded"
            case symbolsUP = "SymbolsUP"
            case symbolsUnChange = "SymbolsUnChange"
            case totalExecuted = "TotalExecuted"
            case turnOver = "TurnOver"
            case volume = "Volume"
            case isDefault = "is_Default"
            case orderBy, wk52High, wk52Low, wk52Range
            case isinCode = "ISIN_code"
        }
}

struct GetExchangeSummaryUIModel: Codable {
    var aboutDescA, aboutDescE: String?
    var avg5Days: [String]?
    var buyCashFlowPerc, companyDIVIDENDYIELDPERC, companyFACEVALUE, companyMARKETCAP: String?
    var companyPERATIO, confirmMessage, confirmMessageAR, currentValue: String?
    var dayRange, depthAvailable, eMName, equityTransferComm: String?
    var exchangeID, exchangeNameA, exchangeNameE, exchangeType: String?
    var high, indexCode, indexAvailable, k: String?
    var lastUpdateTime, low, mName, netChange: String?
    var netChangePerc, orderIndex, r1, r2: String?
    var s1, s2, statusCode, symbolsDown: String?
    var symbolsTraded, symbolsUP, symbolsUnChange, totalExecuted: String?
    var turnOver, volume, isDefault: String?
    var orderBy: Int?
    var wk52High, wk52Low: Double?
    var wk52Range: String?
    var isinCode: String?
    
    static func mapToUIModel(_ model: GetExchangeSummaryResponseModel) -> Self {
        return GetExchangeSummaryUIModel(aboutDescA: model.aboutDescA, aboutDescE: model.aboutDescE, avg5Days: model.avg5Days, buyCashFlowPerc: model.buyCashFlowPerc, companyDIVIDENDYIELDPERC: model.companyDIVIDENDYIELDPERC, companyFACEVALUE: model.companyFACEVALUE, companyMARKETCAP: model.companyMARKETCAP, companyPERATIO: model.companyPERATIO, confirmMessage: model.confirmMessage, confirmMessageAR: model.confirmMessageAR, currentValue: model.currentValue, dayRange: model.dayRange, depthAvailable: model.depthAvailable, eMName: model.eMName, equityTransferComm: model.equityTransferComm, exchangeID: model.exchangeID, exchangeNameA: model.exchangeNameA, exchangeNameE: model.exchangeNameE, exchangeType: model.exchangeType, high: model.high, indexCode: model.indexCode, indexAvailable: model.indexAvailable, k: model.k, lastUpdateTime: model.lastUpdateTime, low: model.low, mName: model.mName, netChange: model.netChange, netChangePerc: model.netChangePerc, orderIndex: model.orderIndex, r1: model.r1, r2: model.r2, s1: model.s1, s2: model.s2, statusCode: model.statusCode, symbolsDown: model.symbolsDown, symbolsTraded: model.symbolsTraded, symbolsUP: model.symbolsUP, symbolsUnChange: model.symbolsUnChange, totalExecuted: model.totalExecuted, turnOver: model.turnOver, volume: model.volume, isDefault: model.isDefault, orderBy: model.orderBy, wk52High: model.wk52High, wk52Low: model.wk52Low, wk52Range: model.wk52Range, isinCode: model.isinCode)
    }
    
    static func initializer() -> Self {
        return GetExchangeSummaryUIModel()
    }
}
