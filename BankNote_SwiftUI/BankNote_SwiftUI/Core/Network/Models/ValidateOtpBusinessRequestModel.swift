//
//  ValidateOtpBusinessRequestModel.swift
//  mahfazati
//
//  Created by FIT on 17/03/2025.
//  Copyright © 2025 Mohammed Mathkour. All rights reserved.
//

import Foundation

struct ValidateOtpBusinessRequestRequestModel: Codable {
    let accessToken: String?
        let geoLocation: ValidateOtpGeoLocation?
        let otpCode, otpRequestID, requestID, requestIDVlens: String?
        let transactionID, userDeviceUTCTime: String?

        enum CodingKeys: String, CodingKey {
            case accessToken = "AccessToken"
            case geoLocation = "GeoLocation"
            case otpCode = "OtpCode"
            case otpRequestID = "OtpRequestId"
            case requestID = "RequestId"
            case requestIDVlens = "RequestId_Vlens"
            case transactionID = "TransactionId"
            case userDeviceUTCTime = "UserDeviceUtcTime"
        }
    }

    struct ValidateOtpGeoLocation: Codable {
        let latitude, longitude: String?

        enum CodingKeys: String, CodingKey {
            case latitude = "Latitude"
            case longitude = "Longitude"
        }
    }


struct ValidateOtpBusinessRequestResponseModel: Codable {
    let data: ValidateOtpData?
        let errorCode, errorMessage: String?

        enum CodingKeys: String, CodingKey {
            case data
            case errorCode = "error_code"
            case errorMessage = "error_message"
        }
}

struct ValidateOtpData: Codable {
    let contractStorageID: String?
    let geoLocation: ValidateOtpGeoLocation?
    let isOtpValidated: Bool?
    let requestID, transactionID, userDeviceUTCTime: String?

    enum CodingKeys: String, CodingKey {
        case contractStorageID = "contractStorageId"
        case geoLocation, isOtpValidated
        case requestID = "requestId"
        case transactionID = "transactionId"
        case userDeviceUTCTime = "userDeviceUtcTime"
    }
}
