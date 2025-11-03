//
//  PortfolioModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 24/07/2025.
//

import Foundation

struct QSCHomePortfolioRequestModel: Codable {
    
}

struct QSCHomePortfolioResponseModel: Codable {
    let stockId: Int?
    let image: String?
    let name: String?
    let fullNameE: String?
    let fullNameN: String?
    let volume: Double?
    let offer: Double?
    let lastPrice: Double?
    let bid: Double?
    let change: Double?
    let changePerc: Double?
    let trades: Double?
    let tradesValue: Double?
    let tradesVolume: Double?
    let acceptedTrades: Double?
    let companyMarketValue: Double?
    let valueQAR: Double?
    let openPrice: Double?
    let closePrice: Double?
    let previousPrice: Double?
    let downPrice: Double?
    let upPrice: Double?
    let currentPrice: Double?
    let todayHigh: Double?
    let todayLow: Double?
    let offerVolume: Double?
    let offerPrice: Double?
    let bidVolume: Double?
    let bidPrice: Double?
    let wk52High: Double?
    let wk52Low: Double?
}

struct QSCHomePortfolioUIModel {
    let stockId: Int?
    let image: String?
    let name: String?
    let fullNameE: String?
    let fullNameN: String?
    let volume: Double?
    let offer: Double?
    let lastPrice: Double?
    let bid: Double?
    let change: Double?
    let changePerc: Double?
    let trades: Double?
    let tradesValue: Double?
    let tradesVolume: Double?
    let acceptedTrades: Double?
    let companyMarketValue: Double?
    let valueQAR: Double?
    let openPrice: Double?
    let closePrice: Double?
    let previousPrice: Double?
    let downPrice: Double?
    let upPrice: Double?
    let currentPrice: Double?
    let todayHigh: Double?
    let todayLow: Double?
    let offerVolume: Double?
    let offerPrice: Double?
    let bidVolume: Double?
    let bidPrice: Double?
    let wk52High: Double?
    let wk52Low: Double?
    
    static func mapToUIModel(_ model: QSCHomePortfolioResponseModel) -> Self {
        return QSCHomePortfolioUIModel(stockId: model.stockId, image: model.image, name: model.name, fullNameE: model.fullNameE, fullNameN: model.fullNameN, volume: model.volume, offer: model.offer, lastPrice: model.lastPrice, bid: model.bid, change: model.change, changePerc: model.changePerc, trades: model.trades, tradesValue: model.tradesValue, tradesVolume: model.tradesVolume, acceptedTrades: model.acceptedTrades, companyMarketValue: model.companyMarketValue, valueQAR: model.valueQAR, openPrice: model.openPrice, closePrice: model.closePrice, previousPrice: model.previousPrice, downPrice: model.downPrice, upPrice: model.upPrice, currentPrice: model.currentPrice, todayHigh: model.todayHigh, todayLow: model.todayLow, offerVolume: model.offerVolume, offerPrice: model.offerPrice, bidVolume: model.bidVolume, bidPrice: model.bidPrice, wk52High: model.wk52High, wk52Low: model.wk52Low)
    }
    
    static func initializer() -> Self {
        return QSCHomePortfolioUIModel(stockId: 0, image: "", name: "", fullNameE: "", fullNameN: "", volume: 0, offer: 0, lastPrice: 0, bid: 0, change: 0, changePerc: 0, trades: 0, tradesValue: 0, tradesVolume: 0, acceptedTrades: 0, companyMarketValue: 0, valueQAR: 0, openPrice: 0, closePrice: 0, previousPrice: 0, downPrice: 0, upPrice: 0, currentPrice: 0, todayHigh: 0, todayLow: 0, offerVolume: 0, offerPrice: 0, bidVolume: 0, bidPrice: 0, wk52High: 0, wk52Low: 0)
    }
}
