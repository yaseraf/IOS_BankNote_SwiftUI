//
//  PriceFactorModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 19/08/2025.
//

import Foundation

struct PriceFactorRequestModel: Codable {
    
}

struct PriceFactorResponseModel: Codable {
    let factorId: Int?
    let factorName: String?
}

struct PriceFactorUIModel {
    var factorId: Int?
    var factorName: String?
    
    static func mapToUIModel(_ model: PriceFactorResponseModel) -> Self {
        return PriceFactorUIModel(factorId: model.factorId, factorName: model.factorName)
    }
    
    static func initializer() -> Self {
        return PriceFactorUIModel()
    }
}
