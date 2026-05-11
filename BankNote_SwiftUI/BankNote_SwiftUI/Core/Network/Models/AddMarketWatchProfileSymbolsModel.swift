//
//  AddMarketWatchProfileSymbolsModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 05/05/2026.
//

import Foundation
struct AddMarketWatchProfileSymbolsRequestModel: Codable {
        let profileID: String?
        let symbols: [String]?
        let webCode: String?

        enum CodingKeys: String, CodingKey {
            case profileID = "ProfileID"
            case symbols = "Symbols"
            case webCode = "WebCode"
        }
}

struct AddMarketWatchProfileSymbolRequestModel: Codable {
    
}

struct AddMarketWatchProfileSymbolsResponseModel: Codable {
        let accumlossFlags, allowdBuyLimit, avgPrice, bidPrice: String?
        let bidVolume, buyCashFlowPerc, curCode, closePrice: String?
        let companyA, companyE, dayRange, depthBuyOrder: String?
        let depthByPrice, eps, exchange, executed: String?
        let highPrice, islm, isCryptoSymbol, isUsOnline: String?
        let indicator, isInAlerts, isInPortfolio: String?
        let isMargin, lastTradePrice, lastTradeVolume, losses: String?
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
}

struct AddMarketWatchProfileSymbolsUIModel{
    var accumlossFlags, allowdBuyLimit, avgPrice, bidPrice: String?
    var bidVolume, buyCashFlowPerc, curCode, closePrice: String?
    var companyA, companyE, dayRange, depthBuyOrder: String?
    var depthByPrice, eps, exchange, executed: String?
    var highPrice, islm, isCryptoSymbol, isUsOnline: String?
    var indicator, isInAlerts, isInPortfolio: String?
    var isMargin, lastTradePrice, lastTradeVolume, losses: String?
    var lowPrice, marketType, maxPrice, minPrice: String?
    var netChange, netChangePerc, offerPrice, offerVolume: String?
    var openPrice, pe, pivotPoint, precision: String?
    var profileID, resistance1, resistance2, sectorA: String?
    var sectorCode, sectorE, support1, support2: String?
    var symbol, symbolCapital, symbolNameA, symbolNameArabic: String?
    var symbolNameE, symbolNameEnglish, symbolWithIcon, topPrice: String?
    var totalBidVolume, totalOfferVolume, totalValue, totalVolume: String?
    var updateDateTime, webCode, recid, wk52High: String?
    var wk52Low, wk52Range: String?
}

extension AddMarketWatchProfileSymbolsUIModel {
    static func mapToUIModel(_ model:AddMarketWatchProfileSymbolsResponseModel)->Self {
        return  AddMarketWatchProfileSymbolsUIModel(accumlossFlags: model.accumlossFlags ?? "", allowdBuyLimit: model.allowdBuyLimit ?? "", avgPrice: model.avgPrice ?? "", bidPrice: model.bidPrice ?? "", bidVolume: model.bidVolume ?? "", buyCashFlowPerc: model.buyCashFlowPerc ?? "", curCode: model.curCode ?? "", closePrice: model.closePrice ?? "", companyA: model.companyA ?? "", companyE: model.companyE ?? "", dayRange: model.dayRange ?? "", depthBuyOrder: model.depthBuyOrder ?? "", depthByPrice: model.depthByPrice ?? "", eps: model.eps ?? "", exchange: model.exchange ?? "", executed: model.exchange ?? "", highPrice: model.highPrice ?? "", islm: model.islm ?? "", isCryptoSymbol: model.isCryptoSymbol ?? "", isUsOnline: model.isUsOnline ?? "", indicator: model.indicator ?? "", isInAlerts: model.isInAlerts ?? "", isInPortfolio: model.isInPortfolio ?? "", isMargin: model.isMargin ?? "", lastTradePrice: model.lastTradePrice ?? "", lastTradeVolume: model.lastTradeVolume ?? "", losses: model.losses ?? "", lowPrice: model.lowPrice ?? "", marketType: model.marketType ?? "", maxPrice: model.maxPrice ?? "", minPrice: model.minPrice ?? "", netChange: model.netChange ?? "", netChangePerc: model.netChangePerc ?? "", offerPrice: model.offerPrice ?? "", offerVolume: model.offerVolume ?? "", openPrice: model.openPrice ?? "", pe: model.pe ?? "", pivotPoint: model.pivotPoint ?? "", precision: model.precision ?? "", profileID: model.profileID ?? "", resistance1: model.resistance1 ?? "", resistance2: model.resistance2 ?? "", sectorA: model.sectorA ?? "", sectorCode: model.sectorCode ?? "", sectorE: model.sectorE ?? "", support1: model.support1 ?? "", support2: model.support2 ?? "", symbol: model.symbol ?? "", symbolCapital: model.symbolCapital ?? "", symbolNameA: model.symbolNameA ?? "", symbolNameArabic: model.symbolNameArabic ?? "", symbolNameE: model.symbolNameE ?? "", symbolNameEnglish: model.symbolNameEnglish ?? "", symbolWithIcon: model.symbolWithIcon ?? "", topPrice: model.topPrice ?? "", totalBidVolume: model.totalBidVolume ?? "", totalOfferVolume: model.totalOfferVolume ?? "", totalValue: model.totalValue ?? "", totalVolume: model.totalVolume ?? "", updateDateTime: model.updateDateTime ?? "", webCode: model.webCode ?? "", recid: model.recid ?? "", wk52High: model.wk52High ?? "", wk52Low: model.wk52Low ?? "", wk52Range: model.wk52Range ?? "")
    }
}
