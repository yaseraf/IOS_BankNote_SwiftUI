//
//  OrdersModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 10/09/2025.
//

import Foundation

struct OrdersResponseModel: Codable {
    let image: String?
    let type: String?
    let name: String?
    let time: String?
    let value: Double?
    let status: String?
}

struct OrdersUIModel {
    var image: String?
    var type: String?
    var name: String?
    var time: String?
    var value: Double?
    var status: String?
    
    static func mapToUIModel(_ model: OrdersResponseModel) -> Self {
        return OrdersUIModel(image: model.image, type: model.type, name: model.name, time: model.time, value: model.value, status: model.status)
    }
    
    static func initializer() -> Self {
        return OrdersUIModel()
    }
}
