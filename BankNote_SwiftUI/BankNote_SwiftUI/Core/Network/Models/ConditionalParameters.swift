//
//  ConditionalParameters.swift
//  mahfazati
//
//  Created by FIT on 27/10/2024.
//  Copyright © 2024 Mohammed Mathkour. All rights reserved.
//

import Foundation

struct ConditionalParameters: Codable {
    var orderID: String?
    var itemNumber: Int?
    var field: String?
    var criteria: String?
    var alertValue: Double?
}
