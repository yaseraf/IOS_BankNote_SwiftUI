//
//  CheckEmailOrPhoneExistenceModel.swift
//  mahfazati
//
//  Created by FIT on 17/09/2025.
//  Copyright © 2025 Mohammed Mathkour. All rights reserved.
//

import Foundation

struct CheckEmailOrPhoneExistenceRequestModel: Codable {
    var email: String
    var phoneNumber: String
    
    enum CodingKeys: String, CodingKey {
        case email = "Email"
        case phoneNumber = "PhoneNumber"
    }
}

struct CheckEmailOrPhoneExistenceResponseModel: Codable {
    let data: DataResponse?
    let errorCode: String?
    let errorMessage: String?
    let errorDescription: String?

    enum CodingKeys: String, CodingKey {
        case data = "Data"
        case errorCode = "ErrorCode"
        case errorMessage = "ErrorMessage"
        case errorDescription = "error_descriptions"
    }

}


struct DataResponse: Codable {
    let isEmailExists: Bool
    let isPhoneNumberExists: Bool

    enum CodingKeys: String, CodingKey {
        case isEmailExists = "IsEmailExists"
        case isPhoneNumberExists = "IsPhoneNumberExists"
    }
}

struct CheckEmailOrPhoneExistenceUIModel {
    var data: DataResponse?
    var errorCode: String?
    var errorMessage: String?

    static func mapToUIModel (_ model: CheckEmailOrPhoneExistenceResponseModel) -> Self {
        return CheckEmailOrPhoneExistenceUIModel(data: model.data, errorCode: model.errorCode, errorMessage: model.errorMessage)
    }
}
