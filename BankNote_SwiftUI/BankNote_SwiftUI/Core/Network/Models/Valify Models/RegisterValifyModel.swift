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

struct RegisterValifyUIModel {
    var errorMsg: String?
    var isSuccessful: Bool?
    var message: String?
    var registered: String?
    var serverResponse: String?
    var reqID: String?
    
    static func mapToUIModel(_ model: RegisterValifyResponseModel) -> Self {
        return RegisterValifyUIModel(errorMsg: model.errorMsg, isSuccessful: model.isSuccessful, message: model.message, registered: model.registered, serverResponse: model.serverResponse, reqID: model.reqID)
    }
    
    static func initializer() -> Self {
        return RegisterValifyUIModel()
    }

}
