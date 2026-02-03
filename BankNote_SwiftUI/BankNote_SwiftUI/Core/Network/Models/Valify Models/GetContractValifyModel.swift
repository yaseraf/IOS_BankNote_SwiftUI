//
//  GetContractValifyModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 03/02/2026.
//

import Foundation

struct GetContractValifyRequestModel: Codable {
    let crmNumber: String?
    let fields: [GetContractValifyFieldModel]?
    let lang: String?
    let tenantId: String?
    let token: String?
    let userId: String?
    let autofill: String?
    let expiryMinutes: String?
    let metadata: GetContractValifyMetadataModel?
    let reqID: String?
    let templateVersionId: String?

    enum CodingKeys: String, CodingKey {
        case crmNumber = "CRMNumber"
        case fields = "Fields"
        case lang = "Lang"
        case tenantId = "TenantId"
        case token = "Token"
        case userId = "USER_ID"
        case autofill
        case expiryMinutes = "expiry_minutes"
        case metadata
        case reqID
        case templateVersionId = "template_version_id"
    }
}

struct GetContractValifyFieldModel: Codable {
    let fieldId: String?
    let value: String?

    enum CodingKeys: String, CodingKey {
        case fieldId = "field_id"
        case value
    }
}


struct GetContractValifyMetadataModel: Codable {
    let deviceId: String?
    let deviceIp: String?
    let deviceType: String?
    let kycRefId: String?
    let latitude: String?
    let longitude: String?

    enum CodingKeys: String, CodingKey {
        case deviceId = "device_id"
        case deviceIp = "device_ip"
        case deviceType = "device_type"
        case kycRefId = "kyc_ref_id"
        case latitude
        case longitude
    }
}


struct GetContractValifyResponseModel: Codable {
    let errorMsg: String?
    let isSuccessful: Bool?
    let message: String?
    let iframeUrl: String?

    enum CodingKeys: String, CodingKey {
        case errorMsg = "ErrorMsg"
        case isSuccessful = "IsSuccessful"
        case message = "Message"
        case iframeUrl = "iframe_url"
    }
}


struct GetContractValifyUIModel {
    var data: GetContractValifyResponseModel?
    var errorCode: String?
    var errorDescriptions: String?
    var errorMessage: String?

    static func mapToUIModel(_ model: GetContractValifyResponseModel) -> Self {
        return GetContractValifyUIModel(
            data: model,
            errorCode: nil,
            errorDescriptions: nil,
            errorMessage: model.errorMsg
        )
    }

    static func initializer() -> Self {
        return GetContractValifyUIModel()
    }
}
