//
//  GetCurrentBusinessRequestListModel.swift
//  mahfazati
//
//  Created by FIT on 17/03/2025.
//  Copyright © 2025 FIT. All rights reserved.
//

import Foundation

struct GetCurrentBusinessRequestListRequestModel: Codable {
    let requestID, accessToken: String?

        enum CodingKeys: String, CodingKey {
            case requestID = "Request_Id"
            case accessToken
        }
}

struct GetCurrentBusinessRequestListResponseModel: Codable {
    let data: GetCurrentBusinessDatum?
        let errorCode, errorMessage: String?

        enum CodingKeys: String, CodingKey {
            case data = "Data"
            case errorCode = "ErrorCode"
            case errorMessage = "ErrorMessage"
        }
    }

struct GetCurrentBusinessDatum: Codable {
    let amount, confirmationMessage, contractDocument, contractSignerSignature: String?
    let creationTime, creatorUserFullName: String?
    let creatorUserID: Int?
    let customerSignature: String?
    let documents: [GetCurrentBusinessDocument]?
    let financialTC, firstInstallmentDate, fullName, generalTC: String?
    let hasPaymentCheckPerRequestFeature: Bool?
    let idNumber, installmentValue, installmentValueNumber, installmentsNo: String?
    let kycConfirmation, lastModificationTime: String?
    let lastModifierUserID: Int?
    let periodUnit, periodValue: String?
    let requestFields: [GetCurrentBusinessRequestField]?
    let requestNumber: String?
    let requestStatus: Int?
    let requestStatusName, technicalTC, totalAmount, totalAmountNumber: String?
    let user: GetCurrentBusinessUser?

    enum CodingKeys: String, CodingKey {
        case amount = "Amount"
        case confirmationMessage = "ConfirmationMessage"
        case contractDocument = "ContractDocument"
        case contractSignerSignature = "ContractSignerSignature"
        case creationTime = "CreationTime"
        case creatorUserFullName = "CreatorUserFullName"
        case creatorUserID = "CreatorUserId"
        case customerSignature = "CustomerSignature"
        case documents = "Documents"
        case financialTC = "FinancialTC"
        case firstInstallmentDate = "FirstInstallmentDate"
        case fullName = "FullName"
        case generalTC = "GeneralTC"
        case hasPaymentCheckPerRequestFeature = "HasPaymentCheckPerRequestFeature"
        case idNumber = "IdNumber"
        case installmentValue = "InstallmentValue"
        case installmentValueNumber = "InstallmentValueNumber"
        case installmentsNo = "InstallmentsNo"
        case kycConfirmation = "KycConfirmation"
        case lastModificationTime = "LastModificationTime"
        case lastModifierUserID = "LastModifierUserId"
        case periodUnit = "PeriodUnit"
        case periodValue = "PeriodValue"
        case requestFields = "RequestFields"
        case requestNumber = "RequestNumber"
        case requestStatus = "RequestStatus"
        case requestStatusName = "RequestStatusName"
        case technicalTC = "TechnicalTC"
        case totalAmount = "TotalAmount"
        case totalAmountNumber = "TotalAmountNumber"
        case user = "User"
    }
}

struct GetCurrentBusinessDocument: Codable {
    let content: String?
    let isHTML: Bool?
    let order: Int?
    let signature, title: String?

    enum CodingKeys: String, CodingKey {
        case content = "Content"
        case isHTML = "IsHtml"
        case order = "Order"
        case signature = "Signature"
        case title = "Title"
    }
}

struct GetCurrentBusinessRequestField: Codable {
    let availableValues: [String]?
    let availableValuesItems: [GetCurrentBusinessAvailableValuesItem]?
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

struct GetCurrentBusinessAvailableValuesItem: Codable {
    let id: Int?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
    }
}

struct GetCurrentBusinessUser: Codable {
    let emailAddress, fullName: String?
    let id: Int?
    let idNumber, name, phoneNumber, surname: String?
    let userName: String?

    enum CodingKeys: String, CodingKey {
        case emailAddress = "EmailAddress"
        case fullName = "FullName"
        case id = "Id"
        case idNumber = "IdNumber"
        case name = "Name"
        case phoneNumber = "PhoneNumber"
        case surname = "Surname"
        case userName = "UserName"
    }
}
