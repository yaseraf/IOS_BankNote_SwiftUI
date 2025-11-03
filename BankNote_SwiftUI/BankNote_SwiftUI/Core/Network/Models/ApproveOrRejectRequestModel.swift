//
//  ApproveOrRejectRequestModel.swift
//  mahfazati
//
//  Created by FIT on 18/03/2025.
//  Copyright © 2025 FIT. All rights reserved.
//

import Foundation

struct ApproveOrRejectRequestRequestModel: Codable {
    let accessToken, id: String?
       let isApproved: Bool?
       let requestID, requestNumber: String?
       let requestFields: [RequestField]?

   enum CodingKeys: String, CodingKey {
       case accessToken = "AccessToken"
       case id = "Id"
       case isApproved = "IsApproved"
       case requestID = "RequestId"
       case requestNumber = "RequestNumber"
       case requestFields
   }
}

struct RequestField: Codable {
   let key, value: String?
}


struct ApproveOrRejectRequestResponseModel: Codable {
    let data: Bool?
        let errorCode, errorMessage: String?

    enum CodingKeys: String, CodingKey {
        case data
        case errorCode = "error_code"
        case errorMessage = "error_message"
    }
}
