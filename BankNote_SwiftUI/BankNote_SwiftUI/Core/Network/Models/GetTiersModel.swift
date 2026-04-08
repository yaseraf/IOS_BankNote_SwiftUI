//
//  GetTiersModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 26/02/2026.
//

import Foundation

struct GetTiersRequestModel: Codable {
    let WebCode: String
}

struct GetTiersResponseModel: Decodable {
    let Error_Msg: String?
    let Error_code: String?
    let ResData: [GetTiersDataModel]?
}

struct GetTiersDataModel: Codable {
    let AGE: String?
    let A_DESC: String?
    let BANKNOTES_QTY: String?
    let CODE: String?
    let E_DESC: String?
    let NAV: String?
    let NOTES: String?
    let REVENUE_PER_MONTH: String?
    let UPD_TIME: String?
    let USR_CODE: String?
    let ALLOW_MARGIN: String?
}

struct GetTiersUIModel {
    var data: [GetTiersItemUIModel]?
    var errorMsg: String?
    var errorCode: String?
    
    static func mapToUIModel(_ model: GetTiersResponseModel) -> Self {
        return GetTiersUIModel(
            data: model.ResData?.map { GetTiersItemUIModel.map($0) },
            errorMsg: model.Error_Msg,
            errorCode: model.Error_code
        )
    }
    
    static func initializer() -> Self {
        return GetTiersUIModel()
    }
}

struct GetTiersItemUIModel {
    var id = UUID().uuidString

    var age: String?
    var arabicDescription: String?
    var banknotesQty: String?
    var code: String?
    var englishDescription: String?
    var nav: String?
    var notes: String?
    var revenuePerMonth: String?
    var updateTime: String?
    var userCode: String?
    var ALLOW_MARGIN: String?
    
    static func map(_ model: GetTiersDataModel) -> Self {
        return GetTiersItemUIModel(
            age: model.AGE,
            arabicDescription: model.A_DESC,
            banknotesQty: model.BANKNOTES_QTY,
            code: model.CODE,
            englishDescription: model.E_DESC,
            nav: model.NAV,
            notes: model.NOTES,
            revenuePerMonth: model.REVENUE_PER_MONTH,
            updateTime: model.UPD_TIME,
            userCode: model.USR_CODE,
            ALLOW_MARGIN: model.ALLOW_MARGIN
        )
    }
}
