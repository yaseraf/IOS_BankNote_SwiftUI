//
//  ResetPasswordValifyModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 11/11/2025.
//

import Foundation

struct ResetPasswordValifyRequestModel: Codable {
    let lang: String
    let password: String
    let phoneNumber: String
    let sessionId: String
    let reqID: String
    
    enum CodingKeys: String, CodingKey {
        case lang = "Lang"
        case password = "Password"
        case phoneNumber = "PhoneNumber"
        case sessionId = "SessionId"
        case reqID = "reqID"
    }
}

struct ResetPasswordValifyResponseModel: Codable {
    let errorMsg: String
    let isSuccessful: Bool
    let message: String
    let registered: String
    let serverResponse: String
    let reqID: String
    
    enum CodingKeys: String, CodingKey {
        case errorMsg = "ErrorMsg"
        case isSuccessful = "IsSuccessful"
        case message = "Message"
        case registered = "Registered"
        case serverResponse = "ServerResponse"
        case reqID = "reqID"
    }
}

struct ResetPasswordValifyUIModel {
    var errorMsg: String?
    var isSuccessful: Bool?
    var message: String?
    var registered: String?
    var serverResponse: String?
    var reqID: String?
    
    static func mapToUIModel(_ model: ResetPasswordValifyResponseModel) -> Self {
        return ResetPasswordValifyUIModel(
            errorMsg: model.errorMsg,
            isSuccessful: model.isSuccessful,
            message: model.message,
            registered: model.registered,
            serverResponse: model.serverResponse,
            reqID: model.reqID
        )
    }
    
    static func initializer() -> Self {
        return ResetPasswordValifyUIModel()
    }
}
