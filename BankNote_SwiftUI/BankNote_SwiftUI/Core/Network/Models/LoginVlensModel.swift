//
//  LoginVlensModel.swift
//  mahfazati
//
//  Created by FIT on 05/12/2024.
//  Copyright © 2024 Mohammed Mathkour. All rights reserved.
//

import Foundation

struct LoginVlensRequestModel:Codable {
    var GeoLocation: LoginVlensGeoLocation
    var Imei: String
    var Password: String
    var PhoneNumber: String
    var phoneNumberOtp: String
    var phoneNumberOtpRequestId: String
}

struct LoginVlensGeoLocation: Codable {
    var Latitude:String
    var Longitude:String
}

struct LoginVlensResponseModel:Codable {
    let actionID: String?
        let data: DataClass?
        let errorCode, errorMessage, headerAccessToken, requestID: String?

        enum CodingKeys: String, CodingKey {
            case actionID = "ACTION_ID"
            case data = "Data"
            case errorCode = "ErrorCode"
            case errorMessage = "ErrorMessage"
            case headerAccessToken = "HeaderAccessToken"
            case requestID = "Request_Id"
        }
}

    // MARK: - DataClass
    struct DataClass: Codable {
        let accessToken, emailOtpRequestID, encryptedAccessToken: String?
            let hasPendingRequest, isDigitalIdentityVerified, isPhoneNumberConfirmationRequired, isPhoneNumberConfirmed: Bool?
            let phoneNumberOtp, phoneNumberOtpRequestID: String?
            let phoneOtpExpireInSeconds: Int?
            let redirectURI, refreshToken, transactionID: String?
            let user: User?

            enum CodingKeys: String, CodingKey {
                case accessToken = "AccessToken"
                case emailOtpRequestID = "EmailOtpRequestId"
                case encryptedAccessToken = "EncryptedAccessToken"
                case hasPendingRequest = "HasPendingRequest"
                case isDigitalIdentityVerified = "IsDigitalIdentityVerified"
                case isPhoneNumberConfirmationRequired = "IsPhoneNumberConfirmationRequired"
                case isPhoneNumberConfirmed = "IsPhoneNumberConfirmed"
                case phoneNumberOtp = "PhoneNumberOtp"
                case phoneNumberOtpRequestID = "PhoneNumberOtpRequestId"
                case phoneOtpExpireInSeconds = "PhoneOtpExpireInSeconds"
                case redirectURI = "RedirectUri"
                case refreshToken = "RefreshToken"
                case transactionID = "TransactionId"
                case user = "User"
            }
    }

    // MARK: - User
    struct User: Codable {
        let emailAddress, fullName, idNumber, name: String?
            let phoneNumber, surname, userName: String?

            enum CodingKeys: String, CodingKey {
                case emailAddress = "EmailAddress"
                case fullName = "FullName"
                case idNumber = "IdNumber"
                case name = "Name"
                case phoneNumber = "PhoneNumber"
                case surname = "Surname"
                case userName = "UserName"
            }
    }
