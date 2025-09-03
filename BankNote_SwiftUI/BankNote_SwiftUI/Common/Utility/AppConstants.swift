//
//  AppConstants.swift
//  QSC
//
//  Created by FIT on 22/07/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation
import FlagAndCountryCode
struct AppConstants {
    static var appName: String {
        return "QSC"
    }

    static let idleUserExpirationDurationInSecond = 60 * 60 // one hour
    static let defaultNAfathOTPTimesInSecond = 180
    static let defaultTimesInSecond = 60
    static let emptyValue = "--"
    //    static let countDownTimeDuration = 60 * 3
    static let searchTriggerDigit = 3
    static let appleLanguages = "AppleLanguages"
    static let starts = "****"
    static let defaultSaudiCountry =  CountryFlagInfo(code: "", name: "Saudi Arabia", dialCode: "+966", languageNative: "", languageEnglish: "")
    static let defaultEgyptCountry =  CountryFlagInfo(code: "EG", name: "Egypt", dialCode: "+20", languageNative: "العربية", languageEnglish: "Arabic")
    static let LOOKUP_VALIDITY_DATE = "TIF"
    static let LOOKUP_EXECUTION_RULE = "EXT"
    static let LOOKUP_ORDER_TYPE = "OPT"
    static let ITEM_SPINNER = ["T+0", "T+1", "T+2"]
    static let TYPE_ADD = "1"
}
