//
//  StatisticsMarketModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 11/05/2026.
//

import Foundation

struct StatisticsUIModel{
    var current: String
    var low: String
    var high: String
    var range52w: String
    var height52w: String
    var low52w: String
    var bestBid: String
    var bestOffer: String

    var prevClose: String
    var open: String
    var turnover: String
    var changePercent: String
    var change: String
    var bidQty: String
    var offerQty: String
    var volume: String
}
struct StatisticsMarketUIModel{
//    var bidQty:String
//    var priceLow:Double
//    var priceMax:Double
//    var askQty:String
    
    var bidQty: String
    var bid: String
    var askQty: String
    var ask: String
}

struct StatisticsTotalMarketUIModel{
    var totalBidVolume:String
    var totalAskVolume:String
}
struct StatisticsTradesUIModel{
    var title:String
    var date:String
    var shares:String
    var price:String
}
