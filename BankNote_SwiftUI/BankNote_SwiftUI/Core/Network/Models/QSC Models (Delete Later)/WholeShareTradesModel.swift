//
//  WholeShareTradesModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 29/07/2025.
//

import Foundation

struct WholeShareTradesRequestModel: Codable {
    
}

struct WholeShareTradesResponseModel: Codable {
    let price: Double?
    let quantity: Double?
    let value: Double?
    let change: Double?
    let changePerc: Double?
    let time: String?
    let type: String?
}

struct WholeShareTradesUIModel: Codable {
    var price: Double?
    var quantity: Double?
    var value: Double?
    var change: Double?
    var changePerc: Double?
    var time: String?
    var type: String?
    
    static func mapToUIModel(_ model: WholeShareTradesUIModel) -> Self {
        return WholeShareTradesUIModel(price: model.price, quantity: model.quantity, value: model.value, change: model.change, changePerc: model.changePerc, time: model.time, type: model.type)
    }
    
    static func intializer() -> Self {
        return WholeShareTradesUIModel(price: 0, quantity: 0, value: 0, change: 0, changePerc: 0, time: "", type: "")
    }
}
