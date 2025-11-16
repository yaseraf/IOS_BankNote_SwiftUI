//
//  ntraValifyModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 16/11/2025.
//

import Foundation

struct NtraValifyRequestModel: Codable {
    let bundleSessionId: String
    let nid: String
    let phoneNumber: String
    let reqID: String

    enum CodingKeys: String, CodingKey {
        case bundleSessionId = "BundleSessionId"
        case nid = "NID"
        case phoneNumber = "PhoneNumber"
        case reqID = "reqID"
    }
}

struct NtraValifyResponseModel: Codable {
    let errorMsg: String?
    let isSuccessful: Bool?
    let message: String?
    let serverResponse: String?
    let reqID: String?

    enum CodingKeys: String, CodingKey {
        case errorMsg = "ErrorMsg"
        case isSuccessful = "IsSuccessful"
        case message = "Message"
        case serverResponse = "ServerResponse"
        case reqID = "reqID"
    }
}

struct NtraValifyUIModel {
    var errorMsg: String?
    var isSuccessful: Bool?
    var message: String?
    var serverResponse: String?
    var reqID: String?

    static func mapToUIModel(_ model: NtraValifyResponseModel) -> Self {
        return NtraValifyUIModel(
            errorMsg: model.errorMsg,
            isSuccessful: model.isSuccessful,
            message: model.message,
            serverResponse: model.serverResponse,
            reqID: model.reqID
        )
    }

    static func initializer() -> Self {
        return NtraValifyUIModel()
    }
}
