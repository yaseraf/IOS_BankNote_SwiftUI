//
//  OTPModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 19/08/2025.
//

import Foundation

class OTPRequestModel : Codable {
    var emailAddress, hdnKey, mobileNo, mobileType: String
    var password, sessionID, tokenID, tradingNo: String
    var userIPAddress, userName, versionNumber: String
    var isAuthorizeOnly, fingerPrintID, fingerPrintLevel: String
    var FingerPrintEnabled , RegistrationId : String

    init(emailAddress: String, hdnKey: String, fingerPrintId: String, mainClientID: String, mobileNo: String, mobileType: String, newUser: String, oldPassword: String, password: String, password2: String, registrationId: String, sessionID: String, tokenID: String, touchToken: String, tradingNo: String, userIPAddress: String, userName: String, versionNumber: String, webCode: String, isAuthorizeOnly: String, fingerPrintID: String, fingerPrintLevel: String, FingerPrintEnabled : String, RegistrationId : String) {
           
           self.emailAddress = emailAddress
           self.hdnKey = hdnKey
           self.fingerPrintID = fingerPrintId
           self.mobileNo = mobileNo
           self.mobileType = mobileType
           self.password = password
           self.sessionID = sessionID
           self.tokenID = tokenID
           self.tradingNo = tradingNo
           self.userIPAddress = userIPAddress
           self.userName = userName
           self.versionNumber = versionNumber
           self.isAuthorizeOnly = isAuthorizeOnly
           self.fingerPrintID = fingerPrintID
           self.fingerPrintLevel = fingerPrintLevel
           self.FingerPrintEnabled = FingerPrintEnabled
           self.RegistrationId = RegistrationId
       }

    enum CodingKeys: String, CodingKey {
        case emailAddress = "Email_Address"
        case hdnKey = "HdnKey"
        case mobileNo = "MobileNo"
        case mobileType = "MobileType"
        case password = "Password"
        case sessionID = "SessionID"
        case tokenID = "TokenID"
        case tradingNo = "TradingNo"
        case userIPAddress = "UserIPAddress"
        case userName = "UserName"
        case versionNumber = "VersionNumber"
        case isAuthorizeOnly = "isAuthorizeOnly"
        case fingerPrintID = "FingerPrintID"
        case fingerPrintLevel = "FingerPrintLevel"
        case FingerPrintEnabled = "FingerPrintEnabled"
        case RegistrationId = "RegistrationId"
    }
}

class OTPResponseModel : Codable  {
    let brokerID, curCode, compInit, email: String?
    let errorMsg, groupCode, isAgreed, isBiometric: String?
    let isDeleted, isEnableOMSPLUS, isFirstLogin, isRenewed: String?
    let lastLoginDate, mainClientID, mobID, mobType: String?
    let mobileNo, nameFullNameA, nameFullNameE, otp: String?
    let passwordPolicy: PasswordPolicy?
    let registrationID, sessionID, status: String?
    let subscribedMarkets: [String]?
    let subscriptionDaysNotify, subscriptionDaysRemaining, subscriptionFeeAmt, subscriptionFrom: String?
    let subscriptionTo, trialsNumber, uCode, updateInfo: String?
    let userName, userType, webCode, enforceChangePassword: String?
    let enforceKYC: String?
    let isExpiredDocument, isIndividual: Bool?
    let isMigrationEligible, isTermsAndConditions, lockedSeconds: String?
    
    enum CodingKeys:  String, CodingKey {
        case passwordPolicy = "PasswordPolicy"
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

struct otpUIModel:Codable {
    let brokerID, curCode, compInit, email: String?
    let errorMsg, groupCode, isAgreed, isBiometric: String?
    let isDeleted, isEnableOMSPLUS, isFirstLogin, isRenewed: String?
    let lastLoginDate, mainClientID, mobID, mobType: String?
    let mobileNo, nameFullNameA, nameFullNameE, otp: String?
    let passwordPolicy: PasswordPolicy?
    let registrationID, sessionID, status: String?
    let subscribedMarkets: [String]?
    let subscriptionDaysNotify, subscriptionDaysRemaining, subscriptionFeeAmt, subscriptionFrom: String?
    let subscriptionTo, trialsNumber, uCode, updateInfo: String?
    let userName, userType, webCode, enforceChangePassword: String?
    let enforceKYC: String?
    let isExpiredDocument, isIndividual: Bool?
    let isMigrationEligible, isTermsAndConditions, lockedSeconds: String?
    
