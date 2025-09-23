//
//  GetCurrentListIdsModel.swift
//  mahfazati
//
//  Created by FIT on 31/08/2025.
//  Copyright © 2025 Mohammed Mathkour. All rights reserved.
//

import Foundation

struct GetCurrentListIdsRequestModel: Codable {
    var accessToken: String
}


struct GetCurrentListIdsResponseModel: Codable {
    let data: [ContractData]
    let errorCode: String?
    let errorMessage: String?
    
    enum CodingKeys: String, CodingKey {
        case data = "Data"
        case errorCode = "ErrorCode"
        case errorMessage = "ErrorMessage"
    }
}

struct ContractData: Codable {
    let contractTypeId: String?
    let contractTypeName: String?
    let creationTime: String?
    let fullName: String?
    let id: String?
    let idNumber: String?
    let requestNumber: String?
    let requestStatus: String?
    let requestStatusName: String?
    let type: String?
    let typeName: String?
    
    enum CodingKeys: String, CodingKey {
        case contractTypeId = "ContractTypeId"
        case contractTypeName = "ContractTypeName"
        case creationTime = "CreationTime"
        case fullName = "FullName"
        case id = "Id"
        case idNumber = "IdNumber"
        case requestNumber = "RequestNumber"
        case requestStatus = "RequestStatus"
        case requestStatusName = "RequestStatusName"
        case type = "Type"
        case typeName = "TypeName"
    }
}

struct GetCurrentListIdsUIModel {
    var data: [ContractData]
    var errorCode: String?
    var errorMessage: String?

    static func mapToUIModel(_ model: GetCurrentListIdsResponseModel) -> Self {
        return GetCurrentListIdsUIModel(data: model.data, errorCode: model.errorCode, errorMessage: model.errorMessage)
    }
}
