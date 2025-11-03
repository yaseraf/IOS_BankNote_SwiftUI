//
//  GetExpectedProfitLossModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 22/09/2025.
//

import Foundation

struct GetExpectedProfitLossRequestModel {
    
}

struct GetExpectedProfitLossResponseModel:Codable {
    let assetNameE, companyShortA, companyShortE, contractSize: String?
        let custodianA, custodianE, clientID, compID: String?
        let companyNameA, companyNameE, countryCode, curCode: String?
        let currDiff: Double?
        let custodianID: String?
        let ePrice: Double?
        let exchange, isderivative, isin, islamic: String?
        let locBookedPSValue, locNValue: Double?
        let mainClinetID, marketType: String?
        let nValue, pCost: Double?
        let portID, portName: String?
        let pPerc, pProf, prClosePrice: Double?
        let prPriceDate, precision: String?
        let profit: Double?
        let profitLossInAED: String?
        let psValue, qtySettled, qtyT0, qtyT1: Double?
        let qtyT2, qtyUnsettled, qty, qtyToTransfer: Double?
        let rate: Double?
        let realizedToday, sectorA, sectorE, symbol: String?
        let totalExpectedProfitLoss, totalExpectedSellComm, totalMarketValue, totalNetProfitLoss: Double?
        let totalRealizedProfitLoss: Double?
        let tradingProfitLOC, typeA, typeE, usrCode: String?

        enum CodingKeys: String, CodingKey {
            case assetNameE = "ASSET_NAME_E"
            case companyShortA = "COMPANY_SHORT_A"
            case companyShortE = "COMPANY_SHORT_E"
            case contractSize = "CONTRACT_SIZE"
            case custodianA = "CUSTODIAN_A"
            case custodianE = "CUSTODIAN_E"
            case clientID = "ClientID"
            case compID = "Comp_ID"
            case companyNameA = "CompanyNameA"
            case companyNameE = "CompanyNameE"
            case countryCode = "CountryCode"
            case curCode = "CurCode"
            case currDiff = "CurrDiff"
            case custodianID = "CustodianId"
            case ePrice = "EPrice"
            case exchange = "Exchange"
            case isderivative = "ISDERIVATIVE"
            case isin = "ISIN"
            case islamic = "ISLAMIC"
            case locBookedPSValue = "LocBookedPsValue"
            case locNValue = "LocNValue"
            case mainClinetID = "Main_clinet_id"
            case marketType = "MarketType"
            case nValue = "NValue"
            case pCost = "PCost"
            case portID = "PORT_ID"
            case portName = "PORT_NAME"
            case pPerc = "PPerc"
            case pProf = "PProf"
            case prClosePrice = "PrClosePrice"
            case prPriceDate = "PrPriceDate"
            case precision = "Precision"
            case profit = "Profit"
            case profitLossInAED = "Profit_loss_in_AED"
            case psValue = "PsValue"
            case qtySettled = "QTY_SETTLED"
            case qtyT0 = "QTY_T0"
            case qtyT1 = "QTY_T1"
            case qtyT2 = "QTY_T2"
            case qtyUnsettled = "QTY_UNSETTLED"
            case qty = "Qty"
            case qtyToTransfer = "QtyToTransfer"
            case rate = "Rate"
            case realizedToday = "Realized_Today"
            case sectorA = "SectorA"
            case sectorE = "SectorE"
            case symbol = "Symbol"
            case totalExpectedProfitLoss = "Total_Expected_Profit_Loss"
            case totalExpectedSellComm = "Total_Expected_Sell_Comm"
            case totalMarketValue = "Total_Market_Value"
            case totalNetProfitLoss = "Total_Net_Profit_Loss"
            case totalRealizedProfitLoss = "Total_Realized_Profit_Loss"
            case tradingProfitLOC = "TradingProfit_LOC"
            case typeA = "TypeA"
            case typeE = "TypeE"
            case usrCode = "USR_CODE"
        }
}

