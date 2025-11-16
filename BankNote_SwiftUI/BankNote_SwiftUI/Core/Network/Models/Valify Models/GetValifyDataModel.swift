//
//  GetValifyDataModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 11/11/2025.
//

import Foundation

struct GetValifyDataRequestModel: Codable {
    let reqID: String
}

struct GetValifyDataResponseModel: Codable {
    let errorMsg: String?
    let errorCode: String?
    let resData: IDResData?
    
    enum CodingKeys: String, CodingKey {
        case errorMsg = "Error_Msg"
        case errorCode = "Error_code"
        case resData = "ResData"
    }
}

struct IDResData: Codable {
    let age: String?
    let backNid: String?
    let birthGovernorate: String?
    let dateOfBirth: String?
    let expiryDate: String?
    let firstName: String?
    let frontNid: String?
    let fullName: String?
    let gender: String?
    let governorate: String?
    let husbandName: String?
    let maritalStatus: String?
    let policeStation: String?
    let profession: String?
    let releaseDate: String?
    let religion: String?
    let requestId: String?
    let serialNumber: String?
    let street: String?
    let transactionId: String?
    let trialsRemaining: String?
    
    enum CodingKeys: String, CodingKey {
        case age = "Age"
        case backNid = "BackNid"
        case birthGovernorate = "BirthGovernorate"
        case dateOfBirth = "DateOfBirth"
        case expiryDate = "ExpiryDate"
        case firstName = "FirstName"
        case frontNid = "FrontNid"
        case fullName = "FullName"
        case gender = "Gender"
        case governorate = "Governorate"
        case husbandName = "HusbandName"
        case maritalStatus = "MaritalStatus"
        case policeStation = "PoliceStation"
        case profession = "Profession"
        case releaseDate = "ReleaseDate"
        case religion = "Religion"
        case requestId = "RequestId"
        case serialNumber = "SerialNumber"
        case street = "Street"
        case transactionId = "TransactionId"
        case trialsRemaining = "TrialsRemaining"
    }
}

struct GetValifyDataUIModel {
    var errorMsg: String?
    var errorCode: String?
    var resData: IDResData?

    static func mapToUIModel(_ model: GetValifyDataResponseModel) -> Self {
        return GetValifyDataUIModel(errorMsg: model.errorMsg, errorCode: model.errorCode, resData: model.resData)
    }
    
    static func initializer() -> Self {
        return GetValifyDataUIModel()
    }
}
