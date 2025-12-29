//
//  RegisterValifyModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 11/11/2025.
//

import Foundation

struct RegisterValifyRequestModel: Codable {
    let lang: String
    let name: String
    let userReferenceId: String // Same as reqID
    let reqID: String
    
    enum CodingKeys: String, CodingKey {
        case lang = "Lang"
        case name = "Name"
        case userReferenceId = "UserReferenceId"
        case reqID = "reqID"
    }
}

struct RegisterValifyResponseModel: Codable {
    let errorMsg: String?
    let isSuccessful: Bool?
    let message: String?
    let registered: String?
    let serverResponse: String?
    let accessToken: String?
    let expiresIn: String?
    let refreshToken: String?
    let reqID: String?
    let scope: String?
    let tokenType: String?
    
    enum CodingKeys: String, CodingKey {
        case errorMsg = "ErrorMsg"
        case isSuccessful = "IsSuccessful"
        case message = "Message"
        case registered = "Registered"
        case serverResponse = "ServerResponse"
        case accessToken = "access_token"
        case expiresIn = "expires_in"
        case refreshToken = "refresh_token"
        case reqID = "reqID"
        case scope = "scope"
        case tokenType = "token_type"
    }
}

struct RegisterValifyUIModel {
    var errorMsg: String?
    var isSuccessful: Bool?
    var message: String?
    var registered: String?
    var serverResponse: String?
    var accessToken: String?
    var expiresIn: String?
    var refreshToken: String?
    var reqID: String?
    var scope: String?
    var tokenType: String?

    static func mapToUIModel(_ model: RegisterValifyResponseModel) -> Self {
        return RegisterValifyUIModel(errorMsg: model.errorMsg, isSuccessful: model.isSuccessful, message: model.message, registered: model.registered, serverResponse: model.serverResponse, accessToken: model.accessToken, expiresIn: model.expiresIn, refreshToken: model.refreshToken, reqID: model.reqID, scope: model.scope, tokenType: model.tokenType)
    }
    
    static func initializer() -> Self {
        return RegisterValifyUIModel()
    }

}
