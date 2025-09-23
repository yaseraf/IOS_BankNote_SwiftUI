//
//  StepCreateModel.swift
//  mahfazati
//
//  Created by FIT on 09/11/2024.
//  Copyright © 2024 Mohammed Mathkour. All rights reserved.
//

import Foundation

struct StepCreateRequestModel: Codable {
    var EmailOtpRequestId: String?
    var GeoLocation: GeoLocationData?
    var Imei: String?
    var Password: String?
    var PhoneNumberOtpRequestId: String?
    var Request_Id: String?
    var PhoneNumber: String?
}

struct GeoLocationData: Codable {
    var Latitude: String?
    var Longitude: String?
}


struct StepCreateResponseModel: Codable {
    var Data: StepCreateData?
    var ErrorCode: String?
    var ErrorMessage: String?
}

struct StepCreateData: Codable {
    var AccessToken: String?
    var IsEmailConfirmed: Bool?
    var IsPhoneNumberConfirmed: Bool?
    var RedirectUri: String?
    var TransactionId: String?
    var User: StepCreateUserData?
}

struct StepCreateUserData: Codable {
    var EmailAddress: String?
    var FullName: String?
    var IdNumber: String?
    var Name: String?
    var PhoneNumber: String?
    var Surname: String?
    var UserName: String?
}
