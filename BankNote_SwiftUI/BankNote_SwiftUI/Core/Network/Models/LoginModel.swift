//
//  LoginModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 19/08/2025.
//

import Foundation

struct LoginRequestModel: Codable {
    var fingerPrintID, hdnKey: String
    var mainClientID, mobileNo, emailAddress, mobileType: String
    var newUser, oldPassword, password, password2: String
    var registrationID, sessionID, tokenID, touchToken: String
    var tradingNo: String
    var userIPAddress, userName, versionNumber: String
    var webCode, isAuthorizeOnly: String
    
    init(emailAddress: String, hdnKey: String, fingerPrintId: String, mainClientID: String, mobileNo: String, mobileType: String, newUser: String, oldPassword: String, password: String, password2: String, registrationId: String, sessionID: String, tokenID: String, touchToken: String, tradingNo: String, userIPAddress: String, userName: String, versionNumber: String, webCode: String, isAuthorizeOnly: String) {
           
           self.emailAddress = emailAddress
           self.hdnKey = hdnKey
           self.fingerPrintID = fingerPrintId
           self.mainClientID = mainClientID
           self.mobileNo = mobileNo
           self.mobileType = mobileType
           self.newUser = newUser
           self.oldPassword = oldPassword
           self.password = password
           self.password2 = password2
           self.registrationID = registrationId
           self.sessionID = sessionID
           self.tokenID = tokenID
           self.touchToken = touchToken
           self.tradingNo = tradingNo
           self.userIPAddress = userIPAddress
           self.userName = userName
           self.versionNumber = versionNumber
           self.webCode = webCode
           self.isAuthorizeOnly = isAuthorizeOnly
       }

   
    enum CodingKeys: String, CodingKey {
        case emailAddress = "Email_Address"
        case hdnKey = "hdnKey"
        case fingerPrintID = "FingerPrintID"
        case mainClientID = "MainClientId"
        case mobileNo = "MobileNo"
        case mobileType = "MobileType"
        case newUser = "NewUser"
        case oldPassword = "OldPassword"
        case password = "Password"
        case password2 = "Password2"
        case registrationID = "RegistrationId"
        case sessionID = "SessionID"
        case tokenID = "TokenID"
        case touchToken = "TouchToken"
        case tradingNo = "TradingNo"
        case userIPAddress = "UserIPAddress"
        case userName = "UserName"
        case versionNumber = "VersionNumber"
        case webCode = "WebCode"
        case isAuthorizeOnly = "isAuthorizeOnly"
    }
}

struct LoginResponseModel: Codable {
    let brokerID, curCode, compInit, email: String?
    let errorMsg, groupCode, isAgreed, isBiometric: String?
    let isDeleted, isEnableOMSPLUS, isFirstLogin, isRenewed: String?
    let lastLoginDate, mainClientID, mobID, mobType: String?
    let mobileNo, nameFullNameA, nameFullNameE, otp: String?
    let passwordPolicy: PasswordPolicy?
    let registrationID, sessionID, status: String?
    let subscribedMarkets: [String]?
    let subscriptionDaysNotify, subscriptionDaysRemaining, subscriptionFeeAmt: String?
    let subscriptionFrom, subscriptionTo: String?
    let trialsNumber, uCode, updateInfo: String?
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
        case enforceChangePassword = "enforceChangePassword"
        case enforceKYC = "enforceKYC"
        case isExpiredDocument = "isExpiredDocument"
        case isIndividual = "isIndividual"
        case isMigrationEligible = "isMigrationEligible"
        case isTermsAndConditions = "isTermsAndConditions"
        case lockedSeconds = "lockedSeconds"
    }
}


// MARK: - PasswordPolicy
public struct PasswordPolicy : Codable {
    let enforceSpecialChar, enforceStartWithAlpha, enforeAlphanumeric, minlength: String
    let numCapitalChar, numSmallChar, numSpecialChar, passComplexity: String
    
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

struct LoginUIModel {
    let brokerID, curCode, compInit, email: String?
    let errorMsg, groupCode, isAgreed, isBiometric: String?
    let isDeleted, isEnableOMSPLUS, isFirstLogin, isRenewed: String?
    let lastLoginDate, mainClientID, mobID, mobType: String?
    let mobileNo, nameFullNameA, nameFullNameE, otp: String?
    let passwordPolicy: PasswordPolicy?
    let registrationID, sessionID, status: String?
    let subscribedMarkets: [String]?
    let subscriptionDaysNotify, subscriptionDaysRemaining, subscriptionFeeAmt: String?
    let subscriptionFrom, subscriptionTo: String?
    let trialsNumber, uCode, updateInfo: String?
    let userName, userType, webCode, enforceChangePassword: String?
    let enforceKYC: String?
    let isExpiredDocument, isIndividual: Bool?
    let isMigrationEligible, isTermsAndConditions, lockedSeconds: String?
    
