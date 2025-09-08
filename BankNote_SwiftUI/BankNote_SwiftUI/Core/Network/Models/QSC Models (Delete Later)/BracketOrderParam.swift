//
//  BracketOrderParam.swift
//  mahfazati
//
//  Created by FIT on 27/10/2024.
//  Copyright © 2024 Mohammed Mathkour. All rights reserved.
//

import Foundation

struct BracketOrderParam: Codable {
    var ReferencePrice: String?
    var isStopLoss: Bool?
    var StopLossValue: Int?
    var StopLossValueType: String?
    var isTakeProfit: Bool?
    var TakeProfitValue: Int?
    var TakeProfitValueType: String?
}
