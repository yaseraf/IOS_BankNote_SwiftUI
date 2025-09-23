//
//  GetExchangeSummaryUIModel.swift
//  mahfazati
//
//  Created by FIT on 17/09/2024.
//  Copyright © 2024 Mohammed Mathkour. All rights reserved.
//

import Foundation

 // MARK: - GetAccessToken
struct GetAccessTokenUIModel: Codable{
    var Error_code: String?
    var resData: AccessTokenResData?
}

extension GetAccessTokenUIModel {
    static func mapToUIModel(_ m:GetAccessTokenResponseModel)->Self {
        return  GetAccessTokenUIModel(Error_code: m.Error_code ?? "", resData: m.resData ?? AccessTokenResData())
    }
    
    static func testUIModel() ->Self {
        return GetAccessTokenUIModel(Error_code: "", resData: AccessTokenResData())
    }
}

// MARK: - StepVerifyPhone
struct StepVerifyPhoneUIModel: Codable{
    var Data: StepVerifyPhoneData?
    var ErrorCode: String?
    var ErrorMessage: String?
}

extension StepVerifyPhoneUIModel {
    static func mapToUIModel(_ m:StepVerifyPhoneResponseModel)->Self {
        return  StepVerifyPhoneUIModel(Data: m.Data ?? StepVerifyPhoneData(), ErrorCode: m.ErrorCode ?? "", ErrorMessage: m.ErrorMessage ?? "")
    }
    
    static func testUIModel() ->Self {
        return StepVerifyPhoneUIModel(Data: StepVerifyPhoneData(), ErrorCode: "", ErrorMessage: "")
    }
}

// MARK: - VerifyPhoneOtp
struct VerifyPhoneOtpUIModel: Codable{
    var AccessToken: String?
    var Data: VerifyPhoneOtpData?
    var ErrorCode: String?
    var ErrorMessage: String?
    var Request_Id: String?
}

extension VerifyPhoneOtpUIModel {
    static func mapToUIModel(_ m:VerifyPhoneOtpResponseModel)->Self {
        return  VerifyPhoneOtpUIModel(AccessToken: m.AccessToken ?? "", Data: m.Data ?? VerifyPhoneOtpData(), ErrorCode: m.ErrorCode ?? "", ErrorMessage: m.ErrorMessage ?? "", Request_Id: m.Request_Id ?? "")
    }
    
    static func testUIModel() ->Self {
        return VerifyPhoneOtpUIModel(AccessToken: "", Data: VerifyPhoneOtpData(), ErrorCode: "", ErrorMessage: "", Request_Id: "")
    }
}

// MARK: - StepVerifyEmail
struct StepVerifyEmailUIModel: Codable{
    var Data: StepVerifyEmailData?
    var ErrorCode: String?
    var ErrorMessage: String?

}

extension StepVerifyEmailUIModel {
    static func mapToUIModel(_ m:StepVerifyEmailResponseModel)->Self {
        return  StepVerifyEmailUIModel(Data: m.Data ?? StepVerifyEmailData(), ErrorCode: m.ErrorCode ?? "", ErrorMessage: m.ErrorMessage ?? "")
    }
    
    static func testUIModel() ->Self {
        return StepVerifyEmailUIModel(Data: StepVerifyEmailData(), ErrorCode: "", ErrorMessage: "")
    }
}

// MARK: - VerifyEmailWithOtp
struct VerifyEmailWithOtpUIModel: Codable{
    var Data: VerifyEmailWithOtpData?
    var ErrorCode: String?
    var ErrorMessage: String?

}

extension VerifyEmailWithOtpUIModel {
    static func mapToUIModel(_ m:VerifyEmailWithOtpResponseModel)->Self {
        return  VerifyEmailWithOtpUIModel(Data: m.Data ?? VerifyEmailWithOtpData(), ErrorCode: m.ErrorCode ?? "", ErrorMessage: m.ErrorMessage ?? "")
    }
    
