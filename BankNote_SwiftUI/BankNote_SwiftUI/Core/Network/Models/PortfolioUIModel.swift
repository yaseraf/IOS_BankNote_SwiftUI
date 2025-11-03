//
//  PortfolioModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 07/09/2025.
//

import Foundation

struct PortfolioResponseModel: Codable {
    let image: String?
    let name: String?
    let price: Double?
    let change: Double?
    let changePerc: Double?

}

struct PortfolioUIModel {
    var image: String?
    var name: String?
    var price: Double?
    var change: Double?
    var changePerc: Double?
    
    static func mapToUIModel(_ model: PortfolioResponseModel) -> Self {
        return PortfolioUIModel(image: model.image, name: model.name, price: model.price, change: model.change, changePerc: model.changePerc)
    }
    
    static func initializer() -> Self {
        return PortfolioUIModel()
    }
}
