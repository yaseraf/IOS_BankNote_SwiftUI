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
        case reqID = "Request_Id"
    }
}

struct LoginValifyUIModel {
    var errorMsg: String?
    var isSuccessful: Bool?
    var message: String?
    var registered: String?
    var serverResponse: String?
    var reqID: String?
    
    static func mapToUIModel(_ model: LoginValifyResponseModel) -> Self {
        return LoginValifyUIModel(
            errorMsg: model.errorMsg,
            isSuccessful: model.isSuccessful,
            message: model.message,
            registered: model.registered,
            serverResponse: model.serverResponse,
            reqID: model.reqID
        )
    }
    
    static func initializer() -> Self {
        return LoginValifyUIModel()
    }
}