    static func testUIModel() ->Self {
        return VerifyEmailWithOtpUIModel(Data: VerifyEmailWithOtpData(), ErrorCode: "", ErrorMessage: "")
    }
}

// MARK: - StepCreate
struct StepCreateUIModel: Codable{
    var Data: StepCreateData?
    var ErrorCode: String?
    var ErrorMessage: String?

}

extension StepCreateUIModel {
    static func mapToUIModel(_ m:StepCreateResponseModel)->Self {
        return  StepCreateUIModel(Data: m.Data ?? StepCreateData(), ErrorCode: m.ErrorCode ?? "", ErrorMessage: m.ErrorMessage ?? "")
    }
    
    static func testUIModel() ->Self {
        return StepCreateUIModel(Data: StepCreateData(), ErrorCode: "", ErrorMessage: "")
    }
}

// MARK: - VerifyIDFrontVlens
struct VerifyIDFrontVlensUIModel: Codable{
    let transactionID: String?
    let data: VerifyIDFrontVlensData?
    let errorCode, errorMessage: String?
    let services: VerifyIDFrontVlensServices?
}

extension VerifyIDFrontVlensUIModel {
    static func mapToUIModel(_ m:VerifyIDFrontVlensResponseModel)->Self {
        return  VerifyIDFrontVlensUIModel(transactionID: m.transactionID, data: m.data, errorCode: m.errorCode, errorMessage: m.errorMessage, services: m.services)
    }
    
    static func testUIModel() ->Self {
        return VerifyIDFrontVlensUIModel(transactionID: "", data: .none, errorCode: "", errorMessage: "", services: .none)
    }
}

// MARK: - VerifyIDBack
struct VerifyIDBackUIModel: Codable{
    let transactionID: String?
    let data: VerifyIDBackDataClass?
    let errorCode, errorMessage: String?
    let services: VerifyIDBackServices?
}

extension VerifyIDBackUIModel {
    static func mapToUIModel(_ m:VerifyIDBackResponseModel)->Self {
        return  VerifyIDBackUIModel(transactionID: m.transactionID, data: m.data, errorCode: m.errorCode, errorMessage: m.errorMessage, services: m.services)
    }
    
    static func testUIModel() ->Self {
        return VerifyIDBackUIModel(transactionID: "", data: .none, errorCode: "", errorMessage: "", services: .none)
    }
}

// MARK: - VerifyLiveness
struct VerifyLivenessUIModel: Codable{
    var Data: VerifyLivenessData?
    var ErrorCode: String?
    var ErrorMessage: String?
    var Services: VerifyLivenessServices?
}

extension VerifyLivenessUIModel {
    static func mapToUIModel(_ m:VerifyLivenessResponseModel)->Self {
        return  VerifyLivenessUIModel(Data: m.Data ?? VerifyLivenessData(), ErrorCode: m.ErrorCode ?? "", ErrorMessage: m.ErrorMessage ?? "", Services: m.Services ?? VerifyLivenessServices(aml: m.Services?.aml, src: m.Services?.src, validations: m.Services?.validations, classification: m.Services?.classification, liveness: m.Services?.liveness, spoofing: m.Services?.spoofing))
    }
    
    static func testUIModel() ->Self {
        return VerifyLivenessUIModel(Data: VerifyLivenessData(), ErrorCode: "", ErrorMessage: "", Services: VerifyLivenessServices(aml: VerifyLivenessDeviceInfo(), src: VerifyLivenessDeviceInfo(), validations: VerifyLivenessValidations(validationErrors: []), classification: VerifyLivenessClassification(docType: ""), liveness: VerifyLivenessDeviceInfo(), spoofing: VerifyLivenessDeviceInfo()))
    }
}

// MARK: - GetKYCCibc
struct GetKYCCibcUIModel: Codable{
    var ErrorCode: String?
    var ErrorMessage: String?
}

