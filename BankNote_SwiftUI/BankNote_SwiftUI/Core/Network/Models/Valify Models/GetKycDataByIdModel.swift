//
//  GetKycDataByIdModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 22/02/2026.
//

import Foundation

struct GetKYCDataByIDRequestModel: Codable {
    let IDs: String
    let USER_ID: String
    let req_ID: String
}

struct GetKYCDataByIDResponseModel: Codable {
    let Error_Msg: String?
    let Error_code: String?
    let ResData: [GetKYCResData]?

}

struct GetKYCResData: Codable {
    let ID: String
    let IS_MANDATORY: String
    let STAGE: String
    let VALUE: String
}

struct GetKYCDataByIDUIModel:Codable {
    var errorMsg: String?
    var errorCode: String?
    var resData: [GetKYCResData]?
    
    static func mapToUIModel(_ model: GetKYCDataByIDResponseModel) -> Self {
        return GetKYCDataByIDUIModel(errorMsg: model.Error_code, errorCode: model.Error_Msg, resData: model.ResData)
    }
    
    static func initializer() -> Self {
        return GetKYCDataByIDUIModel()
    }
}
