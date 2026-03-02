//
//  GetClientTransActionsPackagesModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 26/02/2026.
//

import Foundation

struct GetClientTransactionsPackagesRequestModel: Codable {
    let ClientID: String
    let MainClientID: String
    let WebCode: String
}

struct GetClientTransactionsPackagesResponseModel: Codable {
    let BALANCE: String?
    let Error_Msg: String?
    let Error_code: String?
}

struct GetClientTransactionsPackagesUIModel {
    var balance: String?
    var errorMsg: String?
    var errorCode: String?
    
    static func mapToUIModel(_ model: GetClientTransactionsPackagesResponseModel) -> Self {
        return GetClientTransactionsPackagesUIModel(
            balance: model.BALANCE,
            errorMsg: model.Error_Msg,
            errorCode: model.Error_code
        )
    }
    
    static func initializer() -> Self {
        return GetClientTransactionsPackagesUIModel()
    }
}
