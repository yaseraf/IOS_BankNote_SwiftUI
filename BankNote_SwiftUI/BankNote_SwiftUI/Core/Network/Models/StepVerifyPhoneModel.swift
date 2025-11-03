//
//  StepVerifyPhoneModel.swift
//  mahfazati
//
//  Created by FIT on 09/11/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation


struct StepVerifyPhoneRequestModel: Codable {
    var phoneNumber: String
        var phoneNumberOtp: String
        var phoneNumberOtpRequestId: String

        enum CodingKeys: String, CodingKey {
            case phoneNumber = "PhoneNumber"
            case phoneNumberOtp = "PhoneNumberOtp"
            case phoneNumberOtpRequestId = "PhoneNumberOtpRequestId"
        }
}

struct StepVerifyPhoneResponseModel: Codable {
    var Data: StepVerifyPhoneData?
    var ErrorCode: String?
    var ErrorMessage: String?
}

struct StepVerifyPhoneData: Codable {
    var IsPhoneNumberConfirmed: Bool?
    var PhoneNumberOtpRequestId: String?
    var PhoneOtpExpireInSeconds: Double?
    var TransactionId: String?
}
