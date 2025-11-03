//
//  TopActivitiesModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 27/08/2025.
//

import Foundation

struct TopActivitiesResponseModel:Codable {
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

struct TopActivitiesUIModel:Codable {
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
    
    static func mapToUIModel(_ m:TopActivitiesResponseModel) -> Self? {
       
        return TopActivitiesUIModel(Exchange: m.Exchange, Symbol: m.Symbol, LastTradePrice: m.LastTradePrice, NetChange: m.NetChange, NetChangePerc: m.NetChangePerc, TotalVolume: m.TotalVolume, TotalValue: m.TotalValue, Executed: m.Executed, SymbolNameE: m.SymbolNameE, SymbolNameA: m.SymbolNameA, SectorNameE: m.SectorNameE, SectorNameA: m.SectorNameA, Curr_Code: m.Curr_Code, Low: m.Low, High: m.High)
    }
    static func testUIModel() -> Self {

        return TopActivitiesUIModel(Exchange: "", Symbol: "", LastTradePrice: "", NetChange: "", NetChangePerc: "", TotalVolume: "", TotalValue: "", Executed: "", SymbolNameE: "", SymbolNameA: "", SectorNameE: "", SectorNameA: "", Curr_Code: "", Low: "", High: "")
    }
}
