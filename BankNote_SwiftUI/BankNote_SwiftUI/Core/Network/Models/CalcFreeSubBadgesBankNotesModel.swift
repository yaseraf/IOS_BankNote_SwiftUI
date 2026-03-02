//
//  CalcFreeSubBadgesBankNotesModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 26/02/2026.
//

import Foundation

struct CalcFreeSubBadgesBankNotesRequestModel: Codable {
    let ClientID: String
    let Code: String
    let MainClientID: String
    let WebCode: String
}

struct CalcFreeSubBadgesBankNotesResponseModel: Codable {
    let Error_Msg: String?
    let Error_code: String?
}

struct CalcFreeSubBadgesBankNotesUIModel {
    var errorMsg: String?
    var errorCode: String?
    
    static func mapToUIModel(_ model: CalcFreeSubBadgesBankNotesResponseModel) -> Self {
        return CalcFreeSubBadgesBankNotesUIModel(
            errorMsg: model.Error_Msg,
            errorCode: model.Error_code
        )
    }
    
    static func initializer() -> Self {
        return CalcFreeSubBadgesBankNotesUIModel()
    }
}
