//
//  GetKYCContractValify.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 03/02/2026.
//

import Foundation

struct GetKycContractValifyRequestModel: Codable {
    let reqID: String

    enum CodingKeys: String, CodingKey {
        case reqID
    }
}

struct GetKycContractValifyResponseModel: Codable {
    let errorMsg: String?
    let errorCode: String?
    let resData: [GetKycContractValifyModel]?

    enum CodingKeys: String, CodingKey {
        case errorMsg = "Error_Msg"
        case errorCode = "Error_code"
        case resData = "ResData"
    }
}

struct GetKycContractValifyModel: Codable {
    let contractName: String?
    let contractVersion: String?
    let id: String?

    enum CodingKeys: String, CodingKey {
        case contractName = "CONTRACTNAME"
        case contractVersion = "CONTRACTVERSION"
        case id = "ID"
    }
}

struct GetKycContractValifyUIModel {
    var data: [GetKycContractValifyModel]?
    var errorCode: String?
    var errorDescriptions: String?
    var errorMessage: String?

    static func mapToUIModel(_ model: GetKycContractValifyResponseModel) -> Self {
        return GetKycContractValifyUIModel(
            data: model.resData,
            errorCode: model.errorCode,
            errorDescriptions: nil,
            errorMessage: model.errorMsg
        )
    }

    static func initializer() -> Self {
        return GetKycContractValifyUIModel()
    }
}
