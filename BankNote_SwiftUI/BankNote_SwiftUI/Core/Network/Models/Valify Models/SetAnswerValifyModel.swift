//
//  SetAnswerValifyModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 11/11/2025.
//

import Foundation

struct SetAnswerValifyRequestModel: Codable {
    let answer: String
    let lang: String
    let questionId: String
    let accessToken: String
    let reqID: String
    
    enum CodingKeys: String, CodingKey {
        case answer = "Answer"
        case lang = "Lang"
        case questionId = "QuestionId"
        case accessToken = "accessToken"
        case reqID = "reqID"
    }
}

struct SetAnswerValifyResponseModel: Codable {
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

struct SetAnswerValifyUIModel {
    var errorMsg: String?
    var isSuccessful: Bool?
    var message: String?
    var registered: String?
    var serverResponse: String?
    var reqID: String?
    
    static func mapToUIModel(_ model: SetAnswerValifyResponseModel) -> Self {
        return SetAnswerValifyUIModel(
            errorMsg: model.errorMsg,
            isSuccessful: model.isSuccessful,
            message: model.message,
            registered: model.registered,
            serverResponse: model.serverResponse,
            reqID: model.reqID
        )
    }
    
    static func initializer() -> Self {
        return SetAnswerValifyUIModel()
    }
}
