//
//  ShareTradesSummaryModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 29/07/2025.
//

import Foundation

struct ShareTradesSummaryRequestModel: Codable {
    
}

struct ShareTradesSummaryResponseModel: Codable {
    let price: Double?
    let totalQty: Double?
    let noOfTrades: Double?
    let value: Double?
}

struct ShareTradesSummaryUIModel: Codable {
    var price: Double?
    var totalQty: Double?
    var noOfTrades: Double?
    var value: Double?
    
    static func mapToUIModel(_ model: ShareTradesSummaryUIModel) -> Self {
        return ShareTradesSummaryUIModel(price: model.price, totalQty: model.totalQty, noOfTrades: model.noOfTrades, value: model.value)
    }
    
    static func initializer() -> Self {
        return ShareTradesSummaryUIModel(price: 0, totalQty: 0, noOfTrades: 0, value: 0)
    }
}
