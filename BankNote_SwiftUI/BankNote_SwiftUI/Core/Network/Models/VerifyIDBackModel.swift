//
//  VerifyIDBackModel.swift
//  mahfazati
//
//  Created by FIT on 09/11/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation

struct VerifyIDBackRequestModel: Codable {
    var Image: String?
    var Request_Id: String?
    var accessToken: String?
    var transaction_id: String?
}

struct VerifyIDBackResponseModel: Codable {

    let transactionID: String?
    let data: VerifyIDBackDataClass?
    let errorCode, errorMessage: String?
    let services: VerifyIDBackServices?

    enum CodingKeys: String, CodingKey {
        case transactionID = "TransactionId"
        case data
        case errorCode = "error_code"
        case errorMessage = "error_message"
        case services
    }
}

struct VerifyIDBackDataClass: Codable {
    let deviceInfo: String?
    let idBackData: VerifyIDBackData?
    let idFrontData: VerifyIDFrontData?
    let isDigitalIdentityVerified, isVerificationProcessCompleted: Bool?
    let user: VerifyIDBackUser?
}


struct VerifyIDBackData: Codable {
    let gender, husbandName, idExpiry, idNumber: String?
    let job, jobTitle, maritalStatus, releaseDate: String?
    let religion, transactionID: String?

    enum CodingKeys: String, CodingKey {
        case gender, husbandName, idExpiry, idNumber, job, jobTitle, maritalStatus, releaseDate, religion
        case transactionID = "transaction_id"
    }
}

struct VerifyIDBackUser: Codable {
    let address, emailAddress, fullName: String?
    let id: Int?
    let idNumber, name, phoneNumber, surname: String?
    let userName: String?
}

struct VerifyIDBackServices: Codable {
    let aml: VerifyIDBackAml?
    let src: VerifyIDBackSrc?
    let validations: VerifyIDBackValidations?
    let classification: VerifyIDBackClassification?
    let liveness: Bool?
    let spoofing: VerifyIDBackSpoofing?

    enum CodingKeys: String, CodingKey {
        case aml = "AML"
        case src = "SRC"
        case validations = "Validations"
        case classification, liveness, spoofing
    }
}

struct VerifyIDBackAml: Codable {
    let amlMatched: Bool?

    enum CodingKeys: String, CodingKey {
        case amlMatched = "AML_matched"
    }
}

struct VerifyIDBackClassification: Codable {
    let docType: String?

    enum CodingKeys: String, CodingKey {
        case docType = "doc_type"
    }
}

struct VerifyIDBackSpoofing: Codable {
    let fake: Bool?
}

struct VerifyIDBackSrc: Codable {
    let errorCode: Int?
    let errorKey, errorMessage: String?
    let isValid: Bool?
}

struct VerifyIDBackValidations: Codable {
    let validationErrors: [VerifyIDBackValidationError]?

    enum CodingKeys: String, CodingKey {
        case validationErrors = "validation_errors"
    }
}

struct VerifyIDBackValidationError: Codable {
    let errors: [VerifyIDBackError]?
    let field, value: String?
}

struct VerifyIDBackError: Codable {
    let code: Int?
    let message: String?
}
