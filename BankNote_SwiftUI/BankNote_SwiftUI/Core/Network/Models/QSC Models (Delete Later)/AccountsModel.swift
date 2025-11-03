//
//  AccountsModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 05/08/2025.
//

import Foundation

struct AccountsRequestModel: Codable {
    
}

struct AccountsResponseModel: Codable {
    let logo: String?
    let accountNameE: String?
    let accountNameA: String?
    let swiftCode: String?
    let iban: String?
    let stateE: String?
    let stateA: String?
    let status: String?
}

struct AccountsUIModel: Codable {
    var logo: String?
    var accountNameE: String?
    var accountNameA: String?
    var swiftCode: String?
    var iban: String?
    var stateE: String?
    var stateA: String?
    var status: String?

    static func mapToUIModel(_ model: AccountsResponseModel) ->Self {
        return AccountsUIModel(logo: model.logo, accountNameE: model.accountNameE, accountNameA: model.accountNameA, swiftCode: model.swiftCode, iban: model.iban, stateE: model.stateE, stateA: model.stateA, status: model.status)
    }
    
    static func initializer() -> Self {
        return AccountsUIModel(logo: "", accountNameE: "", accountNameA: "", swiftCode: "", iban: "", stateE: "", stateA: "", status: "")
    }
}
