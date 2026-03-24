//
//  InvoicesModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 09/03/2026.
//

import Foundation


struct GetInvoicesRequestModel: Codable {
    let clientID, dateFrom, dateto, webCode: String?

    enum CodingKeys: String, CodingKey {
        case clientID = "ClientID"
        case dateFrom = "DateFrom"
        case dateto = "Dateto"
        case webCode = "WebCode"
    }
}


struct GetInvoicesResponseModel: Codable {
    let errorCode: String?
    let resData: [InvoicesResDataItem]?

    enum CodingKeys: String, CodingKey {
        case errorCode = "Error_code"
        case resData = "resData"
    }
}

struct InvoicesResDataItem: Codable, Identifiable {
    let id = UUID().uuidString
    let avgPrice, buySellFlag, claClientName, cleClientName: String?
        let custodianA, custodianE, custodianID, clientID: String?
        let currency, date, egxCode, exchange: String?
        let iconID, invNo, mainADDRESSA, mainADDRESSE: String?
        let marketComm, mainClientID: String?
        let mainIDDesc: String?
        let mobile, net, netPrice, officeComm: String?
        let orderID, pox, qty, shortNameA: String?
        let shortNameE, symbolName, tickerid, total: String?
        let unifiedCode, value, accAddressA, accAddressE: String?
        let accountTypeA, accountTypeE, settlementDate: String?

        enum CodingKeys: String, CodingKey {
            case avgPrice = "AVG_PRICE"
            case buySellFlag = "Buy_Sell_flag"
            case claClientName = "CLA_CLIENT_NAME"
            case cleClientName = "CLE_CLIENT_NAME"
            case custodianA = "CUSTODIAN_A"
            case custodianE = "CUSTODIAN_E"
            case custodianID = "CUSTODIAN_ID"
            case clientID = "ClientID"
            case currency = "Currency"
            case date = "Date"
            case egxCode = "EGXCode"
            case exchange = "Exchange"
            case iconID = "IconID"
            case invNo = "Inv_No"
            case mainADDRESSA = "MAIN_ADDRESS_a"
            case mainADDRESSE = "MAIN_ADDRESS_e"
            case marketComm = "MARKET_COMM"
            case mainClientID = "MainClientID"
            case mainIDDesc = "MainIDDesc"
            case mobile = "Mobile"
            case net = "NET"
            case netPrice = "NetPrice"
            case officeComm = "OFFICE_COMM"
            case orderID = "OrderID"
            case pox = "POX"
            case qty = "QTY"
            case shortNameA = "ShortNameA"
            case shortNameE = "ShortNameE"
            case symbolName = "SymbolName"
            case tickerid = "TICKERID"
            case total = "Total"
            case unifiedCode = "UnifiedCode"
            case value = "Value"
            case accAddressA = "acc_address_a"
            case accAddressE = "acc_address_e"
            case accountTypeA = "account_type_a"
            case accountTypeE = "account_type_e"
            case settlementDate = "settlement_date"
        }
}

struct GetInvoicesUIModel: Codable {
    
    var errorCode: String?
    var invoicesResData: [InvoicesResDataItem]?
        
}

extension GetInvoicesUIModel {
    static func mapToUIModel(_ model:GetInvoicesResponseModel)->Self {
        return  GetInvoicesUIModel(errorCode: model.errorCode ?? "", invoicesResData: model.resData ?? [])
    }
    
    static func testUIModel() -> Self {
        return GetInvoicesUIModel(errorCode: "", invoicesResData: [])
    }
}
