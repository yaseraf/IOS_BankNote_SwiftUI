//
//  GetFrontBackValifiyModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 30/10/2025.
//

import Foundation

struct GetFrontBackValifiyRequestModel: Codable {
    let IdBackBase64: String?
    let IdFrontBase64: String?
    let reqID: String?
}

struct GetFrontBackValifiyResponseModel: Codable {
    let ErrorMsg: String?
    let IsSuccessful: Bool?
    let Message: String?
    let reqID: String?
}

struct GetFrontBackValifiyUIModel {
    var ErrorMsg: String?
    var IsSuccessful: Bool?
    var Message: String?
    var reqID: String?
    
    static func mapToUIModel(_ model: GetFrontBackValifiyResponseModel) -> Self {
        return GetFrontBackValifiyUIModel(ErrorMsg: model.ErrorMsg, IsSuccessful: model.IsSuccessful, Message: model.Message, reqID: model.reqID)
    }
}
