//
//  MarketUIModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 18/09/2025.
//

import Foundation

struct GetAllProfilesLookupsByUserCodeRequestModel {
    
}

struct GetAllProfilesLookupsByUserCodeResponseModel: Codable {
    let isDefault, bgName, profileType, profileID, profileName: String?
    let profileSettings, stockCount, userCode, Symbols: String?

        enum CodingKeys: String, CodingKey {
            case isDefault = "Is_Default"
            case bgName = "BG_NAME"
            case profileType = "PROFILE_TYPE"
            case profileID = "ProfileID"
            case profileName = "ProfileName"
            case profileSettings = "ProfileSettings"
            case stockCount = "STOCK_COUNT"
            case userCode = "UserCode"
            case Symbols = "SYMBOLS"
        }
}


struct GetAllProfilesLookupsByUserCodeUIModel {
    var isDefault, bgName, profileType, profileID, profileName: String?
    var profileSettings, stockCount, userCode: String?
    var Symbols: String?
    
    static func mapToUIModel(_ model:GetAllProfilesLookupsByUserCodeResponseModel)->Self {
        return  GetAllProfilesLookupsByUserCodeUIModel(isDefault: model.isDefault ?? "", bgName: model.bgName ?? "", profileType: model.profileType ?? "", profileID: model.profileID ?? "", profileName: model.profileName ?? "", profileSettings: model.profileSettings ?? "", stockCount: model.stockCount ?? "", userCode: model.userCode ?? "", Symbols: model.Symbols ?? "")
    }
    
    static func initializer() -> Self {
        return GetAllProfilesLookupsByUserCodeUIModel()
    }
}
