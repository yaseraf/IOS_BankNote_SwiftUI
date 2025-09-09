//
//  WatchlistModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 09/09/2025.
//

import Foundation

struct WatchlistResponseModel: Codable {
    let image: String?
    let name: String?
    let fullName: String?
    let change: Double?
    let changePerc: Double?
}

struct WatchlistUIModel {
    var image: String?
    var name: String?
    var fullName: String?
    var change: Double?
    var changePerc: Double?
    
    static func mapToUIModel(_ model: WatchlistResponseModel) -> Self {
        return WatchlistUIModel(image: model.image, name: model.name, fullName: model.fullName, change: model.change, changePerc: model.changePerc)
    }
    
    static func initializer() -> Self {
        return WatchlistUIModel()
    }
}
