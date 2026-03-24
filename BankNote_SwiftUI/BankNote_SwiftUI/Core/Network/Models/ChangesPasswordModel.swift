//
//  ChangesPasswordModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 07/03/2026.
//

import Foundation

// MARK: - ChangePasswordReqModel
struct ChangePasswordRequestModel: Codable {
    let UserName: String?
    let Password: String?
    let Password2: String?
    let MobileType: String?
    let SessionID: String?
    let UserIPAddress: String?
    let TokenID: String?
    let WebCode: String?
    let OldPassword: String?
}

// MARK: - ChangePasswordResponseModel
struct ChangePasswordResponseModel: Codable {
    let brokerID, curCode, compInit, email: String?
        let errorMsg, groupCode, isAgreed, isBiometric: String?
        let isDeleted, isEnableOMSPLUS, isFirstLogin, isRenewed: String?
        let lastLoginDate, mainClientID, mobID, mobType: String?
        let mobileNo, nameFullNameA, nameFullNameE, otp: String?
        let passwordPolicy: ChangePasswordPolicy?
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

struct ChangePasswordPolicy: Codable {
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

// MARK: - ChangePinReqModel
struct ChangePinRequestModel: Codable {
    let UserName: String?
    let Password: String?
    let Password2: String?
    let MobileType: String?
    let SessionID: String?
    let UserIPAddress: String?
    let TokenID: String?
    let WebCode: String?
    let OldPassword: String?
}

// MARK: - ChangePinResponseModel
struct ChangePinResponseModel: Codable {
    let brokerID, curCode, compInit, email: String?
        let errorMsg, groupCode, isAgreed, isBiometric: String?
        let isDeleted, isEnableOMSPLUS, isFirstLogin, isRenewed: String?
        let lastLoginDate, mainClientID, mobID, mobType: String?
        let mobileNo, nameFullNameA, nameFullNameE, otp: String?
        let passwordPolicy: ChangePinPolicy?
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

// MARK: - PinPolicy

struct ChangePinPolicy: Codable {
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

struct changePasswordUIModel:Codable {
    var name:String
    var email:String
    var otp:String
    var status:String
    var errorMsg:String
    var webCode:String
    var mobileNo: String
}


extension changePasswordUIModel {
    static func mapToUIModel(_ model:ChangePasswordResponseModel)->Self {
        return changePasswordUIModel(
            name: model.nameFullNameE ?? "", // map to `name`
            email:  model.email ?? "",
            otp: model.otp ?? "" , // map to `otp` ,
            status: model.status ?? "" ,
            errorMsg: model.errorMsg ?? "" ,
            webCode: model.webCode ?? "" ,
            mobileNo:  model.mobileNo ?? ""
        )
    }
    
    static func initializer() -> Self {
        return changePasswordUIModel(name: "", email: "", otp: "", status: "", errorMsg: "", webCode: "", mobileNo: "")
    }
}

struct changePinUIModel:Codable {
    var name:String
    var email:String
    var otp:String
    var status:String
    var errorMsg:String
    var webCode:String
    var mobileNo: String
}


extension changePinUIModel {
    static func mapToUIModel(_ model:ChangePinResponseModel)->Self {
        return changePinUIModel(
            name: model.nameFullNameE ?? "", // map to `name`
            email:  model.email ?? "",
            otp: model.otp ?? "" , // map to `otp` ,
            status: model.status ?? "" ,
            errorMsg: model.errorMsg ?? "" ,
            webCode: model.webCode ?? "" ,
            mobileNo:  model.mobileNo ?? ""
        )
    }
    
    static func initializer() -> Self {
        return changePinUIModel(name: "", email: "", otp: "", status: "", errorMsg: "", webCode: "", mobileNo: "")
    }
}


