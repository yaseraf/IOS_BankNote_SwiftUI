//
//  StatementsModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 09/03/2026.
//

import Foundation

struct GetStatementOfAccountRequestModel {
    
}

struct GetStatementOfAccountResponseModel: Codable {
    let avgPrice, balance, crAmt: Double?
    let clientID, clientNameA, clientNameE, curNameA: String?
    let curNameE: String?
    let dbAmt: Double?
    let docName, docNo, invoiceNo, postDate: String?
    let qty: Double?
    let remarkA, remarkE, settDate: String?
    let sharePrice: Double?
    let status, symbol: String?
    let totalComm, totalCredit, totalDebit: Double?
    let CUR_CODE:String?

    enum CodingKeys: String, CodingKey {
        case avgPrice = "AvgPrice"
        case balance = "Balance"
        case crAmt = "CR_AMT"
        case clientID = "ClientID"
        case clientNameA = "ClientNameA"
        case clientNameE = "ClientNameE"
        case curNameA = "CurNameA"
        case curNameE = "CurNameE"
        case dbAmt = "DB_AMT"
        case docName = "DocName"
        case docNo = "DocNo"
        case invoiceNo = "InvoiceNo"
        case postDate = "PostDate"
        case qty = "QTY"
        case remarkA = "RemarkA"
        case remarkE = "RemarkE"
        case settDate = "SettDate"
        case sharePrice = "SharePrice"
        case status = "Status"
        case symbol = "Symbol"
        case totalComm = "TotalComm"
        case totalCredit = "TotalCredit"
        case totalDebit = "TotalDebit"
        case CUR_CODE = "CUR_CODE"
    }
}

struct GetStatementOfAccountUIModel: Codable {
    
    var avgPrice, balance, crAmt: Double?
    var clientID, clientNameA, clientNameE, curNameA: String?
    var curNameE: String?
    var dbAmt: Double?
    var docName, docNo, invoiceNo, postDate: String?
    var qty: Double?
    var remarkA, remarkE, settDate: String?
    var sharePrice: Double?
    var status, symbol: String?
    var totalComm, totalCredit, totalDebit: Double?
    var CUR_CODE: String?
        
}

extension GetStatementOfAccountUIModel {
    static func mapToUIModel(_ model:GetStatementOfAccountResponseModel)->Self {
        return  GetStatementOfAccountUIModel(avgPrice: model.avgPrice ?? 0, balance: model.balance ?? 0, crAmt: model.crAmt ?? 0, clientID: model.clientID ?? "", clientNameA: model.curNameA ?? "", clientNameE: model.clientNameE ?? "", curNameA: model.curNameA ?? "", curNameE: model.curNameE ?? "", dbAmt: model.dbAmt ?? 0, docName: model.docName ?? "", docNo: model.docNo ?? "", invoiceNo: model.invoiceNo ?? "", postDate: model.postDate ?? "", qty: model.qty ?? 0, remarkA: model.remarkA ?? "", remarkE: model.remarkE ?? "", settDate: model.settDate ?? "", sharePrice: model.sharePrice ?? 0, status: model.status ?? "", symbol: model.symbol ?? "", totalComm: model.totalComm ?? 0, totalCredit: model.totalCredit ?? 0, totalDebit: model.totalDebit ?? 0, CUR_CODE: model.CUR_CODE ?? "")
    }
    
    static func testUIModel() -> Self {
        return GetStatementOfAccountUIModel(avgPrice: 0, balance: 0, crAmt: 0, clientID: "", clientNameA: "", clientNameE: "", curNameA: "", curNameE: "", dbAmt: 0, docName: "", docNo: "", invoiceNo: "", postDate: "", qty: 0, remarkA: "", remarkE: "", settDate: "", sharePrice: 0, status: "", symbol: "", totalComm: 0, totalCredit: 0, totalDebit: 0, CUR_CODE: "")
    }
}
