//
//  SharesModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 03/08/2025.
//

import Foundation

struct SharesRequestModel: Codable {
    
}

struct SharesResponseModel: Codable {
    let stockId: Int?
    let image: String?
    let name: String?
    let fullNameE: String?
    let fullNameA: String?
}

struct SharesUIModel {
    var stockId: Int?
    var image: String?
    var name: String?
    var fullNameE: String?
    var fullNameA: String?
    
    static func mapToUIModel(_ model: SharesResponseModel) -> Self {
        return SharesUIModel(stockId: model.stockId, image: model.image, name: model.name, fullNameE: model.fullNameE, fullNameA: model.fullNameA)
    }
    
    static func initializer() -> Self {
        return SharesUIModel(stockId: 0, image: "", name: "", fullNameE: "", fullNameA: "")
    }
}
