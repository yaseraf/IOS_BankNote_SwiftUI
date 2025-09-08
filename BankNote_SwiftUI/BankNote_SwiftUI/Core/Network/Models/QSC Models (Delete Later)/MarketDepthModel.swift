//
//  MarketDepthModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 29/07/2025.
//

import Foundation

struct MarketDepthRequestModel: Codable {
    
}

struct MarketDepthResponsModel: Codable {
    let offerPrice: Double?
    let offerQty: Double?
    let offerVolume: Double?
    let bidPrice: Double?
    let bidQty: Double?
    let bidVolume: Double?
}

struct MarketDepthUIModel {
    var offerQty: Double?
    var offerVolume: Double?
    var offerPrice: Double?
    var bidQty: Double?
    var bidVolume: Double?
    var bidPrice: Double?
    
    static func mapToUIModel(_ model: MarketDepthResponsModel) -> Self {
        return MarketDepthUIModel(offerQty: model.offerQty, offerVolume: model.offerVolume, offerPrice: model.offerPrice, bidQty: model.bidQty, bidVolume: model.bidVolume, bidPrice: model.bidPrice)
    }
    
    static func initializer() -> Self {
        return MarketDepthUIModel(offerQty: 0, offerVolume: 0, offerPrice: 0, bidQty: 0, bidVolume: 0, bidPrice: 0)
    }
}
