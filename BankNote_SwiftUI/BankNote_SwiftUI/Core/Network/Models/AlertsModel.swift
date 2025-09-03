//
//  AlertsModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 18/08/2025.
//

import Foundation

struct AlertsRequestModel: Codable {
    
}


struct AlertsResponseModel: Codable {
    let image: String?
    let fullNameEn: String?
    let fullNameAr: String?
    let symbol: String?
    let date: String?
    let value: Double?
    let alertNo: Double?
    let priceFactor: String?
    let state: String?
}

struct AlertsUIModel {
    var image: String?
    var fullNameEn: String?
    var fullNameAr: String?
    var symbol: String?
    var date: String?
    var value: Double?
    var alertNo: Double?
    var priceFactor: String?
    var state: String?
    
    static func mapToUIModel(_ model: AlertsResponseModel) -> Self {
        return AlertsUIModel(image: model.image, fullNameEn: model.fullNameEn, fullNameAr: model.fullNameAr, symbol: model.symbol, date: model.date, value: model.value, alertNo: model.alertNo, priceFactor: model.priceFactor, state: model.state)
    }
    
    static func initializer() -> Self {
        return AlertsUIModel()
    }

}
