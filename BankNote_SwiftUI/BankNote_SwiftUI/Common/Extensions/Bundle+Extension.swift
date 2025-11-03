//
//  Bundle+Extension.swift
//  QSC_SwiftUI
//
//  Created by FIT on 21/08/2025.
//

import Foundation

extension Bundle {
    var getVersionNumber: Double? {
        let ver = infoDictionary?["CFBundleShortVersionString"] as? String
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: "EN")
        let number = numberFormatter.number(from: ver!)
        let verNb = number?.doubleValue
        return verNb
    }
    
    var appDisplayName: String {
        return (object(forInfoDictionaryKey: "CFBundleDisplayName") as? String) ?? ""
    }
    
    var getBundleNumber: Double? {
        let ver = infoDictionary?["CFBundleVersion"] as? String
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: "EN")
        let number = numberFormatter.number(from: ver!)
        let verNb = number?.doubleValue
        return verNb
    }
    
}
