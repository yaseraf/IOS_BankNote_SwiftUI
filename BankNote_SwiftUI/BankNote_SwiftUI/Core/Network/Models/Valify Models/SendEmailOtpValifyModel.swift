//
//  SendEmailOtpValifyModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 30/10/2025.
//

import Foundation

struct SendEmailOtpValifyRequestModel: Codable {
    let Email: String?
    let Lang: String?
    let reqID: String?
}

struct SendEmailOtpValifyResponseModel: Codable {
    let ErrorMsg: String?
    let IsSuccessful: Bool?
    let Message: String?
    let TransactionId: String?
    let TrialsRemaining: String?
    let reqID: String?
}

struct SendEmailOtpValifyUIModel {
    var ErrorMsg: String?
    var IsSuccessful: Bool?
    var Message: String?
    var TransactionId: String?
    var TrialsRemaining: String?
    var reqID: String?
    
    static func mapToUIModel(_ model: SendEmailOtpValifyResponseModel) -> Self {
        return SendEmailOtpValifyUIModel(ErrorMsg: model.ErrorMsg, IsSuccessful: model.IsSuccessful, Message: model.Message, TransactionId: model.TransactionId, TrialsRemaining: model.TrialsRemaining, reqID: model.reqID)
    }
}
