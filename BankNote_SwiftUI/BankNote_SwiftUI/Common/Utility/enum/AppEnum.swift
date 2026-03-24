//
//  AppEnum.swift
//  QSC
//
//  Created by FIT on 22/07/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation
import SwiftUI
enum LanguageType: String {
    case arabic = "ar"
    case english = "en"
    
    var text:String {
        self.rawValue.localized
    }

    var textShort:String {
       "\( self.rawValue)2".localized
    }
}
enum ThemeType: String,Codable {
    case light = "light"
    case dark = "dark"
    case system = "system_settings"

    var text:String {
        self.rawValue.localized
    }
}

enum CameraType: Codable {
    case front
    case back
}

enum loginState {
    static let success = 0
    static let invalidLogin = -1
    static let invalidTokenID = -2
    static let tokenSent = -3
    static let tokenExpire = -4
    static let noPermetions = -5
    static let userLocked = -6
    static let anotherUserLogin = -7
    static let userNotAgreeTermCondtion = -8
    static let unknowError = -10
}


enum AuthenticationViewType{
    case email
    case phoneNumber
}


enum ContainerViewType{
    case privacyPolicy
    case termsAndCondition

    var urlTemp:String{
        switch self {
        case .privacyPolicy:
            "privacyPolicy://"
        case .termsAndCondition:
            "termsAndCondition://"
        }
    }

    var titleValue:String{
        switch self {
        case .privacyPolicy:
            "privacy_policy".localized
        case .termsAndCondition:
            "terms_and_condition".localized
        }
    }

}

enum UserIDType{
    case nationalId
    case passport
    case none
}


enum SelectRadioType{
    case yes
    case no
    case none
}

enum OptionsType{
    case success
    case failed
    case none
}

enum LottieFileName:String {
    case scanId =  "scan_id"
    case selfie = "take_pic"
}

enum InvestType{
    case stocks
    case mutualFundsAndBonds
    case none
}

enum PasswordValidationType{
    case eightDigitCount
    case atLeastOneChar
    case atLeastOneNumber
    case atLeastOneSpecialCharacter
    case atLeastOneCapitalLetter

    var message:String{
        get{
            switch self {
            case .eightDigitCount:
                return "at_least_8_characters".localized
            case .atLeastOneChar:
                return "at_least_one_letter".localized
            case .atLeastOneNumber:
                return "at_least_one_number".localized
            case .atLeastOneSpecialCharacter:
                return "at_least_one_special_character".localized
            case .atLeastOneCapitalLetter:
                return "at_least_one_capital_letter".localized
            }
        }
    }

    var index:Int{
        get{
            switch self {
            case .eightDigitCount:
                return 0
            case .atLeastOneChar:
                return 1
            case .atLeastOneNumber:
                return 2
            case .atLeastOneSpecialCharacter:
                return 3
            case .atLeastOneCapitalLetter:
                return 4

            }
        }
    }
}
enum HomeTabBarItem: CaseIterable, Identifiable{
    case home
    case portfolio
    case trade
    case orders
    case settings
    
    var id: String { self.title }


    var title:String {
        get{
            switch self {
            case .home:
                "home".localized
            case .portfolio:
                "portfolio".localized
            case .trade:
                "trade".localized
            case .orders:
                "orders".localized
            case .settings:
                "settings".localized
            }
        }
    }
    var iconName:String {
        get{
            switch self {
            case .home:
                "ic_home".localized
            case .portfolio:
                "ic_portfolio".localized
            case .trade:
                "ic_trade".localized
            case .orders:
                "ic_orders".localized
            case .settings:
                "ic_settings".localized
            }

        }
    }

}
enum BackgroundType{
    case gradient
    case gradientPreviewOrder
    case white
    case colorBGSecondary
    case blackWithAlpha
    case clear
    case quaternary
}


enum TotalAssetsType:String{
    case normal = "N"
    case margin = "M"
    case sameDay = "SD"
    case multimarket = "MM"
    case all = "ALL"
}

enum TotalAssetsFilterType:String{
    case allTime

    var title:String{
        switch self {
        case .allTime:
            "all_time".localized
        }
    }
}
enum  MoneyTransactionType:String{
    case plus = "+"
    case minus = "-"

}
enum  PlaceOrderType{
    case buy
    case sell

