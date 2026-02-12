//
//  SendPhoneOtpValifyModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 30/10/2025.
//

import Foundation

struct SendPhoneOtpValifyRequestModel: Codable {
    let Lang: String?
    let PhoneNumber: String?
}

struct SendPhoneOtpValifyResponseModel: Codable {
    let actionID: String?
    let accessToken: String?
    let errorMsg: String?
    let isSuccessful: Bool?
    let message: String?
    let requestId: String?
    let transactionId: String?
    let trialsRemaining: String?

    enum CodingKeys: String, CodingKey {
        case actionID = "ACTIONID"
        case accessToken = "AccessToken"
        case errorMsg = "ErrorMsg"
        case isSuccessful = "IsSuccessful"
        case message = "Message"
        case requestId = "Request_Id"
        case transactionId = "TransactionId"
        case trialsRemaining = "TrialsRemaining"
    }
}

struct SendPhoneOtpValifyUIModel {
    var actionID: String?
    var accessToken: String?
    var errorMsg: String?
    var isSuccessful: Bool?
    var message: String?
    var requestId: String?
    var transactionId: String?
    var trialsRemaining: String?

    static func mapToUIModel(_ model: SendPhoneOtpValifyResponseModel) -> Self {
        return SendPhoneOtpValifyUIModel(actionID: model.actionID, accessToken: model.accessToken, errorMsg: model.errorMsg, isSuccessful: model.isSuccessful, message: model.message, requestId: model.requestId, transactionId: model.transactionId, trialsRemaining: model.trialsRemaining)
    }
}
