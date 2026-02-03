//
//  RegistrationStatusValifyModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 03/02/2026.
//

import Foundation

struct RegistrationStatusValifyRequestModel:Codable {
    let lang: String
    let userReferenceId: String

    enum CodingKeys: String, CodingKey {
        case lang = "Lang"
        case userReferenceId = "UserReferenceId"
    }
}

struct RegistrationStatusValifyResponseModel: Codable {
    let errorMsg: String?
    let isRegisteredLocally: String?
    let isSuccessful: Bool?
    let message: String?
    let phoneNumber: String?
    let registered: String?
    let status: RegistrationStatusValifyStatusModel?
    let userRefId: String?

    enum CodingKeys: String, CodingKey {
        case errorMsg = "ErrorMsg"
        case isRegisteredLocally = "IsRegisteredLocally"
        case isSuccessful = "IsSuccessful"
        case message = "Message"
        case phoneNumber = "PhoneNumber"
        case registered = "Registered"
        case status = "Status"
        case userRefId = "UserRefId"
    }
}


struct RegistrationStatusValifyStatusModel: Codable {
    let csoCheck: String?
    let emailOtpSend: String?
    let emailOtpVerify: String?
    let facematch: String?
    let liveness: String?
    let ntraCheck: String?
    let ocr: String?
    let phoneOtpSend: String?
    let phoneOtpVerify: String?

    enum CodingKeys: String, CodingKey {
        case csoCheck = "cso_check"
        case emailOtpSend = "email_otp_send"
        case emailOtpVerify = "email_otp_verify"
        case facematch
        case liveness
        case ntraCheck = "ntra_check"
        case ocr
        case phoneOtpSend = "phone_otp_send"
        case phoneOtpVerify = "phone_otp_verify"
    }
}


struct RegistrationStatusValifyUIModel {
    var data: RegistrationStatusValifyResponseModel?
    var errorCode: String?
    var errorDescriptions: String?
    var errorMessage: String?

    static func mapToUIModel(_ model: RegistrationStatusValifyResponseModel) -> Self {
        return RegistrationStatusValifyUIModel(
            data: model,
            errorCode: nil,
            errorDescriptions: nil,
            errorMessage: model.errorMsg
        )
    }

    static func initializer() -> Self {
        return RegistrationStatusValifyUIModel()
    }
}
