//
//  CompaniesModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 13/08/2025.
//

import Foundation

struct CompaniesRequestModel: Codable {
    
}

struct CompaniesResponseModel: Codable {
    let image: String?
    let symbol: String?
    let fullNameE: String?
    let fullNameA: String?
}

struct CompaniesUIModel: Codable {
    var image: String?
    var symbol: String?
    var fullNameE: String?
    var fullNameA: String?
    
    static func mapToUIModel(_ model: CompaniesResponseModel) -> Self {
        return CompaniesUIModel(image: model.image, symbol: model.symbol, fullNameE: model.fullNameE, fullNameA: model.fullNameA)
    }
    
    static func initializer() -> Self {
        return CompaniesUIModel()
    }
}