    static func mapToUIModel(_ model:OTPResponseModel)->Self {
        return otpUIModel(brokerID: model.brokerID ?? "", curCode: model.curCode ?? "", compInit: model.compInit ?? "", email: model.email ?? "", errorMsg: model.errorMsg ?? "", groupCode: model.groupCode ?? "", isAgreed: model.isAgreed ?? "", isBiometric: model.isBiometric ?? "", isDeleted: model.isDeleted ?? "", isEnableOMSPLUS: model.isEnableOMSPLUS ?? "", isFirstLogin: model.isFirstLogin ?? "", isRenewed: model.isRenewed ?? "", lastLoginDate: model.lastLoginDate ?? "", mainClientID: model.mainClientID ?? "", mobID: model.mobID ?? "", mobType: model.mobType ?? "", mobileNo: model.mobileNo ?? "", nameFullNameA: model.nameFullNameA ?? "", nameFullNameE: model.nameFullNameE ?? "", otp: model.otp ?? "", passwordPolicy: model.passwordPolicy ?? PasswordPolicy(enforceSpecialChar: model.passwordPolicy?.enforceSpecialChar ?? "", enforceStartWithAlpha: model.passwordPolicy?.enforceStartWithAlpha ?? "", enforeAlphanumeric: model.passwordPolicy?.enforeAlphanumeric ?? "", minlength: model.passwordPolicy?.minlength ?? "", numCapitalChar: model.passwordPolicy?.numCapitalChar ?? "", numSmallChar: model.passwordPolicy?.numSmallChar ?? "", numSpecialChar: model.passwordPolicy?.numSpecialChar ?? "", passComplexity: model.passwordPolicy?.passComplexity ?? ""), registrationID: model.registrationID ?? "", sessionID: model.sessionID ?? "", status: model.status ?? "", subscribedMarkets: model.subscribedMarkets ?? [], subscriptionDaysNotify: model.subscriptionDaysNotify ?? "", subscriptionDaysRemaining: model.subscriptionDaysRemaining ?? "", subscriptionFeeAmt: model.subscriptionFeeAmt ?? "", subscriptionFrom: model.subscriptionFrom ?? "", subscriptionTo: model.subscriptionTo ?? "", trialsNumber: model.trialsNumber ?? "", uCode: model.uCode ?? "", updateInfo: model.updateInfo ?? "", userName: model.userName ?? "", userType: model.userType ?? "", webCode: model.webCode ?? "", enforceChangePassword: model.enforceChangePassword ?? "", enforceKYC: model.enforceKYC ?? "", isExpiredDocument: model.isExpiredDocument ?? false, isIndividual: model.isIndividual ?? false, isMigrationEligible: model.isMigrationEligible ?? "", isTermsAndConditions: model.isTermsAndConditions ?? "", lockedSeconds: model.lockedSeconds ?? "")
    }
    
    static func initializer() -> Self {
        return otpUIModel(brokerID: "", curCode: "", compInit: "", email: "", errorMsg: "", groupCode: "", isAgreed: "", isBiometric: "", isDeleted: "", isEnableOMSPLUS: "", isFirstLogin: "", isRenewed: "", lastLoginDate: "", mainClientID: "", mobID: "", mobType: "", mobileNo: "", nameFullNameA: "", nameFullNameE: "", otp: "", passwordPolicy: .none, registrationID: "", sessionID: "", status: "", subscribedMarkets: [], subscriptionDaysNotify: "", subscriptionDaysRemaining: "", subscriptionFeeAmt: "", subscriptionFrom: "", subscriptionTo: "", trialsNumber: "", uCode: "", updateInfo: "", userName: "", userType: "", webCode: "", enforceChangePassword: "", enforceKYC: "", isExpiredDocument: false, isIndividual: false, isMigrationEligible: "", isTermsAndConditions: "", lockedSeconds: "")
    }

}
