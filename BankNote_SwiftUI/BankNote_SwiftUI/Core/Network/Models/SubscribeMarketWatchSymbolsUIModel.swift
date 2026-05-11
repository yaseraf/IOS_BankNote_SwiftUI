//
//  SubscribeMarketWatchSymbolsModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 11/05/2026.
//

import Foundation

struct SubscribeMarketWatchSymbolsUIModel: Codable{
    let Symbol, SymbolWithIcon, Exchange, HighPrice, LowPrice, OpenPrice: String?
    let ClosePrice, BidVolume, BidPrice, OfferVolume, OfferPrice, LastTradePrice: String?
    let Executed, NetChange, NetChangePerc, TotalVolume, TotalValue, MBP: String?
    let MBO, AvgPrice, wk52High, wk52Low, TotalBidVolume, TotalOfferVolume: String?
    let Losses, SymbolNameA, SymbolNameE, MarketType, MaxPrice, MinPrice: String?
    let IsInPortfolio, IsInAlerts, IS_US_ONLINE, CUR_CODE, TopPrice, DayRange: String?
    let wk52Range, TotalBidExecutions, TotalOfferExecutions: String?
}

struct symbolTradesSummaryObjectUIModel: Codable {
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
}

extension SubscribeMarketWatchSymbolsUIModel{
   static func mapToUIModel(_ m:SubscribeMarketWatchSymbolsResponseModel) -> Self {
       
       return SubscribeMarketWatchSymbolsUIModel(Symbol: m.Symbol, SymbolWithIcon: m.SymbolWithIcon, Exchange: m.Exchange, HighPrice: m.HighPrice, LowPrice: m.LowPrice, OpenPrice: m.OpenPrice, ClosePrice: m.ClosePrice, BidVolume: m.BidVolume, BidPrice: m.BidPrice, OfferVolume: m.OfferVolume, OfferPrice: m.OfferPrice, LastTradePrice: m.LastTradePrice, Executed: m.Executed, NetChange: m.NetChange, NetChangePerc: m.NetChangePerc, TotalVolume: m.TotalVolume, TotalValue: m.TotalValue, MBP: m.MBP, MBO: m.MBO, AvgPrice: m.AvgPrice, wk52High: m.wk52High, wk52Low: m.wk52Low, TotalBidVolume: m.TotalBidVolume, TotalOfferVolume: m.TotalOfferVolume, Losses: m.Losses, SymbolNameA: m.SymbolNameA, SymbolNameE: m.SymbolNameE, MarketType: m.MarketType, MaxPrice: m.MaxPrice, MinPrice: m.MinPrice, IsInPortfolio: m.IsInPortfolio, IsInAlerts: m.IsInAlerts, IS_US_ONLINE: m.IS_US_ONLINE, CUR_CODE: m.CUR_CODE, TopPrice: m.TopPrice, DayRange: m.DayRange, wk52Range: m.wk52Range, TotalBidExecutions: m.TotalBidExecutions, TotalOfferExecutions: m.TotalOfferExecutions)
    }
    static func testUIModel() -> Self {
        return SubscribeMarketWatchSymbolsUIModel(Symbol: "", SymbolWithIcon: "", Exchange: "", HighPrice: "", LowPrice: "", OpenPrice: "", ClosePrice: "", BidVolume: "", BidPrice: "", OfferVolume: "", OfferPrice: "", LastTradePrice: "", Executed: "", NetChange: "", NetChangePerc: "", TotalVolume: "", TotalValue: "", MBP: "", MBO: "", AvgPrice: "", wk52High: "", wk52Low: "", TotalBidVolume: "", TotalOfferVolume: "", Losses: "", SymbolNameA: "", SymbolNameE: "", MarketType: "", MaxPrice: "", MinPrice: "", IsInPortfolio: "", IsInAlerts: "", IS_US_ONLINE: "", CUR_CODE: "", TopPrice: "", DayRange: "", wk52Range: "", TotalBidExecutions: "", TotalOfferExecutions: "")
    }
}

extension symbolTradesSummaryObjectUIModel {
    static func mapToUIModel(_ m:symbolTradesSummaryObject) -> Self {
        return symbolTradesSummaryObjectUIModel(sequence: m.sequence, symbol: m.symbol, symbolA: m.symbolA, symbolE: m.symbolE, exchange: m.exchange, marketType: m.marketType, price: m.price, volume: m.volume, value: m.value, tradeNo: m.tradeNo, tradeTime: m.tradeTime, sellBuyFlag: m.sellBuyFlag, netChange: m.netChange, netChangePerc: m.netChangePerc, precision: m.precision, tradeID: m.tradeID, lastUpdateTime: m.lastUpdateTime)
    }
    
    
    
    static func testUIModel() -> Self {
        return symbolTradesSummaryObjectUIModel(sequence: 0, symbol: "", symbolA: "", symbolE: "", exchange: "", marketType: "", price: "", volume: "", value: 0, tradeNo: 0, tradeTime: "", sellBuyFlag: "", netChange: "", netChangePerc: "", precision: "", tradeID: "", lastUpdateTime: "")
    }
}
