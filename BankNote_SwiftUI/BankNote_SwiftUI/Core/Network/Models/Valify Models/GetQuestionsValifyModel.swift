//
//  GetQuestionsValifyModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 11/11/2025.
//

import Foundation

struct GetQuestionsValifyRequestModel: Codable {
    let reqID: String
    
    enum CodingKeys: String, CodingKey {
        case reqID = "reqID"
    }
}

struct GetQuestionsValifyResponseModel: Codable {
    let isSuccessful: Bool
    let errorMsg: String
    let message: String
    let registered: String
    let serverResponse: String
    
    enum CodingKeys: String, CodingKey {
        case isSuccessful = "IsSuccessful"
        case errorMsg = "ErrorMsg"
        case message = "Message"
        case registered = "Registered"
        case serverResponse = "ServerResponse"
    }
}

struct GetQuestionsValifyUIModel {
    var isSuccessful: Bool?
    var errorMsg: String?
    var message: String?
    var registered: String?
    var serverResponse: String?
    
    static func mapToUIModel(_ model: GetQuestionsValifyResponseModel) -> Self {
        return GetQuestionsValifyUIModel(
            isSuccessful: model.isSuccessful,
            errorMsg: model.errorMsg,
            message: model.message,
            registered: model.registered,
            serverResponse: model.serverResponse
        )
    }
    
    static func initializer() -> Self {
        return GetQuestionsValifyUIModel()
    }
}
