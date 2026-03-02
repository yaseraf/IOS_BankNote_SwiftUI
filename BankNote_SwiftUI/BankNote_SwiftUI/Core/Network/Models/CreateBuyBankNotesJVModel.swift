//
//  CreateBuyBankNotesJVModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 26/02/2026.
//

import Foundation

struct CreateBuyBankNotesJVRequestModel: Codable {
    let Amount: String
    let BanknotesQTY: String
    let ClientID: String
    let MainClientID: String
    let WebCode: String
}

struct CreateBuyBankNotesJVResponseModel: Codable {
    let Error_Msg: String?
    let Error_code: String?
}

struct CreateBuyBankNotesJVUIModel {
    var errorMsg: String?
    var errorCode: String?
    
    static func mapToUIModel(_ model: CreateBuyBankNotesJVResponseModel) -> Self {
        return CreateBuyBankNotesJVUIModel(
            errorMsg: model.Error_Msg,
            errorCode: model.Error_code
        )
    }
    
    static func initializer() -> Self {
        return CreateBuyBankNotesJVUIModel()
    }
}
