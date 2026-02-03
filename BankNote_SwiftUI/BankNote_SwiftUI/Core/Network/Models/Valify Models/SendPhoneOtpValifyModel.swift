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
    let ErrorMsg: String?
    let IsSuccessful: Bool?
    let Message: String?
    let TransactionId: String?
    let TrialsRemaining: String?
    let reqID: String?
}

struct SendPhoneOtpValifyUIModel {
    var ErrorMsg: String?
    var IsSuccessful: Bool?
    var Message: String?
    var TransactionId: String?
    var TrialsRemaining: String?
    var reqID: String?
    
    static func mapToUIModel(_ model: SendPhoneOtpValifyResponseModel) -> Self {
        return SendPhoneOtpValifyUIModel(ErrorMsg: model.ErrorMsg, IsSuccessful: model.IsSuccessful, Message: model.Message, TransactionId: model.TransactionId, TrialsRemaining: model.TrialsRemaining, reqID: model.reqID)
    }
}
