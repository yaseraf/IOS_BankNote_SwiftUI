//
//  InsertAttachmentsModel.swift
//  mahfazati
//
//  Created by FIT on 09/11/2024.
//  Copyright © 2024 Mohammed Mathkour. All rights reserved.
//

import Foundation

struct InsertAttachmentsRequestModel: Codable {
    var RequestId: String?
    var fields: [InsertAttachmentsFields]?
}

struct InsertAttachmentsFields: Codable {
    var DocType: String?
    var field_id: String?
    var field_value: [Int]?
}

struct InsertAttachmentsResponseModel: Codable {
    var ErrorMsg: String?
}
