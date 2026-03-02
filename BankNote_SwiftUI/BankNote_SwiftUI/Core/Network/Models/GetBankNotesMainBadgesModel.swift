//
//  GetBankNotesMainBadgesModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 26/02/2026.
//

import Foundation

struct GetBankNotesMainBadgesRequestModel: Codable {
    let WebCode: String
}

struct GetBankNotesMainBadgesResponseModel: Codable {
    let Error_Msg: String?
    let Error_code: String?
    let ResData: [GetBankNotesMainBadgesDataModel]?
}

struct GetBankNotesMainBadgesDataModel: Codable {
    let BANKNOTES: String?
    let BRONZE: String?
    let BRONZE_IMAGE_TYPE: String?
    let CODE: String?
    let DIAMOND: String?
    let DIAMOND_IMAGE_TYPE: String?
    let GOLD: String?
    let GOLD_IMAGE_TYPE: String?
    let ICON: String?
    let ICON_IMAGE_TYPE: String?
    let NAME_E: String?
    let NOTES: String?
    let PLATINUM: String?
    let PLATINUM_IMAGE_TYPE: String?
    let SILVER: String?
    let SILVER_IMAGE_TYPE: String?
    let UPD_TIME: String?
    let USR_CODE: String?
}

struct GetBankNotesMainBadgesUIModel {
    var data: [GetBankNotesMainBadgesItemUIModel]?
    var errorMsg: String?
    var errorCode: String?
    
    static func mapToUIModel(_ model: GetBankNotesMainBadgesResponseModel) -> Self {
        return GetBankNotesMainBadgesUIModel(
            data: model.ResData?.map { GetBankNotesMainBadgesItemUIModel.map($0) },
            errorMsg: model.Error_Msg,
            errorCode: model.Error_code
        )
    }
    
    static func initializer() -> Self {
        return GetBankNotesMainBadgesUIModel()
    }
}

struct GetBankNotesMainBadgesItemUIModel {
    var banknotes: String?
    var bronze: String?
    var bronzeImageType: String?
    var code: String?
    var diamond: String?
    var diamondImageType: String?
    var gold: String?
    var goldImageType: String?
    var icon: String?
    var iconImageType: String?
    var nameEnglish: String?
    var notes: String?
    var platinum: String?
    var platinumImageType: String?
    var silver: String?
    var silverImageType: String?
    var updateTime: String?
    var userCode: String?
    
    static func map(_ model: GetBankNotesMainBadgesDataModel) -> Self {
        return GetBankNotesMainBadgesItemUIModel(
            banknotes: model.BANKNOTES,
            bronze: model.BRONZE,
            bronzeImageType: model.BRONZE_IMAGE_TYPE,
            code: model.CODE,
            diamond: model.DIAMOND,
            diamondImageType: model.DIAMOND_IMAGE_TYPE,
            gold: model.GOLD,
            goldImageType: model.GOLD_IMAGE_TYPE,
            icon: model.ICON,
            iconImageType: model.ICON_IMAGE_TYPE,
            nameEnglish: model.NAME_E,
            notes: model.NOTES,
            platinum: model.PLATINUM,
            platinumImageType: model.PLATINUM_IMAGE_TYPE,
            silver: model.SILVER,
            silverImageType: model.SILVER_IMAGE_TYPE,
            updateTime: model.UPD_TIME,
            userCode: model.USR_CODE
        )
    }
}
