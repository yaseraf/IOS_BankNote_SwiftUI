//
//  GetClinetBankNotesModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 26/02/2026.
//

import Foundation

struct GetClientBankNotesRequestModel: Codable {
    let ClientID: String
    let MainClientID: String
    let WebCode: String
}

struct GetClientBankNotesResponseModel: Codable {
    let BALANCE: String?
    let Error_Msg: String?
    let Error_code: String?
}

struct GetClientBankNotesUIModel {
    var balance: String?
    var errorMsg: String?
    var errorCode: String?
    
    static func mapToUIModel(_ model: GetClientBankNotesResponseModel) -> Self {
        return GetClientBankNotesUIModel(
            balance: model.BALANCE,
            errorMsg: model.Error_Msg,
            errorCode: model.Error_code
        )
    }
    
    static func initializer() -> Self {
        return GetClientBankNotesUIModel()
    }
}
