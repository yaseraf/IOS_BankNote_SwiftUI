//
//  VerifyIDFrontVlensModel.swift
//  mahfazati
//
//  Created by FIT on 09/11/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation

struct VerifyIDFrontVlensRequestModel: Codable {
    var Image: String?
    var transaction_id: String?
    var accessToken: String?
    var Request_Id: String?
}

struct VerifyIDFrontVlensResponseModel: Codable {
    
    let transactionID: String?
    let data: VerifyIDFrontVlensData?
    let errorCode, errorMessage: String?
    let services: VerifyIDFrontVlensServices?

    enum CodingKeys: String, CodingKey {
        case transactionID = "TransactionId"
        case data
        case errorCode = "error_code"
        case errorMessage = "error_message"
        case services
    }
}

struct VerifyIDFrontVlensData: Codable {

    let deviceInfo: String?
    let idBackData: VerifyIDBackData?
    let idFrontData: VerifyIDFrontData?
    let isDigitalIdentityVerified, isVerificationProcessCompleted: Bool?
    let user: VerifyIDFrontUser?
}

struct VerifyIDFrontData: Codable {
    let address, addressEnglish, dateOfBirth, firstName: String?
    let firstNameEnglish, gender, govern, governEnglish: String?
    let idKey, idNumber, lastNames, lastNamesEnglish: String?
    let name, nameEnglish, transactionID: String?

    enum CodingKeys: String, CodingKey {
        case address
        case addressEnglish = "address_english"
        case dateOfBirth
        case firstName = "first_name"
        case firstNameEnglish = "first_name_english"
        case gender, govern
        case governEnglish = "govern_english"
        case idKey, idNumber
        case lastNames = "last_names"
        case lastNamesEnglish = "last_names_english"
        case name
        case nameEnglish = "name_english"
        case transactionID = "transaction_id"
    }
}

struct VerifyIDFrontUser: Codable {
    let address, emailAddress, fullName: String?
    let id: Int?
    let idNumber, name, phoneNumber, surname: String?
    let userName: String?
}

struct VerifyIDFrontVlensServices: Codable {
    let aml: VerifyIDFrontAml?
    let src: VerifyIDFrontSrc?
    let validations: VerifyIDFrontValidations?
    let classification: VerifyIDFrontClassification?
    let liveness: Bool?
    let spoofing: VerifyIDFrontSpoofing?

    enum CodingKeys: String, CodingKey {
        case aml = "AML"
        case src = "SRC"
        case validations = "Validations"
        case classification, liveness, spoofing
    }
}

struct VerifyIDFrontAml: Codable {
    let amlMatched: Bool?

    enum CodingKeys: String, CodingKey {
        case amlMatched = "AML_matched"
    }
}

struct Classification: Codable {
    let docType: String?

    enum CodingKeys: String, CodingKey {
        case docType = "doc_type"
    }
}

struct VerifyIDFrontSpoofing: Codable {
    let fake: Bool?
}

struct VerifyIDFrontSrc: Codable {
    let errorCode: Int?
    let errorKey, errorMessage: String?
    let isValid: Bool?
}

struct VerifyIDFrontValidations: Codable {
    let validationErrors: [VerifyIDFrontValidationError]?

    enum CodingKeys: String, CodingKey {
        case validationErrors = "validation_errors"
    }
}

struct VerifyIDFrontValidationError: Codable {
    let errors: [VerifyIDFrontError]?
    let field, value: String?
}

struct VerifyIDFrontError: Codable {
    let code: Int?
    let message: String?
}

struct VerifyIDFrontClassification: Codable {
    let docType: String?

    enum CodingKeys: String, CodingKey {
        case docType = "doc_type"
    }
}
