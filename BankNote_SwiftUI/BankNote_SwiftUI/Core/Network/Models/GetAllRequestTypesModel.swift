//
//  GetAllRequestTypes.swift
//  mahfazati
//
//  Created by FIT on 17/03/2025.
//  Copyright © 2025 FIT. All rights reserved.
//

import Foundation

struct GetAllRequestTypesRequestModel: Codable {
    let requestID, accessToken: String?

        enum CodingKeys: String, CodingKey {
            case requestID = "Request_Id"
            case accessToken
        }
}

struct GetAllRequestTypesResponseModel: Codable {
    let data: [GetAllRequestTypesData]?
    let errorCode, errorMessage: String?

   enum CodingKeys: String, CodingKey {
       case data = "Data"
       case errorCode = "ErrorCode"
       case errorMessage = "ErrorMessage"
   }
}

struct GetAllRequestTypesData: Codable {
   let contractSigners, id, name: String?

   enum CodingKeys: String, CodingKey {
       case contractSigners = "ContractSigners"
       case id = "Id"
       case name = "Name"
   }
}

