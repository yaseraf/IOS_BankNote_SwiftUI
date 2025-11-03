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

enum   TermsAndPrivacySourceType{
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
