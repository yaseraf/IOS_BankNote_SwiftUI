//
//  SubscribeMarketWatchSymbolsModel.swift
//  QSC
//
//  Created by FIT on 26/09/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation

struct SubscribeMarketWatchSymbolsResponseModel: Codable {
    let Symbol, SymbolWithIcon, Exchange, HighPrice, LowPrice, OpenPrice: String?
    let ClosePrice, BidVolume, BidPrice, OfferVolume, OfferPrice, LastTradePrice: String?
    let Executed, NetChange, NetChangePerc, TotalVolume, TotalValue, MBP: String?
    let MBO, AvgPrice, wk52High, wk52Low, TotalBidVolume, TotalOfferVolume: String?
    let Losses, SymbolNameA, SymbolNameE, MarketType, MaxPrice, MinPrice: String?
    let IsInPortfolio, IsInAlerts, IS_US_ONLINE, CUR_CODE, TopPrice, DayRange: String?
    let wk52Range, TotalBidExecutions, TotalOfferExecutions: String?
}

struct symbolTradesSummaryObject: Codable {
    let sequence: Double?
        let symbol: String?
        let symbolA: String?
        let symbolE: String?
        let exchange: String?
        let marketType: String?
        let price: String?
        let volume: String?
        let value: Double?
        let tradeNo: Double?
        let tradeTime: String?
        let sellBuyFlag: String?
        let netChange: String?
        let netChangePerc: String?
        let precision: String?
        let tradeID: String?
        let lastUpdateTime: String?
    
    enum CodingKeys: String, CodingKey {
            case sequence = "Sequence"
            case symbol = "Symbol"
            case symbolA = "SymbolA"
            case symbolE = "SymbolE"
            case exchange = "Exchange"
            case marketType = "MarketType"
            case price = "Price"
            case volume = "Volume"
            case value = "Value"
            case tradeNo = "TrdNo"
            case tradeTime = "TradeTime"
            case sellBuyFlag = "SellBuyFlag"
            case netChange = "NetChange"
            case netChangePerc = "NetChgPerc"
            case precision = "Precision"
            case tradeID = "TradeID"
            case lastUpdateTime = "LastUpdateTime"
        }
}
