//
//  GetRiskManagementModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 23/10/2025.
//

import Foundation

struct GetRiskManagementRequestModel:Codable {
    let accountID, clientID, compInit, custodyID: String?
        let includeFacil, includeMargin, leverage: String?
        let mainClientID, memberID, nin, orderID: String?
        let orderType, portMang, price, qty: String?
        let symbol, typeCode, uCode, userCat: String?
        let validity, validityCode, settType, webCode: String?

        enum CodingKeys: String, CodingKey {
            case accountID = "AccountID"
            case clientID = "ClientID"
            case compInit = "CompInit"
            case custodyID = "CustodyID"
            case includeFacil = "IncludeFacil"
            case includeMargin = "IncludeMargin"
            case leverage = "Leverage"
            case mainClientID = "MainClientID"
            case memberID = "MemberID"
            case nin = "NIN"
            case orderID = "OrderID"
            case orderType = "OrderType"
            case portMang = "PortMang"
            case price = "Price"
            case qty = "Qty"
            case symbol = "Symbol"
            case typeCode = "TypeCode"
            case uCode = "UCode"
            case userCat = "UserCat"
            case validity = "Validity"
            case validityCode = "ValidityCode"
            case settType, webCode
        }
}

struct GetRiskManagementResponseModel:Codable {
    let accountID, approvalType, availBAL, avilableShares: String?
        let bank, bankAccountNo, buyOrders, buyPower: String?
        let buyTrades, clientNameA, clientNameE, cash: String?
        let clientID, concRate, exposure, facilitiesAmt: String?
        let flag, flagMsgA, flagMsgE, marginConcentrationPerc: String?
        let msValidation, marginAmnt, maxLeverage, maxOrderValue: String?
        let memberID, nin, offLineOrderDate, orderValue: String?
        let pres, sellOrders, sellTrades, shares: String?
        let unpostedCRTrxns, unpostedDBTrxns, brokerID: String?

        enum CodingKeys: String, CodingKey {
            case accountID = "AccountID"
            case approvalType = "Approval_Type"
            case availBAL = "AvailBal"
            case avilableShares = "AvilableShares"
            case bank = "BANK"
            case bankAccountNo = "BANK_ACCOUNT_NO"
            case buyOrders = "BuyOrders"
            case buyPower = "BuyPower"
            case buyTrades = "BuyTrades"
            case clientNameA = "CLIENT_NAME_A"
            case clientNameE = "CLIENT_NAME_E"
            case cash = "Cash"
            case clientID = "ClientID"
            case concRate = "Conc_Rate"
            case exposure = "Exposure"
            case facilitiesAmt = "FacilitiesAmt"
            case flag = "Flag"
            case flagMsgA = "FlagMsgA"
            case flagMsgE = "FlagMsgE"
            case marginConcentrationPerc = "MARGIN_CONCENTRATION_PERC"
            case msValidation = "MSValidation"
            case marginAmnt = "MarginAmnt"
            case maxLeverage = "MaxLeverage"
            case maxOrderValue = "Max_Order_Value"
            case memberID = "MemberID"
            case nin = "NIN"
            case offLineOrderDate = "OffLineOrderDate"
            case orderValue = "OrderValue"
            case pres = "PRES"
            case sellOrders = "SellOrders"
            case sellTrades = "SellTrades"
            case shares = "Shares"
            case unpostedCRTrxns = "UnpostedCRTrxns"
            case unpostedDBTrxns = "UnpostedDBTrxns"
            case brokerID = "broker_ID"
        }
}

struct GetRiskManagementUIModel {
    var accountID, approvalType, availBAL, bank: String?
    var bankAccountNo, buyOrders, buyPower, buyTrades: String?
    var clientNameA, clientNameE, cash, clientID: String?
    var facilitiesAmt: String?
    var flag, flagMsgA, flagMsgE: String?
    var msValidation, marginAmnt, memberID, nin: String?
    var offLineOrderDate, orderValue, sellOrders, sellTrades: String?
    var shares, unpostedCRTrxns, unpostedDBTrxns, brokerID: String?
    
    static func mapToUIModel(_ model: GetRiskManagementResponseModel) -> Self {
        return GetRiskManagementUIModel(accountID: model.accountID, approvalType: model.approvalType, availBAL: model.availBAL, bank: model.bank, bankAccountNo: model.bankAccountNo, buyOrders: model.buyOrders, buyPower: model.buyPower, buyTrades: model.buyTrades, clientNameA: model.clientNameA, clientNameE: model.clientNameE, cash: model.cash, clientID: model.clientID, facilitiesAmt: model.facilitiesAmt, flag: model.flag, flagMsgA: model.flagMsgA, flagMsgE: model.flagMsgE, msValidation: model.msValidation, marginAmnt: model.marginAmnt, memberID: model.memberID, nin: model.nin, offLineOrderDate: model.offLineOrderDate, orderValue: model.orderValue, sellOrders: model.sellOrders, sellTrades: model.sellTrades, shares: model.shares, unpostedCRTrxns: model.unpostedCRTrxns, unpostedDBTrxns: model.unpostedDBTrxns, brokerID: model.brokerID)
    }
    
    static func initializer() -> Self {
        return GetRiskManagementUIModel()
    }
}
