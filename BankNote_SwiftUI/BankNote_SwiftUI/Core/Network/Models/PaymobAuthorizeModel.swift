//
//  PaymobAuthorizeModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 02/03/2026.
//

import Foundation

struct PaymobAuthorizeRequestModel: Codable {
    let ApiKey: String?
    let Signature: String?
    let Payload: String?
}

struct PaymobAuthorizeResponseModel: Codable {
    let AuthToken: String?
    let ResponseCode: String?
    let ResponseMessage: String?
}

struct PaymobAuthorizeUIModel {
    var AuthToken: String?
    var ResponseCode: String?
    var ResponseMessage: String?
    
    static func mapToUIModel(m: PaymobAuthorizeResponseModel) -> Self {
        return PaymobAuthorizeUIModel(AuthToken: m.AuthToken, ResponseCode: m.ResponseCode, ResponseMessage: m.ResponseMessage)
    }
    
    static func initializer() -> Self {
        return PaymobAuthorizeUIModel()
    }
}