extension GetKYCCibcUIModel {
    static func mapToUIModel(_ m:GetKYCCibcResponseModel)->Self {
        return  GetKYCCibcUIModel(ErrorCode: m.Error_code ?? "", ErrorMessage: m.Error_Msg ?? "")
    }
    
    static func testUIModel() ->Self {
        return GetKYCCibcUIModel(ErrorCode: "", ErrorMessage: "")
    }
}

// MARK: - GetSourceOfIncome
struct GetSourceOfIncomeUIModel: Codable{
    var ErrorMsg: String?
    var Lang: String?
    var resData: [GetSourceOfIncomeResData?]
}

extension GetSourceOfIncomeUIModel {
    static func mapToUIModel(_ m:GetSourceOfIncomeResponseModel)->Self {
        return  GetSourceOfIncomeUIModel(ErrorMsg: m.ErrorMsg ?? "", Lang: m.Lang ?? "", resData: m.resData ?? [])
    }
    
    static func testUIModel() ->Self {
        return GetSourceOfIncomeUIModel(ErrorMsg: "", Lang: "", resData: [])
    }
}

// MARK: - GetInvestObjective
struct GetInvestObjectiveUIModel: Codable{
    var ErrorMsg: String?
    var Lang: String?
    var resData: [GetInvestObjectiveResData?]
}

extension GetInvestObjectiveUIModel {
    static func mapToUIModel(_ m:GetInvestObjectiveResponseModel)->Self {
        return  GetInvestObjectiveUIModel(ErrorMsg: m.ErrorMsg ?? "", Lang: m.Lang ?? "", resData: m.resData ?? [])
    }
    
    static func testUIModel() ->Self {
        return GetInvestObjectiveUIModel(ErrorMsg: "", Lang: "", resData: [])
    }
}

// MARK: - GetNationality
struct GetNationalityUIModel: Codable{
    var ErrorMsg: String?
    var Lang: String?
    var resData: [GetNationalityResData?]
}

extension GetNationalityUIModel {
    static func mapToUIModel(_ m:GetNationalityResponseModel)->Self {
        return  GetNationalityUIModel(ErrorMsg: m.ErrorMsg ?? "", Lang: m.Lang ?? "", resData: m.resData ?? [])
    }
    
    static func testUIModel() ->Self {
        return GetNationalityUIModel(ErrorMsg: "", Lang: "", resData: [])
    }
}

// MARK: - InsertAttachments
struct InsertAttachmentsUIModel: Codable{
    var ErrorMsg: String?
}

extension InsertAttachmentsUIModel {
    static func mapToUIModel(_ m:InsertAttachmentsResponseModel)->Self {
        return  InsertAttachmentsUIModel(ErrorMsg: m.ErrorMsg ?? "")
    }
    
    static func testUIModel() ->Self {
        return InsertAttachmentsUIModel(ErrorMsg: "")
    }
}


// MARK: - LoginVlens
struct LoginVlensUIModel: Codable{
    var ACTION_ID: String
    var Data: DataClass
    var ErrorCode: String
    var ErrorMessage: String
    var HeaderAccessToken: String
    var Request_Id: String
}



extension LoginVlensUIModel {
    static func mapToUIModel(_ m:LoginVlensResponseModel)->Self {
        return  LoginVlensUIModel(ACTION_ID: m.actionID ?? "", Data: m.data ?? DataClass(accessToken: "", emailOtpRequestID: "", encryptedAccessToken: "", hasPendingRequest: false, isDigitalIdentityVerified: false, isPhoneNumberConfirmationRequired: false, isPhoneNumberConfirmed: false, phoneNumberOtp: "", phoneNumberOtpRequestID: "", phoneOtpExpireInSeconds: 0, redirectURI: "", refreshToken: "", transactionID: "", user: User(emailAddress: "", fullName: "", idNumber: "", name: "", phoneNumber: "", surname: "", userName: "")), ErrorCode: m.errorCode ?? "", ErrorMessage: m.errorMessage ?? "", HeaderAccessToken: m.headerAccessToken ?? "", Request_Id: m.requestID ?? "")
    }
    
  
}

