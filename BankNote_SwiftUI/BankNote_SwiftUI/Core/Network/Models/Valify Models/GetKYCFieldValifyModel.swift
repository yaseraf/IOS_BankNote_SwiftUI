//
//  GetKYCFieldValifyModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 03/02/2026.
//

import Foundation

struct GetKycFieldValifyRequestModel: Codable {
    let reqID: String

    enum CodingKeys: String, CodingKey {
        case reqID
    }
}

struct GetKycFieldValifyResponseModel: Codable {
    let errorMsg: String?
    let errorCode: String?
    let resData: [GetKycFieldValifyFieldModel]?

    enum CodingKeys: String, CodingKey {
        case errorMsg = "Error_Msg"
        case errorCode = "Error_code"
        case resData = "ResData"
    }
}

struct GetKycFieldValifyFieldModel: Codable {
    let fieldId: String?
    let id: String?
    let isMandatory: String?
    let label: String?
    let type: String?

    enum CodingKeys: String, CodingKey {
        case fieldId = "FIELD_ID"
        case id = "ID"
        case isMandatory = "IS_MANDATORY"
        case label = "LABEL"
        case type = "TYPE"
    }
}

struct GetKycFieldValifyUIModel {
    var data: [GetKycFieldValifyFieldModel]?
    var errorCode: String?
    var errorDescriptions: String?
    var errorMessage: String?

    static func mapToUIModel(_ model: GetKycFieldValifyResponseModel) -> Self {
        return GetKycFieldValifyUIModel(
            data: model.resData,
            errorCode: model.errorCode,
            errorDescriptions: nil,
            errorMessage: model.errorMsg
        )
    }

    static func initializer() -> Self {
        return GetKycFieldValifyUIModel()
    }
}
