//
//  IndexModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 09/09/2025.
//

import Foundation

struct IndexResponseModel: Codable {
    let image: String?
    let name: String?
    let changePerc: Double?
    let value: Double?
}

struct IndexUIModel {
    var image: String?
    var name: String?
    var changePerc: Double?
    var value: Double?
    
    static func mapToUIModel(_ model: IndexResponseModel) -> Self {
        return IndexUIModel(image: model.image, name: model.name, changePerc: model.changePerc, value: model.value)
    }
    
    static func initializer() -> Self {
        return IndexUIModel()
    }
}
