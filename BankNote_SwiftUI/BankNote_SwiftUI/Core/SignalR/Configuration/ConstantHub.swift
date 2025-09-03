//
//  ConstantHub.swift
//  QSC
//
//  Created by FIT on 30/07/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation
func printToLog(_ txt: Any){
    #if DEBUG
//    debugPrint(Date().toString(dateFormat: .yyMMddWithTime) + ":  " + ((txt as? String) ?? "-"))
    #endif
//    appDelegate.logTxt += (Date().toString(dateFormat: "yy/MM/dd HH:mm:ss.SSSS") + ", " + ((txt as? String) ?? "-")) + "\n"
}
let standardFontSize: CGFloat = 12
enum HubConnectionStatus:Int {
    case none = 0
    case error = 1
    case starting = 2
    case connected = 3
    case reconnected = 4
    case reconnecting = 5
    case disconnected = 6
    case connectionSlow = 7
}




enum HubMethodType :String,Decodable{
    case sendTopGainerObject = "sendTopGainerObject"
    case sendTopLoserObject = "sendTopLoserObject"
    case sendTopVolumeObject = "sendTopVolumeObject"
    case sendTopValueObject = "sendTopValueObject"
    case sendMostActiveObject = "sendMostActiveObject"
    case getMarketStatistics = "getMarketStatistics"
    case sendServerDateTimeVer2 = "sendServerDateTimeVer2"
    case sendMarketWatchObject = "sendMarketWatchObject"
    case sendMarketWatchListBySymbols = "sendMarketWatchListBySymbols"
    case sendExchangeMarketObject = "sendExchangeMarketObject"
    case sendSymbolTradesFullObject = "sendSymbolTradesFullObject"
    case getSymbolTradesFullObject = "GetSymbolTradesFullObject"
    case sendSymbolTradesSummaryObject = "sendSymbolTradesSummaryObject"
    case getMarketTradesFullObject = "getMarketTradesFullObject"
    case sendMarketTradesFullObject = "sendMarketTradesFullObject" // dont run
    case sendSymbolDetails = "sendSymbolDetails"
    case SubscribeFullMDSymbol = "SubscribeFullMDSymbol"
    case unSubscribeFullMDSymbol = "UnSubscribeFullMDSymbol"
    case getFullMDSymbol = "getFullMDSymbol"
    case subscribeMDSymbol = "SubscribeMDSymbol"
    case unSubscribeMDSymbol = "UnSubscribeMDSymbol"
    case reloadTopTraaaaaa = "ReloadTopTraaaaaa"
    case subscribeMarketStatistics = "SubscribeMarketStatistics" //to start getting update and
    case unSubscribeMarketStatistics = "UnSubscribeMarketStatistics" //when you move to other screen .
    case subscribeMarketWatchSymbols = "SubscribeMarketWatchSymbols"
    case unSubscribeMarketWatchSymbols = "UnSubscribeMarketWatchSymbols"
    case sendOrders = "sendOrders"
    case sendOrderDetails = "sendOrderDetails"
    case sendAddOrderRequest = "sendAddOrderRequest"
    case sendNotifyOrderObject = "sendNotifyOrderObject"
    case sendUserAlertsObject = "sendUserAlertsObject"
    case sendUserPushAlertsObject = "sendUserPushAlertsObject"
    case sendNotifyMarketNewsObject = "sendNotifyMarketNewsObject"
    case disconnected = "Disconnected"
    case getPortfolio = "GetPortfolio"
    case getPortfolioInitial = "GetPortfolioInitial"
    case getRelatedStocks = "getRelatedStocks"
    case getMostWatchStocks = "getMostWatchStocks"
}

