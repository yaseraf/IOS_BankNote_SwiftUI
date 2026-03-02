//
//  UpdateBankNotesTransQTYModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 26/02/2026.
//

import Foundation

struct UpdateBankNotesTransQTYRequestModel: Codable {
    let ClientID: String
    let DOC_NO: String
    let MainClientID: String
    let PORDER_ID: String
    let QTY: String
    let Source: String
    let TRANSTYPE: String
    let WebCode: String
}

struct UpdateBankNotesTransQTYResponseModel: Codable {
    let Error_Msg: String?
    let Error_code: String?
}

struct UpdateBankNotesTransQTYUIModel {
    var errorMsg: String?
    var errorCode: String?
    
    static func mapToUIModel(_ model: UpdateBankNotesTransQTYResponseModel) -> Self {
        return UpdateBankNotesTransQTYUIModel(
            errorMsg: model.Error_Msg,
            errorCode: model.Error_code
        )
    }
    
    static func initializer() -> Self {
        return UpdateBankNotesTransQTYUIModel()
    }
}
