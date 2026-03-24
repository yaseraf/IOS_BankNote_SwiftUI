//
//  PaymobAuthorizeModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 02/03/2026.
//

import Foundation

struct PaymobGetSdkTokenRequestModel: Codable {
    let amount: Double
    let billingData: BillingDataRequestModel
    let clientID: String
    let currency: String
    let itemDescription: String
    let itemName: String
    let notificationUrl: String
    let quantity: Int
    let redirectionUrl: String
    let webCode: String

    enum CodingKeys: String, CodingKey {
        case amount = "Amount"
        case billingData = "BillingData"
        case clientID = "ClientID"
        case currency = "Currency"
        case itemDescription = "ItemDescription"
        case itemName = "ItemName"
        case notificationUrl = "NotificationUrl"
        case quantity = "Quantity"
        case redirectionUrl = "RedirectionUrl"
        case webCode = "WebCode"
    }
}

struct BillingDataRequestModel: Codable {
    let apartment: String
    let building: String
    let city: String
    let country: String
    let email: String
    let firstName: String
    let floor: String
    let lastName: String
    let phoneNumber: String
    let postalCode: String
    let state: String
    let street: String

    enum CodingKeys: String, CodingKey {
        case apartment = "Apartment"
        case building = "Building"
        case city = "City"
        case country = "Country"
        case email = "Email"
        case firstName = "FirstName"
        case floor = "Floor"
        case lastName = "LastName"
        case phoneNumber = "PhoneNumber"
        case postalCode = "PostalCode"
        case state = "State"
        case street = "Street"
    }
}

struct PaymobGetSdkTokenResponseModel: Codable {
    let clientSecret: String?
    let errorMsg: String?
    let errorCode: String?
    let intentionId: String?
    let merchantOrderId: String?
    let paymobID: String?
    let publicKey: String?
    let rawResponse: String?
    let responseCode: String?
    let responseMessage: String?
    let specialReference: String?
    let status: String?

    enum CodingKeys: String, CodingKey {
        case clientSecret = "ClientSecret"
        case errorMsg = "Error_Msg"
        case errorCode = "Error_code"
        case intentionId = "IntentionId"
        case merchantOrderId = "MerchantOrderId"
        case paymobID = "PaymobID"
        case publicKey = "PublicKey"
        case rawResponse = "RawResponse"
        case responseCode = "ResponseCode"
        case responseMessage = "ResponseMessage"
        case specialReference = "SpecialReference"
        case status = "Status"
    }
}

struct PaymobGetSdkTokenUIModel {
    var clientSecret: String?
    var errorMsg: String?
    var errorCode: String?
    var intentionId: String?
    var merchantOrderId: String?
    var paymobID: String?
    var publicKey: String?
    var rawResponse: String?
    var responseCode: String?
    var responseMessage: String?
    var specialReference: String?
    var status: String?

    static func mapToUIModel(_ model: PaymobGetSdkTokenResponseModel) -> Self {
        return PaymobGetSdkTokenUIModel(
            clientSecret: model.clientSecret,
            errorMsg: model.errorMsg,
            errorCode: model.errorCode,
            intentionId: model.intentionId,
            merchantOrderId: model.merchantOrderId,
            paymobID: model.paymobID,
            publicKey: model.publicKey,
            rawResponse: model.rawResponse,
            responseCode: model.responseCode,
            responseMessage: model.responseMessage,
            specialReference: model.specialReference,
            status: model.status
        )
    }

    static func initializer() -> Self {
        return PaymobGetSdkTokenUIModel()
    }
}

