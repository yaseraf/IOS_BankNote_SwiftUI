//
//  GetBankNotesBadgesModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 26/02/2026.
//

import Foundation

struct GetBankNotesBadgesRequestModel: Codable {
    let WebCode: String
}

struct GetBankNotesBadgesResponseModel: Codable {
    let Error_Msg: String?
    let Error_code: String?
    let ResData: [GetBankNotesBadgesDataModel]?
}

struct GetBankNotesBadgesDataModel: Codable {
    let BANKNOTES: String?
    let CODE: String?
    let NAME_E: String?
    let UPD_TIME: String?
    let USR_CODE: String?
}

struct GetBankNotesBadgesUIModel {
    var data: [GetBankNotesBadgesItemUIModel]?
    var errorMsg: String?
    var errorCode: String?
    
    static func mapToUIModel(_ model: GetBankNotesBadgesResponseModel) -> Self {
        return GetBankNotesBadgesUIModel(
            data: model.ResData?.map { GetBankNotesBadgesItemUIModel.map($0) },
            errorMsg: model.Error_Msg,
            errorCode: model.Error_code
        )
    }
    
    static func initializer() -> Self {
        return GetBankNotesBadgesUIModel()
    }
}

struct GetBankNotesBadgesItemUIModel {
    var banknotes: String?
    var code: String?
    var nameEnglish: String?
    var updateTime: String?
    var userCode: String?
    
    static func map(_ model: GetBankNotesBadgesDataModel) -> Self {
        return GetBankNotesBadgesItemUIModel(
            banknotes: model.BANKNOTES,
            code: model.CODE,
            nameEnglish: model.NAME_E,
            updateTime: model.UPD_TIME,
            userCode: model.USR_CODE
        )
    }
}
