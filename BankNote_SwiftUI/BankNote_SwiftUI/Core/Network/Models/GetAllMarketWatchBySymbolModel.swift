//
//  GetAllMarketWatchBySymbolModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 21/09/2025.
//

import Foundation

struct GetALLMarketWatchBySymbolRequestModel {
    
}

struct GetALLMarketWatchBySymbolResponseModel: Codable {
    let accumlossFlags, allowdBuyLimit, avgPrice, bidPrice: String?
        let bidVolume, buyCashFlowPerc, curCode, closePrice: String?
        let companyA, companyE, companyDIVIDENDYIELDPERC, companyFACEVALUE: String?
        let companyMARKETCAP, companyPERATIO, dayRange, depthBuyOrder: String?
        let depthByPrice, eps, exchange, executed: String?
        let highPrice, islm, isCryptoSymbol, isUsOnline: String?
        let indicator, isInAlerts, isInPortfolio, isMargin: String?
        let k, lastTradePrice, lastTradeVolume, losses: String?
        let lowPrice, marketType, maxPrice, minPrice: String?
        let netChange, netChangePerc, offerPrice, offerVolume: String?
        let openPrice: String?
        let pe, pivotPoint, precision, profileID: String?
        let r1, r2, resistance1, resistance2: String?
        let s1, s2, sectorA, sectorCode: String?
        let sectorE, suppResType, support1, support2: String?
        let symbol, symbolCapital, symbolNameA, symbolNameArabic: String?
        let symbolNameE, symbolNameEnglish, symbolWithIcon, technicalSRMistLAST: String?
        let technicalSRMistOPEN, topPrice, totalBidExecutions, totalBidVolume: String?
        let totalOfferExecutions, totalOfferVolume, totalValue, totalVolume: String?
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
            case companyDIVIDENDYIELDPERC = "Company_DIVIDEND_YIELD_PERC"
            case companyFACEVALUE = "Company_FACE_VALUE"
            case companyMARKETCAP = "Company_MARKET_CAP"
            case companyPERATIO = "Company_PE_RATIO"
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
            case suppResType = "SuppRes_Type"
            case support1 = "Support1"
            case support2 = "Support2"
            case symbol = "Symbol"
            case symbolCapital = "SymbolCapital"
            case symbolNameA = "SymbolNameA"
            case symbolNameArabic = "SymbolNameArabic"
            case symbolNameE = "SymbolNameE"
            case symbolNameEnglish = "SymbolNameEnglish"
            case symbolWithIcon = "SymbolWithIcon"
            case technicalSRMistLAST = "Technical_SR_Mist_LAST"
            case technicalSRMistOPEN = "Technical_SR_Mist_OPEN"
            case topPrice = "TopPrice"
            case totalBidExecutions = "TotalBidExecutions"
            case totalBidVolume = "TotalBidVolume"
            case totalOfferExecutions = "TotalOfferExecutions"
            case totalOfferVolume = "TotalOfferVolume"
            case totalValue = "TotalValue"
            case totalVolume = "TotalVolume"
            case updateDateTime = "UpdateDateTime"
            case webCode = "WebCode"
            case recid, wk52High, wk52Low, wk52Range
        }
}

struct GetALLMarketWatchBySymbolUIModel {
    var accumlossFlags, allowdBuyLimit, avgPrice, bidPrice: String?
    var bidVolume, buyCashFlowPerc, curCode, closePrice: String?
    var companyA, companyE, companyDIVIDENDYIELDPERC, companyFACEVALUE: String?
    var companyMARKETCAP, companyPERATIO, dayRange, depthBuyOrder: String?
    var depthByPrice, eps, exchange, executed: String?
    var highPrice, islm, isCryptoSymbol, isUsOnline: String?
    var indicator, isInAlerts, isInPortfolio, isMargin: String?
    var k, lastTradePrice, lastTradeVolume, losses: String?
    var lowPrice, marketType, maxPrice, minPrice: String?
    var netChange, netChangePerc, offerPrice, offerVolume: String?
    var openPrice: String?
    var pe, pivotPoint, precision, profileID: String?
    var r1, r2, resistance1, resistance2: String?
    var s1, s2, sectorA, sectorCode: String?
    var sectorE, suppResType, support1, support2: String?
    var symbol, symbolCapital, symbolNameA, symbolNameArabic: String?
    var symbolNameE, symbolNameEnglish, symbolWithIcon, technicalSRMistLAST: String?
    var technicalSRMistOPEN, topPrice, totalBidExecutions, totalBidVolume: String?
    var totalOfferExecutions, totalOfferVolume, totalValue, totalVolume: String?
    var updateDateTime, webCode, recid, wk52High: String?
    var wk52Low, wk52Range: String?
    
