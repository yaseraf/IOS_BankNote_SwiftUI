//
//  GetInvesObjectiveModel.swift
//  mahfazati
//
//  Created by FIT on 09/11/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation

struct GetInvestObjectiveRequestModel: Codable {
    var FormType: String?
    var Lang: String?
}

struct GetInvestObjectiveResponseModel: Codable {
    var ErrorMsg: String?
    var Lang: String?
    var resData: [GetInvestObjectiveResData]?
}

struct GetInvestObjectiveResData: Codable {
    var Objective: String?
    var value: String?
}
