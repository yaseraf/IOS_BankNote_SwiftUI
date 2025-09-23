//
//  VerifyPhoneOtpModel.swift
//  mahfazati
//
//  Created by FIT on 09/11/2024.
//  Copyright © 2024 Mohammed Mathkour. All rights reserved.
//

import Foundation

struct VerifyPhoneOtpRequestModel: Codable {
    var PhoneNumber: String?
    var PhoneNumberOtp: String?
    var PhoneNumberOtpRequestId: String?
}

struct VerifyPhoneOtpResponseModel: Codable {
    var AccessToken: String?
    var Data: VerifyPhoneOtpData?
    var ErrorCode: String?
    var ErrorMessage: String?
    var Request_Id: String?
}

struct VerifyPhoneOtpData: Codable {
    var IsPhoneNumberConfirmed: Bool?
    var PhoneNumberOtpRequestId: String?
    var PhoneOtpExpireInSeconds: Double?
    var TransactionId: String?
}

struct VerifyOTPUIModel{
    var viewType:AuthenticationViewType
    var value:String
}
