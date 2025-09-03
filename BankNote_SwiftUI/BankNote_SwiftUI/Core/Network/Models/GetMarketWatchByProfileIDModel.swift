//
//  GetMarketWatchByProfileIDModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 21/08/2025.
//

import Foundation

struct GetMarketWatchByProfileIDRequestModel {
    
}

struct GetMarketWatchByProfileIDResponseModel: Codable {
    let accumlossFlags, allowdBuyLimit, avgPrice, bidPrice: String?
    let bidVolume, buyCashFlowPerc, curCode, closePrice: String?
    let companyA, companyE, dayRange, depthBuyOrder: String?
    let depthByPrice, eps, exchange, executed: String?
    let highPrice, islm, isCryptoSymbol, isUsOnline: String?
    let indicator, isInAlerts, isInPortfolio, isMargin: String?
    let lastTradePrice, lastTradeVolume, losses: String?
    let lowPrice, marketType, maxPrice, minPrice: String?
    let netChange, netChangePerc, offerPrice, offerVolume: String?
    let openPrice, pe, pivotPoint, precision: String?
    let profileID, resistance1, resistance2, sectorA: String?
    let sectorCode, sectorE, support1, support2: String?
    let symbol, symbolCapital, symbolNameA, symbolNameArabic: String?
    let symbolNameE, symbolNameEnglish, symbolWithIcon, topPrice: String?
    let totalBidVolume, totalOfferVolume, totalValue, totalVolume: String?
    let updateDateTime, webCode, recid, wk52High: String?
    let wk52Low, wk52Range: String?

    enum CodingKeys: String, CodingKey {
        case accumlossFlags = "AccumlossFlags"
        case allowdBuyLimit = "AllowdBuyLimit"
        case avgPrice = "AvgPrice"
        case bidPrice = "BidPrice"
        case bidVolume = "BidVolume"
        case buyCashFlowPerc = "BuyCashFlowPerc"
        case curCode = "CUR_CODE"
        case closePrice = "ClosePrice"
        case companyA = "CompanyA"
        case companyE = "CompanyE"
        case dayRange = "DayRange"
        case depthBuyOrder = "DepthBuyOrder"
        case depthByPrice = "DepthByPrice"
        case eps = "EPS"
        case exchange = "Exchange"
        case executed = "Executed"
        case highPrice = "HighPrice"
        case islm = "ISLM"
        case isCryptoSymbol = "IS_CRYPTO_SYMBOL"
        case isUsOnline = "IS_US_ONLINE"
        case indicator = "Indicator"
        case isInAlerts = "IsInAlerts"
        case isInPortfolio = "IsInPortfolio"
        case isMargin = "IsMargin"
        case lastTradePrice = "LastTradePrice"
        case lastTradeVolume = "LastTradeVolume"
        case losses = "Losses"
        case lowPrice = "LowPrice"
        case marketType = "MarketType"
        case maxPrice = "MaxPrice"
        case minPrice = "MinPrice"
        case netChange = "NetChange"
        case netChangePerc = "NetChangePerc"
        case offerPrice = "OfferPrice"
        case offerVolume = "OfferVolume"
        case openPrice = "OpenPrice"
        case pe = "PE"
        case pivotPoint = "PivotPoint"
        case precision = "Precision"
        case profileID = "ProfileID"
        case resistance1 = "Resistance1"
        case resistance2 = "Resistance2"
        case sectorA = "SectorA"
        case sectorCode = "SectorCode"
        case sectorE = "SectorE"
        case support1 = "Support1"
        case support2 = "Support2"
        case symbol = "Symbol"
        case symbolCapital = "SymbolCapital"
        case symbolNameA = "SymbolNameA"
        case symbolNameArabic = "SymbolNameArabic"
        case symbolNameE = "SymbolNameE"
        case symbolNameEnglish = "SymbolNameEnglish"
        case symbolWithIcon = "SymbolWithIcon"
        case topPrice = "TopPrice"
        case totalBidVolume = "TotalBidVolume"
        case totalOfferVolume = "TotalOfferVolume"
        case totalValue = "TotalValue"
        case totalVolume = "TotalVolume"
        case updateDateTime = "UpdateDateTime"
        case webCode = "WebCode"
        case recid, wk52High, wk52Low, wk52Range
    }
    
    static let empty = GetMarketWatchByProfileIDResponseModel(
            accumlossFlags: nil,
            allowdBuyLimit: nil,
            avgPrice: nil,
            bidPrice: nil,
            bidVolume: nil,
            buyCashFlowPerc: nil,
            curCode: nil,
            closePrice: nil,
            companyA: nil,
            companyE: nil,
            dayRange: nil,
            depthBuyOrder: nil,
            depthByPrice: nil,
            eps: nil,
            exchange: nil,
            executed: nil,
            highPrice: nil,
            islm: nil,
            isCryptoSymbol: nil,
            isUsOnline: nil,
            indicator: nil,
            isInAlerts: nil,
            isInPortfolio: nil,
            isMargin: nil,
            lastTradePrice: nil,
            lastTradeVolume: nil,
            losses: nil,
            lowPrice: nil,
            marketType: nil,
            maxPrice: nil,
            minPrice: nil,
            netChange: nil,
            netChangePerc: nil,
            offerPrice: nil,
            offerVolume: nil,
            openPrice: nil,
            pe: nil,
            pivotPoint: nil,
            precision: nil,
            profileID: nil,
            resistance1: nil,
            resistance2: nil,
            sectorA: nil,
            sectorCode: nil,
            sectorE: nil,
            support1: nil,
            support2: nil,
            symbol: nil,
            symbolCapital: nil,
            symbolNameA: nil,
            symbolNameArabic: nil,
            symbolNameE: nil,
            symbolNameEnglish: nil,
            symbolWithIcon: nil,
            topPrice: nil,
            totalBidVolume: nil,
            totalOfferVolume: nil,
            totalValue: nil,
            totalVolume: nil,
            updateDateTime: nil,
            webCode: nil,
            recid: nil,
            wk52High: nil,
            wk52Low: nil,
            wk52Range: nil
        )

    
}

