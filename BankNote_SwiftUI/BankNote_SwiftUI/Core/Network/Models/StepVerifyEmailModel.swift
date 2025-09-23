//
//  StepVerifyEmailModel.swift
//  mahfazati
//
//  Created by FIT on 09/11/2024.
//  Copyright © 2024 Mohammed Mathkour. All rights reserved.
//

import Foundation

struct StepVerifyEmailRequestModel: Codable {
    var Email: String?
    var EmailOtp: String?
    var EmailOtpRequestId: String?
    var Request_Id: String?
}

struct StepVerifyEmailResponseModel: Codable {
    var Data: StepVerifyEmailData?
    var ErrorCode: String?
    var ErrorMessage: String?
}

struct StepVerifyEmailData: Codable {
    var EmailOtpExpireInSeconds: Double?
    var EmailOtpRequestId: String?
    var IsEmailConfirmed: Bool?
    var TransactionId: String?
}
