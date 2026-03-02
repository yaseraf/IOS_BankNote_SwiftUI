//
//  TransferAmountToAccountsModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 26/02/2026.
//

import Foundation

struct TransferAmountToAccountsRequestModel: Codable {
    let AccountID: String
    let Amount: String
    let CheckerNote: String
    let CheckerUser: String
    let JvDate: String
    let JvValueDate: String
    let MainClientID: String
    let MakerNote: String
    let MakerUser: String
    let WebCode: String
}

struct TransferAmountToAccountsResponseModel: Codable {
    let DOC_NO: String?
    let Error_Msg: String?
    let Error_code: String?
    let PRES: String?
    let TRANS_ID: String?
}

struct TransferAmountToAccountsUIModel {
    var docNo: String?
    var errorMsg: String?
    var errorCode: String?
    var pres: String?
    var transId: String?
    
    static func mapToUIModel(_ model: TransferAmountToAccountsResponseModel) -> Self {
        return TransferAmountToAccountsUIModel(
            docNo: model.DOC_NO,
            errorMsg: model.Error_Msg,
            errorCode: model.Error_code,
            pres: model.PRES,
            transId: model.TRANS_ID
        )
    }
    
    static func initializer() -> Self {
        return TransferAmountToAccountsUIModel()
    }
}
