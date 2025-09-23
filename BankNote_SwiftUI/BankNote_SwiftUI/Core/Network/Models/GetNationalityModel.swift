//
//  GetNationalityModel.swift
//  mahfazati
//
//  Created by FIT on 09/11/2024.
//  Copyright © 2024 Mohammed Mathkour. All rights reserved.
//

import Foundation

struct GetNationalityRequestModel: Codable {
    var FormType: String?
    var Lang: String?
}

struct GetNationalityResponseModel: Codable {
    var ErrorMsg: String?
    var Lang: String?
    var resData: [GetNationalityResData]?
}

struct GetNationalityResData: Codable {
    var IsCitizen: String?
    var NationalityName: String?
    var Risk: String?
    var value: String?
}
