//
//  GetBankNoteModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 26/02/2026.
//

import Foundation

struct GetBankNoteRequestModel: Codable {
    let WebCode: String
}

struct GetBankNoteResponseModel: Codable {
    let Error_Msg: String?
    let Error_code: String?
    let ResData: [GetBankNoteDataModel]?
}

struct GetBankNoteDataModel: Codable {
    let BANKNOTEQTY: String?
    let CODE: String?
    let NAME: String?
    let NOTES: String?
    let PRICE: String?
    let UPD_TIME: String?
    let USR_CODE: String?
}

struct GetBankNoteUIModel {
    var data: [GetBankNoteItemUIModel]?
    var errorMsg: String?
    var errorCode: String?
    
    static func mapToUIModel(_ model: GetBankNoteResponseModel) -> Self {
        return GetBankNoteUIModel(
            data: model.ResData?.map { GetBankNoteItemUIModel.map($0) },
            errorMsg: model.Error_Msg,
            errorCode: model.Error_code
        )
    }
    
    static func initializer() -> Self {
        return GetBankNoteUIModel()
    }
}

struct GetBankNoteItemUIModel {
    var id = UUID().uuidString
    
    var bankNoteQty: String?
    var code: String?
    var name: String?
    var notes: String?
    var price: String?
    var updateTime: String?
    var userCode: String?
    
    static func map(_ model: GetBankNoteDataModel) -> Self {
        return GetBankNoteItemUIModel(
            bankNoteQty: model.BANKNOTEQTY,
            code: model.CODE,
            name: model.NAME,
            notes: model.NOTES,
            price: model.PRICE,
            updateTime: model.UPD_TIME,
            userCode: model.USR_CODE
        )
    }
}
