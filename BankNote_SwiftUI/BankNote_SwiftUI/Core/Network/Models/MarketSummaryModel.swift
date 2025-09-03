//
//  MarketSummaryModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 12/08/2025.
//

import Foundation

struct MarketSummaryRequestModel: Codable {
    
}

struct MarketSummaryResponseModel: Codable {
    let companyNameEn: String?
    let companyNameAr: String?
    let value: Double?
    let change: Double?
    let changePerc: Double?
}

struct MarketSummaryUIModel {
    var companyNameEn: String?
    var companyNameAr: String?
    var value: Double?
    var change: Double?
    var changePerc: Double?
    
    static func mapToUIModel (_ model: MarketSummaryResponseModel) -> Self {
        return MarketSummaryUIModel(companyNameEn: model.companyNameEn, companyNameAr: model.companyNameAr, value: model.value, change: model.change, changePerc: model.changePerc)
    }
    
    static func initializer() -> Self {
        return MarketSummaryUIModel()
    }
}