    static func mapToUIModel(_ model:LoginResponseModel)->Self {
        return LoginUIModel(brokerID: model.brokerID ?? "", curCode: model.curCode ?? "", compInit: model.compInit ?? "", email: model.email ?? "", errorMsg: model.errorMsg ?? "", groupCode: model.groupCode ?? "", isAgreed: model.isAgreed ?? "", isBiometric: model.isBiometric ?? "", isDeleted: model.isDeleted ?? "", isEnableOMSPLUS: model.isEnableOMSPLUS ?? "", isFirstLogin: model.isFirstLogin ?? "", isRenewed: model.isRenewed ?? "", lastLoginDate: model.lastLoginDate ?? "", mainClientID: model.mainClientID ?? "", mobID: model.mobID ?? "", mobType: model.mobType ?? "", mobileNo: model.mobileNo ?? "", nameFullNameA: model.nameFullNameA ?? "", nameFullNameE: model.nameFullNameE ?? "", otp: model.otp ?? "", passwordPolicy: model.passwordPolicy ?? PasswordPolicy(enforceSpecialChar: model.passwordPolicy?.enforceSpecialChar ?? "", enforceStartWithAlpha: model.passwordPolicy?.enforceStartWithAlpha ?? "", enforeAlphanumeric: model.passwordPolicy?.enforeAlphanumeric ?? "", minlength: model.passwordPolicy?.minlength ?? "", numCapitalChar: model.passwordPolicy?.numCapitalChar ?? "", numSmallChar: model.passwordPolicy?.numSmallChar ?? "", numSpecialChar: model.passwordPolicy?.numSpecialChar ?? "", passComplexity: model.passwordPolicy?.passComplexity ?? ""), registrationID: model.registrationID ?? "", sessionID: model.sessionID ?? "", status: model.status ?? "", subscribedMarkets: model.subscribedMarkets ?? [], subscriptionDaysNotify: model.subscriptionDaysNotify ?? "", subscriptionDaysRemaining: model.subscriptionDaysRemaining ?? "", subscriptionFeeAmt: model.subscriptionFeeAmt ?? "", subscriptionFrom: model.subscriptionFrom ?? "", subscriptionTo: model.subscriptionTo ?? "", trialsNumber: model.trialsNumber ?? "", uCode: model.uCode ?? "", updateInfo: model.updateInfo ?? "", userName: model.userName ?? "", userType: model.userType ?? "", webCode: model.webCode ?? "", enforceChangePassword: model.enforceChangePassword ?? "", enforceKYC: model.enforceKYC ?? "", isExpiredDocument: model.isExpiredDocument ?? false, isIndividual: model.isIndividual ?? false, isMigrationEligible: model.isMigrationEligible ?? "", isTermsAndConditions: model.isTermsAndConditions ?? "", lockedSeconds: model.lockedSeconds ?? "")
    }
    
    static func initializer() -> Self {
    return LoginUIModel(brokerID: "", curCode: "", compInit: "", email: "", errorMsg: "", groupCode: "", isAgreed: "", isBiometric: "", isDeleted: "", isEnableOMSPLUS: "", isFirstLogin: "", isRenewed: "", lastLoginDate: "", mainClientID: "", mobID: "", mobType: "", mobileNo: "", nameFullNameA: "", nameFullNameE: "", otp: "", passwordPolicy: PasswordPolicy(enforceSpecialChar: "", enforceStartWithAlpha: "", enforeAlphanumeric: "", minlength: "", numCapitalChar: "", numSmallChar: "", numSpecialChar: "", passComplexity: ""), registrationID: "", sessionID: "", status: "", subscribedMarkets: [], subscriptionDaysNotify: "", subscriptionDaysRemaining: "", subscriptionFeeAmt: "", subscriptionFrom: "", subscriptionTo: "", trialsNumber: "", uCode: "", updateInfo: "", userName: "", userType: "", webCode: "", enforceChangePassword: "", enforceKYC: "", isExpiredDocument: false, isIndividual: false, isMigrationEligible: "", isTermsAndConditions: "", lockedSeconds: "")
    }

}
