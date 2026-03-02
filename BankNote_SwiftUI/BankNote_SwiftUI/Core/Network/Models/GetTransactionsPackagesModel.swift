//
//  GetTransactionsPackagesModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 26/02/2026.
//

import Foundation

struct GetTransactionsPackagesRequestModel: Codable {
    let WebCode: String
}

struct GetTransactionsPackagesResponseModel: Codable {
    let Error_Msg: String?
    let Error_code: String?
    let ResData: [GetTransactionsPackagesDataModel]?
}

struct GetTransactionsPackagesDataModel: Codable {
    let CODE: String?
    let NAME_E: String?
    let NOTES: String?
    let PRICE_BY_BANKNOTES: String?
    let TRANSACTIONS_QTY: String?
    let UPD_TIME: String?
    let USR_CODE: String?
}

struct GetTransactionsPackagesUIModel {
    var data: [GetTransactionsPackagesItemUIModel]?
    var errorMsg: String?
    var errorCode: String?
    
    static func mapToUIModel(_ model: GetTransactionsPackagesResponseModel) -> Self {
        return GetTransactionsPackagesUIModel(
            data: model.ResData?.map { GetTransactionsPackagesItemUIModel.map($0) },
            errorMsg: model.Error_Msg,
            errorCode: model.Error_code
        )
    }
    
    static func initializer() -> Self {
        return GetTransactionsPackagesUIModel()
    }
}

struct GetTransactionsPackagesItemUIModel {
    var id = UUID().uuidString

    var code: String?
    var nameEnglish: String?
    var notes: String?
    var priceByBanknotes: String?
    var transactionsQty: String?
    var updateTime: String?
    var userCode: String?
    
    static func map(_ model: GetTransactionsPackagesDataModel) -> Self {
        return GetTransactionsPackagesItemUIModel(
            code: model.CODE,
            nameEnglish: model.NAME_E,
            notes: model.NOTES,
            priceByBanknotes: model.PRICE_BY_BANKNOTES,
            transactionsQty: model.TRANSACTIONS_QTY,
            updateTime: model.UPD_TIME,
            userCode: model.USR_CODE
        )
    }
}
