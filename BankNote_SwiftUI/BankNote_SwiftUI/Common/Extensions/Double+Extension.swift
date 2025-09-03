//
//  Double+Extension.swift
//  QSC
//
//  Created by FIT on 17/08/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation
extension Double{
    var format2Fraction:String{
        let formattedDouble = String(format: "%.2f", locale: AppUtility.shared.englishLocal, Double(self))
        return formattedDouble
    } 
    var format3Fraction:String{
        let formattedDouble = String(format: "%.3f", locale: AppUtility.shared.englishLocal, Double(self))
        return formattedDouble
    }
}
