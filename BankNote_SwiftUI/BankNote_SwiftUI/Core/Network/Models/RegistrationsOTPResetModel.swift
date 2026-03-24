//
//  RegistrationsOTPResetModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 07/03/2026.
//

import Foundation

struct RegistrationsOTPResetRequestModel: Codable {
    let fingerPrintEnabled, tradingNo, versionNumber, fingerPrintID: String?
        let fingerPrintLevel, hdnKey, isAuthorizeOnly, mobileType: String?
        let password, registrationID, sessionID, tokenID: String?
        let userIPAddress, userName: String?

        enum CodingKeys: String, CodingKey {
            case fingerPrintEnabled = "FingerPrintEnabled"
            case tradingNo = "TradingNo"
            case versionNumber = "VersionNumber"
            case fingerPrintID = "FingerPrintID"
            case fingerPrintLevel = "FingerPrintLevel"
            case hdnKey = "HdnKey"
            case isAuthorizeOnly
            case mobileType = "MobileType"
            case password = "Password"
            case registrationID = "RegistrationId"
            case sessionID = "SessionID"
            case tokenID = "TokenID"
            case userIPAddress = "UserIPAddress"
            case userName = "UserName"
        }
}

struct RegistrationsOTPResetResponseModel: Codable {
    let brokerID, curCode, compInit, email: String?
        let errorMsg, groupCode, isAgreed, isBiometric: String?
        let isDeleted, isEnableOMSPLUS, isFirstLogin, isRenewed: String?
        let lastLoginDate, mainClientID, mobID, mobType: String?
        let mobileNo, nameFullNameA, nameFullNameE, otp: String?
        let passwordPolicy: RegistrationsOTPResetPasswordPolicy?
        let registrationID, sessionID, status: String?
        let subscribedMarkets: [String]?
        let subscriptionDaysNotify, subscriptionDaysRemaining, subscriptionFeeAmt, subscriptionFrom: String?
        let subscriptionTo, trialsNumber, uCode, updateInfo: String?
        let userName, userType, webCode, enforceChangePassword: String?
        let enforceKYC: String?
        let isExpiredDocument, isIndividual: Bool?
        let isMigrationEligible, isTermsAndConditions, lockedSeconds: String?

        enum CodingKeys: String, CodingKey {
            case brokerID = "BrokerID"
            case curCode = "CUR_CODE"
            case compInit = "CompInit"
            case email = "Email"
            case errorMsg = "ErrorMsg"
            case groupCode = "GroupCode"
            case isAgreed = "IsAgreed"
            case isBiometric = "IsBiometric"
            case isDeleted = "IsDeleted"
            case isEnableOMSPLUS = "IsEnableOMSPLUS"
            case isFirstLogin = "IsFirstLogin"
            case isRenewed = "IsRenewed"
            case lastLoginDate = "LastLoginDate"
            case mainClientID = "MainClientId"
            case mobID = "MobID"
            case mobType = "MobType"
            case mobileNo = "MobileNo"
            case nameFullNameA = "NameFullNameA"
            case nameFullNameE = "NameFullNameE"
            case otp = "OTP"
            case passwordPolicy = "PasswordPolicy"
            case registrationID = "RegistrationId"
            case sessionID = "SessionID"
            case status = "Status"
            case subscribedMarkets = "SubscribedMarkets"
            case subscriptionDaysNotify = "SubscriptionDaysNotify"
            case subscriptionDaysRemaining = "SubscriptionDaysRemaining"
            case subscriptionFeeAmt = "SubscriptionFeeAmt"
            case subscriptionFrom = "SubscriptionFrom"
            case subscriptionTo = "SubscriptionTo"
            case trialsNumber = "TrialsNumber"
            case uCode = "UCode"
            case updateInfo = "UpdateInfo"
            case userName = "UserName"
            case userType = "UserType"
            case webCode = "WebCode"
            case enforceChangePassword, enforceKYC, isExpiredDocument, isIndividual, isMigrationEligible, isTermsAndConditions, lockedSeconds
        }
    }

struct RegistrationsOTPResetPasswordPolicy: Codable {
    let enforceSpecialChar, enforceStartWithAlpha, enforeAlphanumeric, minlength: String?
        let numCapitalChar, numSmallChar, numSpecialChar, passComplexity: String?

        enum CodingKeys: String, CodingKey {
            case enforceSpecialChar = "ENFORCE_SPECIAL_CHAR"
            case enforceStartWithAlpha = "ENFORCE_START_WITH_ALPHA"
            case enforeAlphanumeric = "ENFORE_ALPHANUMERIC"
            case minlength = "MINLENGTH"
            case numCapitalChar = "NUM_CAPITAL_CHAR"
            case numSmallChar = "NUM_SMALL_CHAR"
            case numSpecialChar = "NUM_SPECIAL_CHAR"
            case passComplexity = "PASS_COMPLEXITY"
        }
}

struct RegistrationsOTPResetUIModel {
    var webCode:String
    var sessinoId:String?
    var username:String
    var statusCode:String
    var errorMessage:String
}

extension RegistrationsOTPResetUIModel {
    static func mapToUIModel(_ model:RegistrationsOTPResetResponseModel)->Self {
        return RegistrationsOTPResetUIModel(webCode: model.webCode ?? "", sessinoId: model.sessionID ?? "", username: model.userName ?? "", statusCode: model.status ?? "", errorMessage: model.errorMsg ?? "")
    }
}
