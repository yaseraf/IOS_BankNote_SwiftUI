//
//  GetAllMarketWatchBySymbolModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 02/09/2025.
//

import Foundation

struct GetAllMarketWatchBySymbolRequestModel: Codable {
    
}

import Foundation

struct GetAllMarketWatchBySymbolResponseModel: Codable {
    let accumlossFlags: String?
    let allowdBuyLimit: String?
    let avgPrice: String?
    let bidPrice: String?
    let bidVolume: String?
    let buyCashFlowPerc: String?
    let curCode: String?
    let closePrice: String?
    let companyA: String?
    let companyE: String?
    let companyDividendYieldPerc: String?
    let companyFaceValue: String?
    let companyMarketCap: String?
    let companyPeRatio: String?
    let dayRange: String?
    let depthBuyOrder: String?
    let depthByPrice: String?
    let eps: String?
    let exchange: String?
    let executed: String?
    let highPrice: String?
    let islm: String?
    let isCryptoSymbol: String?
    let isUsOnline: String?
    let indicator: String?
    let isInAlerts: String?
    let isInPortfolio: String?
    let isMargin: String?
    let k: String?
    let lastTradePrice: String?
    let lastTradeVolume: String?
    let losses: String?
    let lowPrice: String?
    let marketType: String?
    let maxPrice: String?
    let minPrice: String?
    let netChange: String?
    let netChangePerc: String?
    let offerPrice: String?
    let offerVolume: String?
    let openPrice: String?
    let pe: String?
    let pivotPoint: String?
    let precision: String?
    let profileID: String?
    let r1: String?
    let r2: String?
    let resistance1: String?
    let resistance2: String?
    let s1: String?
    let s2: String?
    let sectorA: String?
    let sectorCode: String?
    let sectorE: String?
    let support1: String?
    let support2: String?
    let symbol: String?
    let symbolCapital: String?
    let symbolNameA: String?
    let symbolNameArabic: String?
    let symbolNameE: String?
    let symbolNameEnglish: String?
    let symbolWithIcon: String?
    let topPrice: String?
    let totalBidExecutions: String?
    let totalBidVolume: String?
    let totalOfferExecutions: String?
    let totalOfferVolume: String?
    let totalValue: String?
    let totalVolume: String?
    let updateDateTime: String?
    let webCode: String?
    let recid: String?
    let wk52High: String?
    let wk52Low: String?
    let wk52Range: String?
    
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
        case companyDividendYieldPerc = "Company_DIVIDEND_YIELD_PERC"
        case companyFaceValue = "Company_FACE_VALUE"
        case companyMarketCap = "Company_MARKET_CAP"
        case companyPeRatio = "Company_PE_RATIO"
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
        case k = "K"
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
        case r1 = "R1"
        case r2 = "R2"
        case resistance1 = "Resistance1"
        case resistance2 = "Resistance2"
        case s1 = "S1"
        case s2 = "S2"
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
        case totalBidExecutions = "TotalBidExecutions"
        case totalBidVolume = "TotalBidVolume"
        case totalOfferExecutions = "TotalOfferExecutions"
        case totalOfferVolume = "TotalOfferVolume"
        case totalValue = "TotalValue"
        case totalVolume = "TotalVolume"
        case updateDateTime = "UpdateDateTime"
        case webCode = "WebCode"
        case recid = "recid"
        case wk52High = "wk52High"
        case wk52Low = "wk52Low"
        case wk52Range = "wk52Range"
    }
}


struct GetAllMarketWatchBySymbolUIModel {
    
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
    var companyDividendYieldPerc: String?
    var companyFaceValue: String?
    var companyMarketCap: String?
    var companyPeRatio: String?
    var dayRange: String?
    var depthBuyOrder: String?
    var depthByPrice: String?
    var eps: String?
    var exchange: String?
    var executed: String?
    var highPrice: String?
    var islm: String?
    var isCryptoSymbol: String?
    var isUsOnline: String?
    var indicator: String?
    var isInAlerts: String?
    var isInPortfolio: String?
    var isMargin: String?
    var k: String?
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
    var r1: String?
    var r2: String?
    var resistance1: String?
    var resistance2: String?
    var s1: String?
    var s2: String?
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
    var totalBidExecutions: String?
    var totalBidVolume: String?
    var totalOfferExecutions: String?
    var totalOfferVolume: String?
    var totalValue: String?
    var totalVolume: String?
    var updateDateTime: String?
    var webCode: String?
    var recid: String?
    var wk52High: String?
    var wk52Low: String?
    var wk52Range: String?
    
    static func mapToUIModel(_ model: GetAllMarketWatchBySymbolResponseModel) -> Self {
        return GetAllMarketWatchBySymbolUIModel(accumlossFlags: model.accumlossFlags, allowdBuyLimit: model.allowdBuyLimit, avgPrice: model.avgPrice, bidPrice: model.bidPrice, bidVolume: model.bidVolume, buyCashFlowPerc: model.buyCashFlowPerc, curCode: model.curCode, closePrice: model.closePrice, companyA: model.companyA, companyE: model.companyE, companyDividendYieldPerc: model.companyDividendYieldPerc, companyFaceValue: model.companyFaceValue, companyMarketCap: model.companyMarketCap, companyPeRatio: model.companyPeRatio, dayRange: model.dayRange, depthBuyOrder: model.depthBuyOrder, depthByPrice: model.depthByPrice, eps: model.eps, exchange: model.exchange, executed: model.executed, highPrice: model.highPrice, islm: model.islm, isCryptoSymbol: model.isCryptoSymbol, isUsOnline: model.isUsOnline, indicator: model.indicator, isInAlerts: model.isInAlerts, isInPortfolio: model.isInPortfolio, isMargin: model.isMargin, k: model.k, lastTradePrice: model.lastTradePrice, lastTradeVolume: model.lastTradeVolume, losses: model.losses, lowPrice: model.lowPrice, marketType: model.marketType, maxPrice: model.maxPrice, minPrice: model.minPrice, netChange: model.netChange, netChangePerc: model.netChangePerc, offerPrice: model.offerPrice, offerVolume: model.offerVolume, openPrice: model.openPrice, pe: model.pe, pivotPoint: model.pivotPoint, precision: model.precision, profileID: model.profileID, r1: model.r1, r2: model.r2, resistance1: model.resistance1, resistance2: model.resistance2, s1: model.s1, s2: model.s2, sectorA: model.sectorA, sectorCode: model.sectorCode, sectorE: model.sectorE, support1: model.support1, support2: model.support2, symbol: model.symbol, symbolCapital: model.symbolCapital, symbolNameA: model.symbolNameA, symbolNameArabic: model.symbolNameArabic, symbolNameE: model.symbolNameE, symbolNameEnglish: model.symbolNameEnglish, symbolWithIcon: model.symbolWithIcon, topPrice: model.topPrice, totalBidExecutions: model.totalBidExecutions, totalBidVolume: model.totalBidVolume, totalOfferExecutions: model.totalOfferExecutions, totalOfferVolume: model.totalOfferVolume, totalValue: model.totalValue, totalVolume: model.totalVolume, updateDateTime: model.updateDateTime, webCode: model.webCode, recid: model.recid, wk52High: model.wk52High, wk52Low: model.wk52Low, wk52Range: model.wk52Range)
    }
    
    static func initializer() -> Self {
        return GetAllMarketWatchBySymbolUIModel()
    }
}
