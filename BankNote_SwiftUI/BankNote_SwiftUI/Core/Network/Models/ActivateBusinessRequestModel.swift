//
//  ActivateBusinessRequestModel.swift
//  mahfazati
//
//  Created by FIT on 17/03/2025.
//  Copyright © 2025 FIT. All rights reserved.
//

import Foundation

struct ActivateBusinessRequestRequestModel: Codable {
    let accessToken: String?
        let geoLocation: ActivateBusinessGeoLocation?
        let requestID, requestIDVlens, userDeviceUTCTime: String?

        enum CodingKeys: String, CodingKey {
            case accessToken = "AccessToken"
            case geoLocation = "GeoLocation"
            case requestID = "RequestId"
            case requestIDVlens = "RequestId_Vlens"
            case userDeviceUTCTime = "UserDeviceUtcTime"
        }
    }

    struct ActivateBusinessGeoLocation: Codable {
        let latitude, longitude: String?

        enum CodingKeys: String, CodingKey {
            case latitude = "Latitude"
            case longitude = "Longitude"
        }
    }

struct ActivateBusinessRequestResponseModel: Codable {
    let data: ActivateBusinessData?
        let errorCode, errorMessage: String?

        enum CodingKeys: String, CodingKey {
            case data
            case errorCode = "error_code"
            case errorMessage = "error_message"
        }
}

struct ActivateBusinessData: Codable {
    let contractStorageID, errorMessage: String?
    let isActive, isValidPayment, needsReValidate: Bool?
    let otpRequestID, paymentLink, requestID, transactionID: String?
    let userDeviceUTCTime: String?

    enum CodingKeys: String, CodingKey {
        case contractStorageID = "contractStorageId"
        case errorMessage, isActive, isValidPayment, needsReValidate
        case otpRequestID = "otpRequestId"
        case paymentLink
        case requestID = "requestId"
        case transactionID = "transactionId"
        case userDeviceUTCTime = "userDeviceUtcTime"
    }
}
