//
//  PortfolioModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 30/07/2025.
//

import Foundation

struct PortfolioRequestModel: Codable {
    
}

struct PortfolioResponseModel: Codable {
    let symbol:String?
    let nameEn:String?
    let nameAr:String?
    let image:String?
    let volume: Double?
    let available: Double?
    let marketValue: Double?
    let avgPrice: Double?
    let value: Double?
    let cost: Double?
    let netPnL: Double?
    let achievedPnL: Double?
}

struct PortfolioUIModel {
    var symbol:String?
    var nameEn:String?
    var nameAr:String?
    var image:String?
    var volume: Double?
    var available: Double?
    var marketValue: Double?
    var avgPrice: Double?
    var value: Double?
    var cost: Double?
    var netPnL: Double?
    var achievedPnL: Double?
    
    static func mapToUIModel(_ model: PortfolioResponseModel) -> Self {
        return PortfolioUIModel(symbol: model.symbol, nameEn: model.nameEn, nameAr: model.nameAr, image: model.image, volume: model.volume, available: model.available, marketValue: model.marketValue, avgPrice: model.avgPrice, value: model.value, cost: model.cost, netPnL: model.netPnL, achievedPnL: model.achievedPnL)
    }
    
    static func initializer() -> Self {
        PortfolioUIModel()
    }
}
