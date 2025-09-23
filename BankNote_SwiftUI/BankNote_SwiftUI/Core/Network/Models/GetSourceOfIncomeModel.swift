//
//  GetSourceOfIncomeModel.swift
//  mahfazati
//
//  Created by FIT on 09/11/2024.
//  Copyright © 2024 Mohammed Mathkour. All rights reserved.
//

import Foundation

struct GetSourceOfIncomeRequestModel: Codable {
    var FormType: String?
    var Lang: String?
}

struct GetSourceOfIncomeResponseModel: Codable {
    var ErrorMsg: String?
    var Lang: String?
    var resData: [GetSourceOfIncomeResData]?
}

struct GetSourceOfIncomeResData: Codable {
    var SourceOfIncome: String?
    var value: String?
}
