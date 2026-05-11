//
//  DeleteMarketWatchProfileSymbolsModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 05/05/2026.
//

import Foundation
struct DeleteMarketWatchProfileSymbolsRequestModel: Codable {
    let profileID: String?
       let symbols: [String]?
       let webCode: String?

       enum CodingKeys: String, CodingKey {
           case profileID = "ProfileID"
           case symbols = "Symbols"
           case webCode = "WebCode"
       }
}

struct DeleteMarketWatchProfileSymbolsResponseModel: Codable {
    
}

struct DeleteMarketWatchProfileSymbolsUIModel{
}

extension DeleteMarketWatchProfileSymbolsUIModel {
    static func mapToUIModel(_ model:DeleteMarketWatchProfileSymbolsResponseModel)->Self {
        return DeleteMarketWatchProfileSymbolsUIModel()
    }
}
