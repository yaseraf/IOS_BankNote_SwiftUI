//
//  BankModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 04/08/2025.
//

import Foundation

struct BankRequestModel: Codable {
    
}

struct BankResponseModel: Codable {
    let bankNumber: String?
}

struct BankUIModel {
    var bankNumber: String?
    
    static func mapToUIModel(_ response: BankResponseModel) -> BankUIModel {
        return BankUIModel(bankNumber: response.bankNumber)
    }
    
    static func testUIModel() -> BankUIModel {
        return BankUIModel(bankNumber: "")
    }
}
