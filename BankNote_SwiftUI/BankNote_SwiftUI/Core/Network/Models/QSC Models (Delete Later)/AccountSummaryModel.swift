//
//  AccountSummaryModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 14/08/2025.
//

import Foundation

struct AccountSummaryRequestModel: Codable {
    
}

struct AccountSummaryResponseModel: Codable {
    let date:String?
    let shares:String?
    let sellBuy:String?
    let volume:Double?
    let avgPrice:Double?
    let value:Double?
    let balance:Double?
    let requests:String?
}

struct AccountSummaryUIModel {
    var date:String?
    var shares:String?
    var sellBuy:String?
    var volume:Double?
    var avgPrice:Double?
    var value:Double?
    var balance:Double?
    var requests:String?

    static func mapToUIModel(_ model: AccountSummaryResponseModel) -> Self {
        return AccountSummaryUIModel(date: model.date, shares: model.shares, sellBuy: model.sellBuy, volume: model.volume, avgPrice: model.avgPrice, value: model.value, balance: model.balance, requests: model.requests)
    }
    
    static func initializer() -> Self {
        return AccountSummaryUIModel()
    }
}
