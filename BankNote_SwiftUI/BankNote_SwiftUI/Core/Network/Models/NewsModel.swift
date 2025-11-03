//
//  NewsModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 09/09/2025.
//

import Foundation

struct NewsResponseModel: Codable {
    let indexName: String?
    let time: String?
    let title: String?
    let desc: String?
}

struct NewsUIModel {
    var indexName: String?
    var time: String?
    var title: String?
    var desc: String?
    
    static func mapToUIModel(_ model: NewsResponseModel) -> Self {
        return NewsUIModel(indexName: model.indexName, time: model.time, title: model.title, desc: model.desc)
    }
    
    static func initializer() -> Self {
        return NewsUIModel()
    }
}