    var text:String{
        get{
            switch self {
            case .buy:
                "buy".localized
            case .sell:
                "sell".localized

            }
        }
    }

    var color:Color{
        get{
            switch self {
            case .buy:
                Color.colorPrimary
            case .sell:
                Color.colorError

            }
        }
    }
}

enum  PlaceOrderPlaceItemVia{
    case amount
    case quantity
}

enum  ChooseOrderType{
    case marketOrder
    case limitOrder

    var text:String{
        switch self {
        case .marketOrder:
            "market_order".localized
        case .limitOrder:
            "limit_order".localized
        }
    }

    var subText:String{
        switch self {
        case .marketOrder:
            "market".localized
        case .limitOrder:
            "limit".localized
        }
    }

    var iconName:String{
        switch self {
        case .marketOrder:
            "ic_marketOrder"
        case .limitOrder:
            "ic_limitOrder"
        }
    }



}
enum  OrderStatusType{
    case fulfilled
    case waiting
    case rejected


    var text:String {
        switch self {
        case .fulfilled:
            "fulfilled".localized
        case .waiting:
            "waiting".localized
        case .rejected:
            "rejected".localized
        }
    }

    var foregroundColor:Color {
        switch self {
        case .fulfilled:
            Color.colorSuccess
        case .waiting:
            Color.colorWarning600
        case .rejected:
            Color.colorError
        }
    }

    var backgroundColor:Color {
        switch self {
        case .fulfilled:
            Color.colorSuccess50
        case .waiting:
            Color.colorWarning50
        case .rejected:
            Color.colorError50
        }
    }
}

  

enum  ChartChooseType: String{
    case lineChart = "mountain"
    case candlestickChart = "candles"

    var text:String{
        switch self {
        case .lineChart:
            "line_chart".localized
        case .candlestickChart:
            "candlestick_chart".localized
        }
    }



    var iconName:String{
        switch self {
        case .lineChart:
            "ic_lineChart"
        case .candlestickChart:
            "ic_candlestickChart"
        }
    }
}
enum  AddMoneyTransactionType{
    case debitCard
    case instancePay
    case bankDeposit
    case directDeposit


    var text:String{
        switch self {
        case .debitCard:
            "debit_card".localized
        case .instancePay:
            "instapay".localized
        case .bankDeposit:
            "bank_deposit".localized
        case .directDeposit:
            "direct_deposit".localized
        }
    }

}


//enum TransactionStatus{
//    case complete
//    case pending
//    case rejected
//    var text:String{
//        switch self{
//        case .complete:
//            return "complete".localized
//        case .pending:
//            return "pending".localized
//        case .rejected:
//            return "rejected".localized
//        }
//    }
//
//    var foregroundColor:Color {
//        switch self {
//        case .complete:
//            Color.colorSuccess
//        case .pending:
//            Color.colorWarning600  
//        case .rejected:
//            Color.colorError
//        }
//    }
//
//    var backgroundColor:Color {
//        switch self {
//        case .complete:
//            Color.colorSuccess50
//
//        case .pending:
//            Color.colorWarning50
//        case .rejected:
//            Color.colorError50
//        }
//    }
//}
enum  ConfirmDepositSourceType{
    case bankDeposit
    case Instapay
}

enum  BankInfoSourceType{
    case directDeposit
    case wireTransfer
    case instapay
    case bankDeposit

    var text:String{
        switch self {
        case .wireTransfer:
            "wire_transfer".localized
        case .directDeposit:
            "direct_deposit".localized
        case.instapay:
            "instapay".localized
        case.bankDeposit:
            "bankDeposit".localized
        }
        
    }
}



enum  SubscriptionOfStocksType:String{
    case ipo
    case capitalIncrease
    case capitalIncreaseNonCovered
    case orp

    var title:String{
        switch self {
        case .ipo:
            "ipo".localized
        case .capitalIncrease:
            "capital_increase".localized
        case .capitalIncreaseNonCovered:
            "capital_increase_non_covered".localized
        case .orp:
            "orp".localized
        }
    }

    var searchPlaceHolder:String{
        switch self {
        case .ipo:
            "search_ipo".localized
        case .capitalIncrease:
            "search_capital_increase".localized
        case .capitalIncreaseNonCovered:
            "search_capital_increase_non_covered".localized
        case .orp:
            "search_orp".localized
        }
    }

