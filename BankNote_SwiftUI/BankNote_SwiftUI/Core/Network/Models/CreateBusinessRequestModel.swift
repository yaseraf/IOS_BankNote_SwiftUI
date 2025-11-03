//
//  CreateBusinessRequestModel.swift
//  mahfazati
//
//  Created by FIT on 17/03/2025.
//  Copyright © 2025 FIT. All rights reserved.
//

import Foundation

struct CreateBusinessRequestRequestModel: Codable {
    let requestID, accessToken: String?
       let geoLocation: CreateBusinessGeoLocation?
       let requestFieldsValues: CreateBusinessRequestFieldsValue?
       let typeID: String?

       enum CodingKeys: String, CodingKey {
           case requestID = "Request_Id"
           case accessToken, geoLocation, requestFieldsValues
           case typeID = "typeId"
       }
   }

struct CreateBusinessGeoLocation: Codable {
   let latitude, longitude: String?

   enum CodingKeys: String, CodingKey {
       case latitude = "Latitude"
       case longitude = "Longitude"
   }
}

struct CreateBusinessRequestFieldsValue: Codable {
   let key, value: String?

   enum CodingKeys: String, CodingKey {
       case key = "Key"
       case value = "Value"
   }
}

//--------------------------------------------------------------------//
//--------------------------------------------------------------------//

struct CreateBusinessRequestResponseModel: Codable {
    let data: CreateBusinessDataClass?
        let errorCode, errorMessage: String?

        enum CodingKeys: String, CodingKey {
            case data
            case errorCode = "error_code"
            case errorMessage = "error_message"
        }
    }

struct CreateBusinessDataClass: Codable {
    let id: String?
    let requestFields: [CreateBusinessRequestField]?
    let requestNumber: String?
}

struct CreateBusinessRequestField: Codable {
    let availableValues: [String]?
    let availableValuesItems: [CreateBusinessAvailableValuesItem]?
    let convertNumbersToArabic: Bool?
    let defaultValue, displayText: String?
    let firstRowHeader: Bool?
    let key: String?
    let order: Int?
    let tabularData: [[String]]?
    let type, value: String?
    let visibleToUser: Bool?

    enum CodingKeys: String, CodingKey {
        case availableValues = "AvailableValues"
        case availableValuesItems = "AvailableValuesItems"
        case convertNumbersToArabic = "ConvertNumbersToArabic"
        case defaultValue = "DefaultValue"
        case displayText = "DisplayText"
        case firstRowHeader = "FirstRowHeader"
        case key = "Key"
        case order = "Order"
        case tabularData = "TabularData"
        case type = "Type"
        case value = "Value"
        case visibleToUser = "VisibleToUser"
    }
}

struct CreateBusinessAvailableValuesItem: Codable {
    let id: Int?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
    }
}