struct GetMarketWatchByProfileIDUIModel: Comparable{
    var accumlossFlags: String?
    var allowdBuyLimit: String?
    var avgPrice: String?
    var bidPrice: String?
    var bidVolume: String?
    var buyCashFlowPerc: String?
    var curCode: String?
    var closePrice: String?
    var companyA: String?
    var companyE: String?
    var dayRange: String?
    var depthBuyOrder: String?
    var depthByPrice: String?
    var eps: String?
    var exchange: String?
    var executed: String?
    var highPrice: String?
    var islM: String?
    var isCryptoSymbol: String?
    var isUSOnline: String?
    var indicator: String?
    var isInAlerts: String?
    var isInPortfolio: String?
    var isMargin: String?
    var lastTradePrice: String?
    var lastTradeVolume: String?
    var losses: String?
    var lowPrice: String?
    var marketType: String?
    var maxPrice: String?
    var minPrice: String?
    var netChange: String?
    var netChangePerc: String?
    var offerPrice: String?
    var offerVolume: String?
    var openPrice: String?
    var pe: String?
    var pivotPoint: String?
    var precision: String?
    var profileID: String?
    var resistance1: String?
    var resistance2: String?
    var sectorA: String?
    var sectorCode: String?
    var sectorE: String?
    var support1: String?
    var support2: String?
    var symbol: String?
    var symbolCapital: String?
    var symbolNameA: String?
    var symbolNameArabic: String?
    var symbolNameE: String?
    var symbolNameEnglish: String?
    var symbolWithIcon: String?
    var topPrice: String?
    var totalBidVolume: String?
    var totalOfferVolume: String?
    var totalValue: String?
    var totalVolume: String?
    var updateDateTime: String?
    var webCode: String?
    var recid: String?
    var wk52High: String?
    var wk52Low: String?
    var wk52Range: String?
    
    static func <(lhs: GetMarketWatchByProfileIDUIModel, rhs: GetMarketWatchByProfileIDUIModel) -> Bool {
        return lhs.symbolNameE ?? "" < rhs.symbolNameE ?? ""
        }

}

extension GetMarketWatchByProfileIDUIModel {
    static func mapToUIModel(_ model:GetMarketWatchByProfileIDResponseModel)->Self {
        return  GetMarketWatchByProfileIDUIModel(accumlossFlags: model.accumlossFlags ?? "", allowdBuyLimit: model.allowdBuyLimit ?? "", avgPrice: model.avgPrice ?? "", bidPrice: model.bidPrice ?? "", bidVolume: model.bidVolume ?? "", buyCashFlowPerc: model.buyCashFlowPerc ?? "", curCode: model.curCode ?? "", closePrice: model.closePrice ?? "", companyA: model.companyA ?? "", companyE: model.companyE ?? "", dayRange: model.dayRange ?? "", depthBuyOrder: model.depthBuyOrder ?? "", depthByPrice: model.depthByPrice ?? "", eps: model.eps ?? "", exchange: model.exchange ?? "", executed: model.executed ?? "", highPrice: model.highPrice ?? "", islM: model.islm ?? "", isCryptoSymbol: model.isCryptoSymbol ?? "", isUSOnline: model.isUsOnline ?? "", indicator: model.indicator ?? "", isInAlerts: model.isInAlerts ?? "", isInPortfolio: model.isInPortfolio ?? "", isMargin: model.isMargin ?? "", lastTradePrice: model.lastTradePrice ?? "", lastTradeVolume: model.lastTradeVolume ?? "", losses: model.losses ?? "", lowPrice: model.lowPrice ?? "", marketType: model.marketType ?? "", maxPrice: model.maxPrice ?? "", minPrice: model.minPrice ?? "", netChange: model.netChange ?? "", netChangePerc: model.netChangePerc ?? "", offerPrice: model.offerPrice ?? "", offerVolume: model.offerVolume ?? "", openPrice: model.openPrice ?? "", pe: model.pe ?? "", pivotPoint: model.pivotPoint ?? "", precision: model.precision ?? "", profileID: model.profileID ?? "", resistance1: model.resistance1 ?? "", resistance2: model.resistance2 ?? "", sectorA: model.sectorA ?? "", sectorCode: model.sectorCode ?? "", sectorE: model.sectorE ?? "", support1: model.support1 ?? "", support2: model.support2 ?? "", symbol: model.symbol ?? "", symbolCapital: model.symbolCapital ?? "", symbolNameA: model.symbolNameA ?? "", symbolNameArabic: model.symbolNameArabic ?? "", symbolNameE: model.symbolNameE ?? "", symbolNameEnglish: model.symbolNameEnglish ?? "", symbolWithIcon: model.symbolWithIcon ?? "", topPrice: model.topPrice ?? "", totalBidVolume: model.totalBidVolume ?? "", totalOfferVolume: model.totalOfferVolume ?? "", totalValue: model.totalValue ?? "", totalVolume: model.totalVolume ?? "", updateDateTime: model.updateDateTime ?? "", webCode: model.webCode ?? "", recid: model.recid ?? "", wk52High: model.wk52High ?? "", wk52Low: model.wk52Low ?? "", wk52Range: model.wk52Range ?? "")
    }
    
    static func initializer() -> Self {
        return GetMarketWatchByProfileIDUIModel()
    }
}
