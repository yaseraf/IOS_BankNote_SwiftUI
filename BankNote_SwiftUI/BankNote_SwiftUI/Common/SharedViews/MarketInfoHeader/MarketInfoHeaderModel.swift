//
//  MarketInfoHeaderModel.swift
//  QSC
//
//  Created by FIT on 04/05/2025.
//  Copyright © 2025 FIT. All rights reserved.
//

import Foundation

struct MarketInfoHeaderModel: Codable {
    var id = UUID().uuidString
    let symbol: String?
    let lastTradePrice: String?
    let netChangePerc: String?
}
