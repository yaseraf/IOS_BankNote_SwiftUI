//
//  ExchangeModel.swift
//  QSC
//
//  Created by FIT on 01/08/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation
 struct ExchangeResponseModel: Decodable {
     
     var exchangeID:String

     var currentValue, exchangeNameE, exchangeNameA: String
    var volume, turnOver, totalExecuted, netChange: String
    var netChangePerc, statusCode, symbolsTraded, symbolsUP: String
    var symbolsDown, symbolsUnChange, lastUpdateTime: String
    var avg5Days: [String]

    enum CodingKeys: String, CodingKey {
        case exchangeID = "ExchangeID"
        case currentValue = "CurrentValue"
        case exchangeNameE = "ExchangeNameE"
        case exchangeNameA = "ExchangeNameA"
        case volume = "Volume"
        case turnOver = "TurnOver"
        case totalExecuted = "TotalExecuted"
        case netChange = "NetChange"
        case netChangePerc = "NetChangePerc"
        case statusCode = "StatusCode"
        case symbolsTraded = "SymbolsTraded"
        case symbolsUP = "SymbolsUP"
        case symbolsDown = "SymbolsDown"
        case symbolsUnChange = "SymbolsUnChange"
        case lastUpdateTime = "LastUpdateTime"
        case avg5Days = "Avg5days"
    }
}

extension ExchangeResponseModel{
    static func mapToUIModle(){

    }
}