    var description:String{
        switch self {
        case .ipo:
            "ipo_description".localized
        case .capitalIncrease:
            "capital_increase_description".localized
        case .capitalIncreaseNonCovered:
            "capital_increase_non_covered_description".localized
        case .orp:
            "orp_description".localized
        }
    }

    var iconName:String{
        switch self {
        case .ipo:
           "oc_ipo"
        case .capitalIncrease:
            "ic_capital"
        case .capitalIncreaseNonCovered:
            "ic_nonCovered"
        case .orp:
            "ic_orp"
        }
    }
}

enum TransactionTypes {
    case none
    case topUp
    case withdrawal
    
    var name:String{
        switch self {
        case .none:
            ""
        case .topUp:
            "topUp".localized
        case .withdrawal:
            "withdrawal".localized
        }
    }
}

enum TransactionStatus {
    case none
    case approved
    case pending
    case underProcess
    case rejected
    
    var name: String {
        switch self {
        case .none:
            "none".localized
        case .approved:
            "approved".localized
        case .pending:
            "pending".localized
        case .underProcess:
            "under_process".localized
        case .rejected:
            "rejected".localized
        }
    }
}

enum TypeOfTrade {
    case buy
    case sell
    
    var name:String {
        switch self {
        case .buy:
            "buy".localized
        case .sell:
            "sell".localized
        }
    }
}

enum Network: String {
    case wifi = "en0"
    case cellular = "pdp_ip0"
    case ipv4 = "ipv4"
    case ipv6 = "ipv6"
}

enum ForgotDataEnum {
    case forgotPassword
    case forgotName
    case forgotPin
}

enum  PrintFormBankSourceType{
    case transferToOtherCustody
    case generalMeetingRequest

    var title:String{
        switch self {
        case .transferToOtherCustody:
            "transfer_to_other_custody".localized

        case .generalMeetingRequest:
            "general_meeting_request".localized
        }
    }

    var description:String{
        switch self {
        case .transferToOtherCustody:
            "transfer_to_other_custody_description".localized

        case .generalMeetingRequest:
            "general_meeting_request_description".localized
        }
    }
}
enum  ComplaintSuggestionSceneSourceType{
    case  complaint
    case suggestion

    var subTitle:String {
        switch self {
        case .complaint:
            "complaint".localized

        case .suggestion:
            "suggestion".localized
        }
    }
    var title:String{
        switch self {
        case .complaint:
            "complaint".localized

        case .suggestion:
            "suggestion".localized
        }
    }

    var description:String{
        switch self {
        case .complaint:
            "complaint_description".localized

        case .suggestion:
            "suggestion_description".localized
        }
    }
    var hint:String{
        switch self {
        case .complaint:
            "complaint_hint".localized

        case .suggestion:
            "suggestion_hint".localized
        }
    }

    var successMsg:String{
        switch self {
        case .complaint:
            "complaint_success".localized

        case .suggestion:
            "suggestion_success".localized
        }
    }


}

enum TermsAndPrivacySourceType{
    case  privacyPolicy
    case termsAndConditions

    var title:String{
        switch self {
        case .privacyPolicy:
            "privacy_policy".localized

        case .termsAndConditions:
            "terms_and_conditions".localized
        }
    }


}

enum tiers {
    case rookie
    case casual
    case pro
    case rollingStar
    case tycoon
    
    init?(code: String) {
        switch code {
            case "1": self = .rookie
            case "2": self = .casual
            case "3": self = .pro
            case "4": self = .rollingStar
            case "5": self = .tycoon
            default: return nil
        }
    }
    
    var tierImage: String {
        switch self {
            case .rookie:
                return "ic_rookie"
            case .casual:
                return "ic_casual"
            case .pro:
                return "ic_pro"
            case .rollingStar:
                return "ic_rollingStar"
            case .tycoon:
                return "ic_tycoon"
        }
    }
    
    var tierCode: String {
        switch self {
            case .rookie:
                return "1"
            case .casual:
                return "2"
            case .pro:
                return "3"
            case .rollingStar:
                return "4"
            case .tycoon:
                return "5"
        }
    }
}

