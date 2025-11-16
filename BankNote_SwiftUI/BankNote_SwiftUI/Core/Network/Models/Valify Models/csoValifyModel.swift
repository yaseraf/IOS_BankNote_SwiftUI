//
//  csoValifyModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 16/11/2025.
//

import Foundation

struct CsoValifyRequestModel: Codable {
    let bundleSessionId: String
    let expiration: String
    let firstName: String
    let fullName: String
    let nid: String
    let serialNumber: String
    let reqID: String

    enum CodingKeys: String, CodingKey {
        case bundleSessionId = "BundleSessionId"
        case expiration = "Expiration"
        case firstName = "FirstName"
        case fullName = "FullName"
        case nid = "NID"
        case serialNumber = "SerialNumber"
        case reqID = "reqID"
    }
}

struct CsoValifyResponseModel: Codable {
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

struct CsoValifyUIModel {
    var errorMsg: String?
    var isSuccessful: Bool?
    var message: String?
    var serverResponse: String?
    var reqID: String?

    static func mapToUIModel(_ model: CsoValifyResponseModel) -> Self {
        return CsoValifyUIModel(
            errorMsg: model.errorMsg,
            isSuccessful: model.isSuccessful,
            message: model.message,
            serverResponse: model.serverResponse,
            reqID: model.reqID
        )
    }

    static func initializer() -> Self {
        return CsoValifyUIModel()
    }
}
