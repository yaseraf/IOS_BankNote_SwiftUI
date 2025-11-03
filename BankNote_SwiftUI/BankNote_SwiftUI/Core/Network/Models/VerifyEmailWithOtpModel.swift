//
//  VerifyEmailWithOtpModel.swift
//  mahfazati
//
//  Created by FIT on 09/11/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation

struct VerifyEmailWithOtpRequestModel: Codable {
    var Email: String?
    var EmailOtp: String?
    var EmailOtpRequestId: String?
    var Request_Id: String?
}

struct VerifyEmailWithOtpResponseModel: Codable {
    var Data: VerifyEmailWithOtpData?
    var ErrorCode: String?
    var ErrorMessage: String?
}

struct VerifyEmailWithOtpData: Codable {
    var EmailOtpExpireInSeconds: Double?
    var EmailOtpRequestId: String?
    var IsEmailConfirmed: Bool?
    var TransactionId: String?
}
