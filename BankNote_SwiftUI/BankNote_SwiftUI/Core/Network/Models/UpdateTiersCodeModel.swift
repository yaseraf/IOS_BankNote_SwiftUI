//
//  UpdateTiersCodeModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 18/03/2026.
//

import Foundation

struct UpdateTiersCodeRequestModel: Codable {
    let tiersCode: String?
    let webCode: String?
    
    enum CodingKeys: String, CodingKey {
        case tiersCode = "TiersCode"
        case webCode = "WebCode"
    }
}

struct UpdateTiersCodeResponseModel: Codable {
    let errorMsg: String?
    let errorCode: String?
    
    enum CodingKeys: String, CodingKey {
        case errorMsg = "Error_Msg"
        case errorCode = "Error_code"
    }
}

struct UpdateTiersCodeUIModel {
    var errorMsg: String?
    var errorCode: String?
    
    static func mapToUIModel(_ model: UpdateTiersCodeResponseModel) -> Self {
        return UpdateTiersCodeUIModel(
            errorMsg: model.errorMsg,
            errorCode: model.errorCode
        )
    }
    
    static func initializer() -> Self {
        return UpdateTiersCodeUIModel()
    }
}
