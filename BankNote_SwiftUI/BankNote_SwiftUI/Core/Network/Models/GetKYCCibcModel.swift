//
//  GetKYCCibcModel.swift
//  mahfazati
//
//  Created by FIT on 09/11/2024.
//  Copyright © 2024 Mohammed Mathkour. All rights reserved.
//

import Foundation

struct GetKYCCibcRequestModel: Codable {
    var RequestItems: [GetKYCCibcRequestItems]?
    var reqID: String?
}

struct GetKYCCibcRequestItems: Codable {
    var ID: String?
    var Value: String?
}

struct GetKYCCibcResponseModel: Codable {
    var Error_code: String?
    var Error_Msg: String?
}
