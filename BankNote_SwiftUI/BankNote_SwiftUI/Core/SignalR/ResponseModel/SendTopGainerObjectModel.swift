//
//  SendTopGainerObjectModel.swift
//  QSC
//
//  Created by FIT on 20/11/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation

struct SendTopGainerObjectModel:Codable {
    
    var Exchange:String?
    var Symbol:String?
    var LastTradePrice:String?
    var NetChange:String?
    var NetChangePerc:String?
    var TotalVolume:String?
    var TotalValue:String?
    var Executed:String?
    var SymbolNameE:String?
    var SymbolNameA:String?
    var SectorNameE:String?
    var SectorNameA:String?
    var Curr_Code:String?
    var Low:String?
    var High:String?
}

struct SendTopGainerObjectUIModel:Codable {
    var id = UUID().uuidString
    var Exchange:String?
    var Symbol:String?
    var LastTradePrice:String?
    var NetChange:String?
    var NetChangePerc:String?
    var TotalVolume:String?
    var TotalValue:String?
    var Executed:String?
    var SymbolNameE:String?
    var SymbolNameA:String?
    var SectorNameE:String?
    var SectorNameA:String?
    var Curr_Code:String?
    var Low:String?
    var High:String?
}

extension SendTopGainerObjectUIModel{
    static func mapToUIModel(_ m:SendTopGainerObjectModel) -> Self? {
       
        return SendTopGainerObjectUIModel(Exchange: m.Exchange, Symbol: m.Symbol, LastTradePrice: m.LastTradePrice, NetChange: m.NetChange, NetChangePerc: m.NetChangePerc, TotalVolume: m.TotalVolume, TotalValue: m.TotalValue, Executed: m.Executed, SymbolNameE: m.SymbolNameE, SymbolNameA: m.SymbolNameA, SectorNameE: m.SectorNameE, SectorNameA: m.SectorNameA, Curr_Code: m.Curr_Code, Low: m.Low, High: m.High)
    }
    static func testUIModel() -> Self {

        return SendTopGainerObjectUIModel(Exchange: "", Symbol: "", LastTradePrice: "", NetChange: "", NetChangePerc: "", TotalVolume: "", TotalValue: "", Executed: "", SymbolNameE: "", SymbolNameA: "", SectorNameE: "", SectorNameA: "", Curr_Code: "", Low: "", High: "")
    }
}
