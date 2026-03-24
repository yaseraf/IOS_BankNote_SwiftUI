//
//  UserAuthinticationAdvanceModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 07/03/2026.
//

import Foundation

struct UserAuthenticationAdvanceRequestModel: Codable {
    let email: String
       let id: String
       let mobile: String
       let mobileType: String
       let nin: String
       let requestType: String
       let userIPAddress: String

       enum CodingKeys: String, CodingKey {
           case email = "Email"
           case id = "ID"
           case mobile = "Mobile"
           case mobileType = "MobileType"
           case nin = "NIN"
           case requestType = "RequestType"
           case userIPAddress = "UserIPAddress"
       }
}

struct UserAuthenticationAdvanceResponseModel: Codable {
    let brokerID, curCode, compInit, email: String?
        let errorMsg, groupCode, isAgreed, isBiometric: String?
        let isDeleted, isEnableOMSPLUS, isFirstLogin, isRenewed: String?
        let lastLoginDate, mainClientID, mobID, mobType: String?
        let mobileNo, nameFullNameA, nameFullNameE, otp: String?
        let passwordPolicy: UserAuthPasswordPolicy?
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

    // MARK: - PasswordPolicy
    struct UserAuthPasswordPolicy: Codable {
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

struct UserAuthenticationAdvanceUIModel{
    let brokerID, curCode, compInit, email: String?
        let errorMsg, groupCode, isAgreed, isBiometric: String?
        let isDeleted, isEnableOMSPLUS, isFirstLogin, isRenewed: String?
        let lastLoginDate, mainClientID, mobID, mobType: String?
        let mobileNo, nameFullNameA, nameFullNameE, otp: String?
        let passwordPolicy: UserAuthPasswordPolicy?
        let registrationID, sessionID, status: String?
        let subscribedMarkets: [String]?
        let subscriptionDaysNotify, subscriptionDaysRemaining, subscriptionFeeAmt, subscriptionFrom: String?
        let subscriptionTo, trialsNumber, uCode, updateInfo: String?
        let userName, userType, webCode, enforceChangePassword: String?
        let enforceKYC: String?
        let isExpiredDocument, isIndividual: Bool?
        let isMigrationEligible, isTermsAndConditions, lockedSeconds: String?
}


extension UserAuthenticationAdvanceUIModel {
    static func mapToUIModel(_ m:UserAuthenticationAdvanceResponseModel)->Self {
        return  UserAuthenticationAdvanceUIModel(brokerID: m.brokerID, curCode: m.curCode, compInit: m.compInit, email: m.email, errorMsg: m.errorMsg, groupCode: m.groupCode, isAgreed: m.isAgreed, isBiometric: m.isBiometric, isDeleted: m.isDeleted, isEnableOMSPLUS: m.isEnableOMSPLUS, isFirstLogin: m.isFirstLogin, isRenewed: m.isRenewed, lastLoginDate: m.lastLoginDate, mainClientID: m.mainClientID, mobID: m.mobID, mobType: m.mobType, mobileNo: m.mobileNo, nameFullNameA: m.nameFullNameA, nameFullNameE: m.nameFullNameE, otp: m.otp, passwordPolicy: m.passwordPolicy, registrationID: m.registrationID, sessionID: m.sessionID, status: m.status, subscribedMarkets: m.subscribedMarkets, subscriptionDaysNotify: m.subscriptionDaysNotify, subscriptionDaysRemaining: m.subscriptionDaysRemaining, subscriptionFeeAmt: m.subscriptionFeeAmt, subscriptionFrom: m.subscriptionFrom, subscriptionTo: m.subscriptionTo, trialsNumber: m.trialsNumber, uCode: m.uCode, updateInfo: m.updateInfo, userName: m.userName, userType: m.userType, webCode: m.webCode, enforceChangePassword: m.enforceChangePassword, enforceKYC: m.enforceKYC, isExpiredDocument: m.isExpiredDocument, isIndividual: m.isIndividual, isMigrationEligible: m.isMigrationEligible, isTermsAndConditions: m.isTermsAndConditions, lockedSeconds: m.lockedSeconds)
    }
    
    static func initializer() -> Self {
        return UserAuthenticationAdvanceUIModel(brokerID: "", curCode: "", compInit: "", email: "", errorMsg: "", groupCode: "", isAgreed: "", isBiometric: "", isDeleted: "", isEnableOMSPLUS: "", isFirstLogin: "", isRenewed: "", lastLoginDate: "", mainClientID: "", mobID: "", mobType: "", mobileNo: "", nameFullNameA: "", nameFullNameE: "", otp: "", passwordPolicy: UserAuthPasswordPolicy(enforceSpecialChar: "", enforceStartWithAlpha: "", enforeAlphanumeric: "", minlength: "", numCapitalChar: "", numSmallChar: "", numSpecialChar: "", passComplexity: ""), registrationID: "", sessionID: "", status: "", subscribedMarkets: [], subscriptionDaysNotify: "", subscriptionDaysRemaining: "", subscriptionFeeAmt: "", subscriptionFrom: "", subscriptionTo: "", trialsNumber: "", uCode: "", updateInfo: "", userName: "", userType: "", webCode: "", enforceChangePassword: "", enforceKYC: "", isExpiredDocument: false, isIndividual: false, isMigrationEligible: "", isTermsAndConditions: "", lockedSeconds: "")
    }
}
