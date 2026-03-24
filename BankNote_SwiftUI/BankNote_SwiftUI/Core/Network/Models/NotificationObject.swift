//
//  NotificationObject.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 05/03/2026.
//

import Foundation

struct NotificationObject: Codable {
    var id = UUID().uuidString
    var symbol: String?
    var companyName: String?
    var orderId: String?
    var quantity: String?
    var price: String?
    var statusCode: String?
    var alertTitle: String?
    var alertDesc: String?
    var newsTitle: String?
    var newsDesc: String?
    var objectType: String?
    var date: String?
}

struct MarketNewsObject: Codable {
    var MarketID: String?
    var NewsDescA: String?
    var NewsDescE: String?
    var NewsDate: String?
    var Symbol: String?
    var NotifyID: String?
    var LastUpdateTime: String?
}
