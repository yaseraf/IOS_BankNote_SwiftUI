//
//  Untitled.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 05/05/2026.
//

import Foundation
struct AddMarketWatchProfileNameRequestModel: Codable {
    
}

struct AddMarketWatchProfileNameResponseModel: Codable {
    let isDefault, profileType, profileID, profileName: String?
        let profileSettings, stockCount, userCode: String?

        enum CodingKeys: String, CodingKey {
            case isDefault = "Is_Default"
            case profileType = "PROFILE_TYPE"
            case profileID = "ProfileID"
            case profileName = "ProfileName"
            case profileSettings = "ProfileSettings"
            case stockCount = "STOCK_COUNT"
            case userCode = "UserCode"
        }
}

struct AddMarketWatchProfileNameUIModel {
    var isDefault, profileType, profileID, profileName: String?
    var profileSettings, stockCount, userCode: String?
}

extension AddMarketWatchProfileNameUIModel {
    static func mapToUIModel(_ model:AddMarketWatchProfileNameResponseModel)->Self {
        return  AddMarketWatchProfileNameUIModel(isDefault: model.isDefault ?? "", profileType: model.profileType ?? "", profileID: model.profileID ?? "", profileName: model.profileName ?? "", profileSettings: model.profileSettings ?? "", stockCount: model.stockCount ?? "", userCode: model.userCode ?? "")
    }
    
    static func initializer() -> Self {
        return AddMarketWatchProfileNameUIModel()
    }
}
