//
//  GetLookupsModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 25/08/2025.
//

import Foundation

struct GetLookupsRequestModel {
    
}

struct GetLookupsResponseModel: Codable {
    let descA, descE, id, type: String?

        enum CodingKeys: String, CodingKey {
            case descA = "DescA"
            case descE = "DescE"
            case id = "ID"
            case type = "Type"
        }
}

struct GetLookupsUIModel: Codable {
    var descA, descE, id, type:String?
    
    static func mapToUIModel(_ model:GetLookupsResponseModel) -> Self {
        return GetLookupsUIModel(descA: model.descA, descE: model.descE, id: model.id, type: model.type)
    }
    
    static func initializer() -> Self {
        return GetLookupsUIModel()
    }
}
