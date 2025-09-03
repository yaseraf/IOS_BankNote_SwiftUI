//
//  MarketDealsModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 13/08/2025.
//

import Foundation

struct MarketDealsRequestModel: Codable {
    
}

struct MarketDealsResponseModel: Codable {
    let image:String?
    let name:String?
    let fullNameA:String?
    let fullNameE:String?
    let date:String?
    let time:String?
    let change:Double?
    let changePerc:Double?
    let quantity:Double?
    let value:Double?
    let price:Double?
}

struct MarketDealsUIModel {
    var image:String?
    var name:String?
    var fullNameA:String?
    var fullNameE:String?
    var date:String?
    var time:String?
    var change:Double?
    var changePerc:Double?
    var quantity:Double?
    var value:Double?
    var price:Double?
    
    static func mapToUIModel(_ model: MarketDealsResponseModel) -> Self {
        return MarketDealsUIModel(image: model.image, name: model.name, fullNameA: model.fullNameA, fullNameE: model.fullNameE, date: model.date, time: model.time, change: model.change, changePerc: model.changePerc, quantity: model.quantity, value: model.value, price: model.price)
    }
    
    static func initializer() -> Self {
        return MarketDealsUIModel()
    }
}
