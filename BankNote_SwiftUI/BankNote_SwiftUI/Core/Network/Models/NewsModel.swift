//
//  NewsModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 30/07/2025.
//

import Foundation

struct NewsRequestModel: Codable {
    
}

struct NewsResponseModel: Codable {
    let dateEn: String?
    let dateAr: String?
    let descEn: String?
    let descAr: String?
    let detailsEn: String?
    let detailsAr: String?
}

struct NewsUIModel: Codable {
    var dateEn: String?
    var dateAr: String?
    var descEn: String?
    var descAr: String?
    var detailsEn: String?
    var detailsAr: String?
    
    static func mapToUIModel(_ model:NewsResponseModel) -> Self {
        return NewsUIModel(dateEn: model.dateEn, dateAr: model.dateAr, descEn: model.descEn, descAr: model.descAr, detailsEn: model.detailsEn, detailsAr: model.detailsAr)
    }
    
    static func initializer() -> Self {
        return NewsUIModel(dateEn: "", dateAr: "", descEn: "", descAr: "", detailsEn: "", detailsAr: "")
    }
}
