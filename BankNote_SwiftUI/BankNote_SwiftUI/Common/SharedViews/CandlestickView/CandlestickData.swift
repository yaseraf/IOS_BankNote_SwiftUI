//
//  CandlestickData.swift
//  QSC
//
//  Created by FIT on 26/08/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation
struct CandlestickData:Identifiable {
    var id:String = UUID().uuidString
    let open: Double
    let close: Double
    let high: Double
    let low: Double
    let date: String // Added for date labels
}
