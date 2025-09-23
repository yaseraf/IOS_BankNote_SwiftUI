//
//  VerifyLivenessModel.swift
//  mahfazati
//
//  Created by FIT on 09/11/2024.
//  Copyright © 2024 Mohammed Mathkour. All rights reserved.
//

import Foundation

struct VerifyLivenessRequestModel: Codable {
    var Face1: String?
    var Face2: String?
    var Face3: String?
    var Request_Id: String?
    var accessToken: String?
    var transaction_id: String?
}

struct VerifyLivenessResponseModel: Codable {
    var Data: VerifyLivenessData?
    var ErrorCode: String?
    var ErrorMessage: String?
    var Services: VerifyLivenessServices?
    var TransactionId: String?
}

struct VerifyLivenessData: Codable {
    var DeviceInfo: VerifyLivenessDeviceInfoData?
    var IsDigitalIdentityVerified: Bool?
    var IsVerificationProcessCompleted: Bool?
    var User: VerifyLivenessUserData?
}

struct VerifyLivenessDeviceInfoData: Codable {
    
}

struct VerifyLivenessUserData: Codable {
    var EmailAddress: String?
    var FullName: String?
    var Id: Double?
    var IdNumber: String?
    var Name: String?
    var PhoneNumber: String?
    var Surname: String?
    var UserName: String?
}

struct VerifyLivenessServices: Codable {
    let aml, src: VerifyLivenessDeviceInfo?
        let validations: VerifyLivenessValidations?
        let classification: VerifyLivenessClassification?
        let liveness, spoofing: VerifyLivenessDeviceInfo?

        enum CodingKeys: String, CodingKey {
            case aml = "AML"
            case src = "SRC"
            case validations = "Validations"
            case classification, liveness, spoofing
        }}

struct VerifyLivenessClassification: Codable {
    let docType: String?

    enum CodingKeys: String, CodingKey {
        case docType = "doc_type"
    }
}

// MARK: - Validations
struct VerifyLivenessValidations: Codable {
    let validationErrors: [VerifyLivenessValidationError]?

    enum CodingKeys: String, CodingKey {
        case validationErrors = "validation_errors"
    }
}

// MARK: - ValidationError
struct VerifyLivenessValidationError: Codable {
    let errors: [VerifyLivenessError]?
    let field, value: String?
}

// MARK: - Error
struct VerifyLivenessError: Codable {
    let code: Int?
    let message: String?
}

struct VerifyLivenessDeviceInfo: Codable {
}


