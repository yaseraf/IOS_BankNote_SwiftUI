//
//  GetAllMarketNewsBySymbolModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 22/09/2025.
//

import Foundation

struct GetAllMarketNewsBySymbolRequestModel: Codable {
    
}

struct GetAllMarketNewsBySymbolResponseModel: Codable {
        let marketID, newsDate, newsDateT, newsDescA: String?
        let newsDescE, notifyID, symbol: String?

        enum CodingKeys: String, CodingKey {
            case marketID = "MarketID"
            case newsDate = "NewsDate"
            case newsDateT = "NewsDateT"
            case newsDescA = "NewsDescA"
            case newsDescE = "NewsDescE"
            case notifyID = "NotifyID"
            case symbol = "Symbol"
        }
}

struct GetAllMarketNewsBySymbolUIModel{
    var marketID, newsDate, newsDateT, newsDescA: String?
    var newsDescE, notifyID, symbol: String?
    
    static func mapToUIModel(_ model:GetAllMarketNewsBySymbolResponseModel)->Self {
        return  GetAllMarketNewsBySymbolUIModel(marketID: model.marketID ?? "", newsDate: model.newsDate ?? "", newsDateT: model.newsDateT ?? "", newsDescA: model.newsDescA ?? "", newsDescE: model.newsDescE ?? "", notifyID: model.notifyID ?? "", symbol: model.symbol ?? "")
    }
    
    static func initializer() -> Self {
        return GetAllMarketNewsBySymbolUIModel()
    }
}