struct GetAllRequestTypesUIModel: Codable{
    var data: [GetAllRequestTypesData]?
    let errorCode, errorMessage: String?
}



extension GetAllRequestTypesUIModel {
    static func mapToUIModel(_ m:GetAllRequestTypesResponseModel)->Self {
        return  GetAllRequestTypesUIModel(data: m.data, errorCode: m.errorCode, errorMessage: m.errorMessage)
    }
    
  
}

struct CreateBusinessRequestUIModel: Codable{
    let data: CreateBusinessDataClass?
        let errorCode, errorMessage: String?

        enum CodingKeys: String, CodingKey {
            case data
            case errorCode = "error_code"
            case errorMessage = "error_message"
        }
}

extension CreateBusinessRequestUIModel {
    static func mapToUIModel(_ m:CreateBusinessRequestResponseModel)->Self {
        return CreateBusinessRequestUIModel(data: m.data, errorCode: m.errorCode, errorMessage: m.errorMessage)
    }
}

struct LoginAdminUIModel: Codable{
    let data: LoginAdminDataClass?
    let errorCode, errorMessage: String?

        enum CodingKeys: String, CodingKey {
            case data
            case errorCode = "error_code"
            case errorMessage = "error_message"
        }
}

extension LoginAdminUIModel {
    static func mapToUIModel(_ m:LoginAdminResponseModel)->Self {
        return LoginAdminUIModel(data: m.data, errorCode: m.errorCode, errorMessage: m.errorMessage)
    }
}

struct ApproveOrRejectRequestUIModel: Codable{
    let data: Bool?
        let errorCode, errorMessage: String?

        enum CodingKeys: String, CodingKey {
            case data
            case errorCode = "error_code"
            case errorMessage = "error_message"
        }
}

extension ApproveOrRejectRequestUIModel {
    static func mapToUIModel(_ m:ApproveOrRejectRequestResponseModel)->Self {
        return ApproveOrRejectRequestUIModel(data: m.data, errorCode: m.errorCode, errorMessage: m.errorMessage)
    }
}

struct GetCurrentBusinessRequestListUIModel: Codable{
    let data: GetCurrentBusinessDatum?
        let errorCode, errorMessage: String?

        enum CodingKeys: String, CodingKey {
            case data = "Data"
            case errorCode = "ErrorCode"
            case errorMessage = "ErrorMessage"
        }
}

extension GetCurrentBusinessRequestListUIModel {
    static func mapToUIModel(_ m:GetCurrentBusinessRequestListResponseModel)->Self {
        return GetCurrentBusinessRequestListUIModel(data: m.data, errorCode: m.errorCode, errorMessage: m.errorMessage)
    }
}

struct ActivateBusinessRequestUIModel: Codable{
    let data: ActivateBusinessData?
        let errorCode, errorMessage: String?

        enum CodingKeys: String, CodingKey {
            case data
            case errorCode = "error_code"
            case errorMessage = "error_message"
        }
}

extension ActivateBusinessRequestUIModel {
    static func mapToUIModel(_ m:ActivateBusinessRequestResponseModel)->Self {
        return ActivateBusinessRequestUIModel(data: m.data, errorCode: m.errorCode, errorMessage: m.errorMessage)
    }
}

struct ValidateOtpBusinessRequestUIModel: Codable{
    let data: ValidateOtpData?
        let errorCode, errorMessage: String?

        enum CodingKeys: String, CodingKey {
            case data
            case errorCode = "error_code"
            case errorMessage = "error_message"
        }
}

extension ValidateOtpBusinessRequestUIModel {
    static func mapToUIModel(_ m:ValidateOtpBusinessRequestResponseModel)->Self {
        return ValidateOtpBusinessRequestUIModel(data: m.data, errorCode: m.errorCode, errorMessage: m.errorMessage)
    }
}
