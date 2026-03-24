//
//  LoginValifyModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 11/11/2025.
//

import Foundation

struct LoginValifyRequestModel: Codable {
    let deviceId: String
    let deviceType: String
    let ipAddress: String
    let lang: String
    let latitude: String
    let longitude: String
    let password: String
    let phoneNumber: String
    let timezone: String
    
    enum CodingKeys: String, CodingKey {
        case deviceId = "DeviceId"
        case deviceType = "DeviceType"
        case ipAddress = "IpAddress"
        case lang = "Lang"
        case latitude = "Latitude"
        case longitude = "Longitude"
        case password = "Password"
        case phoneNumber = "PhoneNumber"
        case timezone = "Timezone"
    }
}

struct LoginValifyResponseModel: Codable {
    let actionID: String?
    let accessToken: String?
    let errorMsg: String?
    let isSuccessful: Bool?
    let message: String?
    let registered: String?
    let requestId: String?
    let serverResponse: String?
    let errorCode: Int?
    let errorDetails: String?
    let internalErrorCode: Int?

    enum CodingKeys: String, CodingKey {
        case actionID = "ACTIONID"
        case accessToken = "AccessToken"
        case errorMsg = "ErrorMsg"
        case isSuccessful = "IsSuccessful"
        case message = "Message"
        case registered = "Registered"
        case requestId = "Request_Id"
        case serverResponse = "ServerResponse"
        case errorCode = "error_code"
        case errorDetails = "error_details"
        case internalErrorCode = "internal_error_code"
    }
}

struct LoginValifyUIModel {
    var actionID: String?
    var accessToken: String?
    var errorMsg: String?
    var isSuccessful: Bool?
    var message: String?
    var registered: String?
    var requestId: String?
    var serverResponse: String?
    var errorCode: String?
    var errorDetails: String?
    var internalErrorCode: String?

    static func mapToUIModel(_ model: LoginValifyResponseModel) -> Self {
        return LoginValifyUIModel(
            actionID: model.actionID,
            accessToken: model.accessToken,
            errorMsg: model.errorMsg,
            isSuccessful: model.isSuccessful,
            message: model.message,
            registered: model.registered,
            requestId: model.requestId,
            serverResponse: model.serverResponse,
            errorCode: "\(model.errorCode ?? 0)",
            errorDetails: model.errorDetails,
            internalErrorCode: "\(model.internalErrorCode ?? 0)"
        )
    }

    static func initializer() -> Self {
        return LoginValifyUIModel()
    }
}