    static func mapToUIModel(_ m:GetALLMarketWatchBySymbolResponseModel)->Self {
        return  GetALLMarketWatchBySymbolUIModel(accumlossFlags: m.accumlossFlags ?? "",allowdBuyLimit: m.allowdBuyLimit ?? "" , avgPrice: m.avgPrice ?? "", bidPrice: m.bidPrice ?? "", bidVolume: m.bidVolume ?? "", buyCashFlowPerc: m.buyCashFlowPerc ?? "", curCode: m.curCode ?? "", closePrice: m.closePrice ?? "", companyA: m.companyA ?? "",companyE: m.companyE ?? "", companyDIVIDENDYIELDPERC: m.companyDIVIDENDYIELDPERC ?? "", companyFACEVALUE: m.companyFACEVALUE ?? "", companyMARKETCAP: m.companyMARKETCAP ?? "", companyPERATIO: m.companyPERATIO ?? "" , dayRange: m.dayRange ?? "", depthBuyOrder: m.depthBuyOrder ?? "", depthByPrice: m.depthByPrice ?? "", eps: m.eps ?? "", exchange: m.exchange ?? "", executed: m.executed ?? "", highPrice: m.highPrice ?? "", islm: m.islm ?? "", isCryptoSymbol: m.isCryptoSymbol ?? "", isUsOnline: m.isUsOnline ?? "", indicator: m.indicator ?? "", isInAlerts: m.isInAlerts ?? "", isInPortfolio: m.isInPortfolio, isMargin: m.isMargin ?? "", k: m.k ?? "", lastTradePrice: m.lastTradePrice ?? "", lastTradeVolume: m.lastTradeVolume ?? "", losses: m.losses ?? "", lowPrice: m.lowPrice ?? "", marketType: m.marketType ?? "", maxPrice: m.maxPrice ?? "", minPrice: m.minPrice ?? "", netChange: m.netChange ?? "", netChangePerc: m.netChangePerc ?? "", offerPrice: m.offerPrice ?? "", offerVolume: m.offerVolume ?? "", openPrice: m.openPrice ?? "", pe: m.pe ?? "", pivotPoint: m.pivotPoint ?? "", precision: m.precision ?? "", profileID: m.profileID ?? "", r1: m.r1 ?? "", r2: m.r2 ?? "", resistance1: m.resistance1 ?? "", resistance2: m.resistance2 ?? "", s1: m.s1 ?? "", s2: m.s2 ?? "", sectorA: m.sectorA ?? "", sectorCode: m.sectorCode ?? "", sectorE: m.sectorE ?? "", suppResType: m.suppResType ?? "", support1: m.support1 ?? "", support2: m.support2 ?? "", symbol: m.symbol ?? "", symbolCapital: m.symbolCapital ?? "", symbolNameA: m.symbolNameA ?? "", symbolNameArabic: m.symbolNameArabic ?? "", symbolNameE: m.symbolNameE ?? "", symbolNameEnglish: m.symbolNameEnglish ?? "", symbolWithIcon: m.symbolWithIcon, technicalSRMistLAST: m.technicalSRMistLAST ?? "", technicalSRMistOPEN: m.technicalSRMistOPEN ?? "", topPrice: m.topPrice ?? "", totalBidExecutions: m.totalBidExecutions ?? "", totalBidVolume: m.totalBidVolume ?? "", totalOfferExecutions: m.totalOfferExecutions ?? "", totalOfferVolume: m.totalOfferVolume ?? "", totalValue: m.totalValue ?? "", totalVolume: m.totalVolume ?? "", updateDateTime: m.updateDateTime ?? "", webCode: m.webCode, recid: m.recid ?? "", wk52High: m.wk52High ?? "", wk52Low: m.wk52Low ?? "", wk52Range: m.wk52Range ?? "")
    }
    
    static func initializer() -> Self {
        return GetALLMarketWatchBySymbolUIModel(accumlossFlags: "", allowdBuyLimit: "", avgPrice: "", bidPrice: "", bidVolume: "", buyCashFlowPerc: "", curCode: "", closePrice: "", companyA: "", companyE: "", companyDIVIDENDYIELDPERC: "", companyFACEVALUE: "", companyMARKETCAP: "", companyPERATIO: "", dayRange: "", depthBuyOrder: "", depthByPrice: "", eps: "", exchange: "", executed: "", highPrice: "", islm: "", isCryptoSymbol: "", isUsOnline: "", indicator: "", isInAlerts: "", isInPortfolio: "", isMargin: "", k: "", lastTradePrice: "", lastTradeVolume: "", losses: "", lowPrice: "", marketType: "", maxPrice: "", minPrice: "", netChange: "", netChangePerc: "", offerPrice: "", offerVolume: "", openPrice: "", pe: "", pivotPoint: "", precision: "", profileID: "", r1: "", r2: "", resistance1: "", resistance2: "", s1: "", s2: "", sectorA: "", sectorCode: "", sectorE: "", suppResType: "", support1: "", support2: "", symbol: "", symbolCapital: "", symbolNameA: "", symbolNameArabic: "", symbolNameE: "", symbolNameEnglish: "", symbolWithIcon: "", technicalSRMistLAST: "", technicalSRMistOPEN: "", topPrice: "", totalBidExecutions: "", totalBidVolume: "", totalOfferExecutions: "", totalOfferVolume: "", totalValue: "", totalVolume: "", updateDateTime: "", webCode: "", recid: "", wk52High: "", wk52Low: "", wk52Range: "")
    }

}