struct GetExpectedProfitLossUIModel {
    let assetNameE, companyShortA, companyShortE, contractSize: String?
    let custodianA, custodianE, clientID, compID: String?
    let companyNameA, companyNameE, countryCode, curCode: String?
    let currDiff: Double?
    let custodianID: String?
    let ePrice: Double?
    let exchange, isderivative, isin, islamic: String?
    let locBookedPSValue, locNValue: Double?
    let mainClinetID, marketType: String?
    let nValue, pCost: Double?
    let portID, portName: String?
    let pPerc, pProf, prClosePrice: Double?
    let prPriceDate, precision: String?
    let profit: Double?
    let profitLossInAED: String?
    let psValue, qtySettled, qtyT0, qtyT1: Double?
    let qtyT2, qtyUnsettled, qty, qtyToTransfer: Double?
    let rate: Double?
    let realizedToday, sectorA, sectorE, symbol: String?
    let totalExpectedProfitLoss, totalExpectedSellComm, totalMarketValue, totalNetProfitLoss: Double?
    let totalRealizedProfitLoss: Double?
    let tradingProfitLOC, typeA, typeE, usrCode: String?
    
    static func mapToUIModel(_ m:GetExpectedProfitLossResponseModel)->Self {
        return GetExpectedProfitLossUIModel(assetNameE: m.assetNameE ?? "", companyShortA: m.companyNameA ?? "", companyShortE: m.companyShortE ?? "", contractSize: m.contractSize ?? "", custodianA: m.custodianA ?? "", custodianE: m.custodianE ?? "", clientID: m.clientID ?? "", compID: m.compID ?? "", companyNameA: m.companyNameA ?? "", companyNameE: m.companyNameE ?? "", countryCode: m.countryCode ?? "", curCode: m.curCode ?? "", currDiff: m.currDiff ?? 0, custodianID: m.custodianID ?? "", ePrice: m.ePrice ?? 0, exchange: m.exchange ?? "", isderivative: m.isderivative ?? "", isin: m.isin ?? "", islamic: m.islamic ?? "", locBookedPSValue: m.locBookedPSValue ?? 0, locNValue: m.locNValue ?? 0, mainClinetID: m.mainClinetID ?? "", marketType: m.marketType ?? "", nValue: m.nValue ?? 0, pCost: m.pCost ?? 0, portID: m.portID ?? "", portName: m.portName ?? "", pPerc: m.pPerc ?? 0, pProf: m.pProf ?? 0, prClosePrice: m.prClosePrice ?? 0, prPriceDate: m.prPriceDate ?? "", precision: m.precision ?? "", profit: m.profit ?? 0, profitLossInAED: m.profitLossInAED ?? "", psValue: m.psValue ?? 0, qtySettled: m.qtySettled ?? 0, qtyT0: m.qtyT0 ?? 0, qtyT1: m.qtyT1 ?? 0, qtyT2: m.qtyT2 ?? 0, qtyUnsettled: m.qtyUnsettled ?? 0, qty: m.qty ?? 0, qtyToTransfer: m.qtyToTransfer ?? 0, rate: m.rate ?? 0, realizedToday: m.realizedToday ?? "", sectorA: m.sectorA ?? "", sectorE: m.sectorE ?? "", symbol: m.symbol ?? "", totalExpectedProfitLoss: m.totalExpectedProfitLoss ?? 0, totalExpectedSellComm: m.totalExpectedSellComm ?? 0, totalMarketValue: m.totalMarketValue ?? 0, totalNetProfitLoss: m.totalNetProfitLoss ?? 0, totalRealizedProfitLoss: m.totalRealizedProfitLoss ?? 0, tradingProfitLOC: m.tradingProfitLOC ?? "", typeA: m.typeA ?? "", typeE: m.typeE ?? "", usrCode: m.usrCode ?? "")
    }
    
    static func testUIModel() -> Self {
        return GetExpectedProfitLossUIModel(assetNameE: "", companyShortA: "", companyShortE: "", contractSize: "", custodianA: "", custodianE: "", clientID: "", compID: "", companyNameA: "", companyNameE: "", countryCode: "", curCode: "", currDiff: 0, custodianID: "", ePrice: 0, exchange: "", isderivative: "", isin: "", islamic: "", locBookedPSValue: 0, locNValue: 0, mainClinetID: "", marketType: "", nValue: 0, pCost: 0, portID: "", portName: "", pPerc: 0, pProf: 0, prClosePrice: 0, prPriceDate: "", precision: "", profit: 0, profitLossInAED: "", psValue: 0, qtySettled: 0, qtyT0: 0, qtyT1: 0, qtyT2: 0, qtyUnsettled: 0, qty: 0, qtyToTransfer: 0, rate: 0, realizedToday: "", sectorA: "", sectorE: "", symbol: "", totalExpectedProfitLoss: 0, totalExpectedSellComm: 0, totalMarketValue: 0, totalNetProfitLoss: 0, totalRealizedProfitLoss: 0, tradingProfitLOC: "", typeA: "", typeE: "", usrCode: "")
    }
}
