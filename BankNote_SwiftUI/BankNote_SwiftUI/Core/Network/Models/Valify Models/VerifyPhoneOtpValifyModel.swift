//
//  VerifyPhoneOtpValify.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 30/10/2025.
//

import Foundation

struct VerifyPhoneOtpValifyRequestModel: Codable {
    let Lang: String?
    let OTP: String?
    let TransactionId: String?
    let reqID: String?
}

struct VerifyPhoneOtpValifyResponseModel: Codable {
    let ErrorMsg: String?
    let IsSuccessful: Bool?
    let Message: String?
    let Verified: String?
    let reqID: String?
}

struct VerifyPhoneOtpValifyUIModel {
    var ErrorMsg: String?
    var IsSuccessful: Bool?
    var Message: String?
    var Verified: String?
    var reqID: String?
    
    static func mapToUIModel(_ model: VerifyPhoneOtpValifyResponseModel) -> Self {
        return VerifyPhoneOtpValifyUIModel(ErrorMsg: model.ErrorMsg, IsSuccessful: model.IsSuccessful, Message: model.Message, Verified: model.Verified, reqID: model.reqID)
    }
}
