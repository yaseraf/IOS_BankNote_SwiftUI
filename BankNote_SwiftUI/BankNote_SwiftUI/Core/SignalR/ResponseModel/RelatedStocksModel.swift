//
//  RelatedStocksModel.swift
//  QSC
//
//  Created by FIT on 26/12/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation

struct RelatedStocksRequestModel: Codable {
    
}

struct RelatedStocksResponseModel: Codable {
    let Exchange, Symbol, LastTradePrice, NetChange, NetChangePerc: String?
    let TotalVolume, TotalValue, Executed, SymbolNameE, SymbolNameA, SectorNameE, SectorNameA, Curr_Code: String?
}

struct RelatedStocksUIModel:Codable {
    let Exchange, Symbol, LastTradePrice, NetChange, NetChangePerc: String?
    let TotalVolume, TotalValue, Executed, SymbolNameE, SymbolNameA, SectorNameE, SectorNameA, Curr_Code: String?
}

extension RelatedStocksUIModel {
    static func mapToUIModel(_ m:RelatedStocksResponseModel)->Self {
        return  RelatedStocksUIModel(Exchange: m.Exchange, Symbol: m.Symbol, LastTradePrice: m.LastTradePrice, NetChange: m.NetChange, NetChangePerc: m.NetChangePerc, TotalVolume: m.TotalVolume, TotalValue: m.TotalValue, Executed: m.Executed, SymbolNameE: m.SymbolNameE, SymbolNameA: m.SymbolNameA, SectorNameE: m.SectorNameE, SectorNameA: m.SectorNameA, Curr_Code: m.Curr_Code)
    }
    
    static func testUIModel() -> Self {
        return RelatedStocksUIModel(Exchange: "", Symbol: "", LastTradePrice: "", NetChange: "", NetChangePerc: "", TotalVolume: "", TotalValue: "", Executed: "", SymbolNameE: "", SymbolNameA: "", SectorNameE: "", SectorNameA: "", Curr_Code: "")
    }
}


