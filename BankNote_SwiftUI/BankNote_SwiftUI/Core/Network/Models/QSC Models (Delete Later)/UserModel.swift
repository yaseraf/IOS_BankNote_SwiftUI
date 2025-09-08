//
//  UserModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 30/07/2025.
//

import Foundation

struct UserRequestModel: Codable {
    
}

struct UserResponseModel: Codable {
    let userID: String?
    let nameEn: String?
    let nameAr: String?
    let purchasingPower: Double?
    let purchasingValue: Double?
    let commission: Double?
    let totalValue: Double?
}

struct UserUIModel {
    var userID: String?
    var nameEn: String?
    var nameAr: String?
    var purchasingPower: Double?
    var purchasingValue: Double?
    var commission: Double?
    var totalValue: Double?
    
    static func mapToUIModel(_ model: UserResponseModel) -> Self {
        return UserUIModel(userID: model.userID, nameEn: model.nameEn, nameAr: model.nameAr, purchasingPower: model.purchasingPower, purchasingValue: model.purchasingValue, commission: model.commission, totalValue: model.totalValue)
    }
    
    static func initializer() -> Self {
        return UserUIModel()
    }
}