//enum badges {
//    
//    case hustler
//    case socialButterfly
//    case baller
//    case boujee
//    case buzzer
//    case hunter
//    case bouncy
//    case smith
//    case wolf
//    case gambit
//    case pirate
//    
//    init?(code: String, mainBadgeCode: String, subBadgeCode: String) {
//        
//        let keys = mainBadgeCode.split(separator: ",").map { String($0)}
//        let values = subBadgeCode.split(separator: ",").map { String($0)}
//        
//        let badgesDictionary = Dictionary(uniqueKeysWithValues: zip(keys, values.prefix(keys.count)))
//        
//        let badgeCategory = badgesDictionary.filter({$0.key == code}).first?.value
//
//        switch code {
//            case "1": self = .hustler
//            case "2": self = .socialButterfly
//            case "3": self = .baller
//            case "4": self = .boujee
//            case "5": self = .buzzer
//            case "6": self = .hunter
//            case "7": self = .bouncy
//            case "8": self = .smith
//            case "9": self = .wolf
//            case "10": self = .gambit
//            case "11": self = .pirate
//            default: return nil
//        }
//    }
//    
//    func categorizeBadge(code: String, mainBadgeCode: String, subBadgeCode: String) -> badges {
//        // if sub badge == 1 this is bronze
//        // if sub badge == 2 this is silver
//        // if sub badge == 3 this is gold
//        // if sub badge == 4 this is plat
//        // if sub badge == 5 this is diamond
//        
//        
//    }
//    
//    var badgeImage: String {
//        switch self {
//            case .hustler: return "ic_hustler_disabled"
//            case .socialButterfly: return "ic_socialButterfly_disabled"
//            case .baller: return "ic_baller_disabled"
//            case .boujee: return "ic_boujee_disabled"
//            case .buzzer: return "ic_buzzer_disabled"
//            case .hunter: return "ic_hunter_disabled"
//            case .bouncy: return "ic_bouncy_disabled"
//            case .smith: return "ic_smith_disabled"
//            case .wolf: return "ic_wolf_disabled"
//            case .gambit: return "ic_gambit_disabled"
//            case .pirate: return "ic_pirate_disabled"
//        }
//    }
//    
//    var badgeImagesBronze: String {
//        switch self {
//            case .hustler: return "ic_hustler_bronze"
//            case .socialButterfly: return "ic_socialButterfly_bronze"
//            case .baller: return "ic_baller_bronze"
//            case .boujee: return "ic_boujee_bronze"
//            case .buzzer: return "ic_buzzer_bronze"
//            case .hunter: return "ic_hunter_bronze"
//            case .bouncy: return "ic_bouncy_bronze"
//            case .smith: return "ic_smith_bronze"
//            case .wolf: return "ic_wolf_bronze"
//            case .gambit: return "ic_gambit_bronze"
//            case .pirate: return "ic_pirate_bronze"
//        }
//    }
//    
//    var badgeImagesSilver: String {
//        switch self {
//            case .hustler: return "ic_hustler_silver"
//            case .socialButterfly: return "ic_socialButterfly_silver"
//            case .baller: return "ic_baller_silver"
//            case .boujee: return "ic_boujee_silver"
//            case .buzzer: return "ic_buzzer_silver"
//            case .hunter: return "ic_hunter_silver"
//            case .bouncy: return "ic_bouncy_silver"
//            case .smith: return "ic_smith_silver"
//            case .wolf: return "ic_wolf_silver"
//            case .gambit: return "ic_gambit_silver"
//            case .pirate: return "ic_pirate_silver"
//        }
//    }
//    
//    var badgeImagesGold: String {
//        switch self {
//            case .hustler: return "ic_hustler_gold"
//            case .socialButterfly: return "ic_socialButterfly_gold"
//            case .baller: return "ic_baller_gold"
//            case .boujee: return "ic_boujee_gold"
//            case .buzzer: return "ic_buzzer_gold"
//            case .hunter: return "ic_hunter_gold"
//            case .bouncy: return "ic_bouncy_gold"
//            case .smith: return "ic_smith_gold"
//            case .wolf: return "ic_wolf_gold"
//            case .gambit: return "ic_gambit_gold"
//            case .pirate: return "ic_pirate_gold"
//        }
//    }
//
//    var badgeImagesPlat: String {
//        switch self {
//            case .hustler: return "ic_hustler_plat"
//            case .socialButterfly: return "ic_socialButterfly_plat"
//            case .baller: return "ic_baller_plat"
//            case .boujee: return "ic_boujee_plat"
//            case .buzzer: return "ic_buzzer_plat"
//            case .hunter: return "ic_hunter_plat"
//            case .bouncy: return "ic_bouncy_plat"
//            case .smith: return "ic_smith_plat"
//            case .wolf: return "ic_wolf_plat"
//            case .gambit: return "ic_gambit_plat"
//            case .pirate: return "ic_pirate_plat"
//        }
//    }
//
//    var badgeImagesDiamond: String {
//        switch self {
//            case .hustler: return "ic_hustler_diamond"
//            case .socialButterfly: return "ic_socialButterfly_diamond"
//            case .baller: return "ic_baller_diamond"
//            case .boujee: return "ic_boujee_diamond"
//            case .buzzer: return "ic_buzzer_diamond"
//            case .hunter: return "ic_hunter_diamond"
//            case .bouncy: return "ic_bouncy_diamond"
//            case .smith: return "ic_smith_diamond"
//            case .wolf: return "ic_wolf_diamond"
//            case .gambit: return "ic_gambit_diamond"
//            case .pirate: return "ic_pirate_diamond"
//        }
//    }
//
//
//}
//
//enum badgeCategory {
//    case bronze
//    case silver
//    case gold
//    case plat
//    case diamond
//    
//    init?(subBadgeCode: String) {
//        
//        switch subBadgeCode {
//            case "1": self = .bronze
//            case "2": self = .silver
//            case "3": self = .gold
//            case "4": self = .plat
//            case "5": self = .diamond
//            default: return nil
//        }
//    }
//}


