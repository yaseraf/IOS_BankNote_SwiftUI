//
//  SetPasswordValifyModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 11/11/2025.
//

import Foundation

struct SetPasswordValifyRequestModel: Codable {
    let lang: String
    let password: String
    let reqID: String
    
    enum CodingKeys: String, CodingKey {
        case lang = "Lang"
        case password = "Password"
        case reqID = "reqID"
    }
}

struct SetPasswordValifyResponseModel: Codable {
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

struct SetPasswordValifyUIModel {
    var errorMsg: String?
    var isSuccessful: Bool?
    var message: String?
    var registered: String?
    var serverResponse: String?
    var reqID: String?
    
    static func mapToUIModel(_ model: SetPasswordValifyResponseModel) -> Self {
        return SetPasswordValifyUIModel(
            errorMsg: model.errorMsg,
            isSuccessful: model.isSuccessful,
            message: model.message,
            registered: model.registered,
            serverResponse: model.serverResponse,
            reqID: model.reqID
        )
    }
    
    static func initializer() -> Self {
        return SetPasswordValifyUIModel()
    }
}

