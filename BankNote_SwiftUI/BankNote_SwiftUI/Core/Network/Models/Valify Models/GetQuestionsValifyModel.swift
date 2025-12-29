//
//  GetQuestionsValifyModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 11/11/2025.
//

import Foundation

struct GetQuestionsValifyRequestModel: Codable {
    let reqID: String
    
    enum CodingKeys: String, CodingKey {
        case reqID = "reqID"
    }
}

struct GetQuestionsValifyResponseModel: Codable {
    let questions: [QuestionsModel]
    
    enum CodingKeys: String, CodingKey {
        case questions = "questions"
    }
}

struct QuestionsModel: Codable {
    let id: String
    let ar: String
    let en: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case ar = "ar"
        case en = "en"
    }

}

struct GetQuestionsValifyUIModel {
    var questions: [QuestionsModel]?

    static func mapToUIModel(_ model: GetQuestionsValifyResponseModel) -> Self {
        return GetQuestionsValifyUIModel(
            questions: model.questions,
        )
    }
    
    static func initializer() -> Self {
        return GetQuestionsValifyUIModel()
    }
}