enum Badge: String, CaseIterable {
    case hustler = "1"
    case socialButterfly = "2"
    case baller = "3"
    case boujee = "4"
    case buzzer = "5"
    case hunter = "6"
    case bouncy = "7"
    case smith = "8"
    case wolf = "9"
    case gambit = "10"
    case pirate = "11"
    
    func getSubBadgeCode(code: String) -> String {
        let keys = UserDefaultController().mainBadgeCodes?.split(separator: ",").map { String($0) } ?? []
        let values = UserDefaultController().subBadgeCodes?.split(separator: ",").map { String($0) } ?? []
        
        let dict = Dictionary(uniqueKeysWithValues: zip(keys, values))
        
        return dict.filter{$0.key == code}.first?.value ?? ""
    }

    func image(for category: BadgeCategory?) -> String {
        guard let category = category else {
            return "ic_\(self)_disabled"
        }
        
        switch category {
        case .bronze: return "ic_\(self)_bronze"
        case .silver: return "ic_\(self)_silver"
        case .gold: return "ic_\(self)_gold"
        case .plat: return "ic_\(self)_plat"
        case .diamond: return "ic_\(self)_diamond"
        }
    }
    
    func name(for category: BadgeCategory?) -> String {
        guard let category = category else {
            return "locked".localized
        }
        
        switch category {
        case .bronze: return "bronze".localized
        case .silver: return "silver".localized
        case .gold: return "gold".localized
        case .plat: return "plat".localized
        case .diamond: return "diamond".localized
        }

    }
    
    func nextImage(for category: BadgeCategory?) -> String {
        guard let category = category else {
            return "ic_\(self)_bronze"
        }
        
        switch category {
        case .bronze: return "ic_\(self)_silver"
        case .silver: return "ic_\(self)_gold"
        case .gold: return "ic_\(self)_plat"
        case .plat: return "ic_\(self)_diamond"
        case .diamond: return "ic_\(self)_diamond"
        }
    }
    
    func nextName(for category: BadgeCategory?) -> String {
        guard let category = category else {
            return "bronze".localized
        }
        
        switch category {
        case .bronze: return "silver".localized
        case .silver: return "gold".localized
        case .gold: return "plat".localized
        case .plat: return "diamond".localized
        case .diamond: return "diamond".localized
        }

    }


}

enum BadgeCategory {
    case bronze
    case silver
    case gold
    case plat
    case diamond
    
    init?(subBadgeCode:String) {
        switch subBadgeCode {
            case "1": self = .bronze
            case "2": self = .silver
            case "3": self = .gold
            case "4": self = .plat
            case "5": self = .diamond
            default: return nil
        }
    }
}


enum NotificationsTabs{
    case news
    case orders
}
