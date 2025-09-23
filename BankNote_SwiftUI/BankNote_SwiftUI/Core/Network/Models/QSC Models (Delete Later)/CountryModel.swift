//
//  CountryUIModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 05/08/2025.
//

import Foundation

struct CountryResponseModel: Codable {
    let countryName:String?
}

//struct CountryUIModel  {
//    var countryName: String?
//    
//    static func mapToUIModel(_ model: CountryResponseModel) -> Self {
//        return CountryUIModel(countryName: model.countryName)
//    }
//    
//    static func initializer() -> Self {
//        return CountryUIModel(countryName: "")
//    }
//}
