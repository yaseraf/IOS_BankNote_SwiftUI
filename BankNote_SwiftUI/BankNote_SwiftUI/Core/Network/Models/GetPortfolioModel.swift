//
//  GetPortfolioModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 17/09/2025.
//

import Foundation


struct GetPortfolioRequestModel {
    
}

struct GetPortfolioResponseModel: Codable {
    let accountSummaries: AccountSummaries?
       let portfolioChart: PortfolioChart?
       let portfolioChartAll: PortfolioChartAll?
       let portfolioes: [Portfolio]?

       enum CodingKeys: String, CodingKey {
           case accountSummaries = "AccountSummaries"
           case portfolioChart = "PortfolioChart"
           case portfolioChartAll = "PortfolioChartAll"
           case portfolioes = "Portfolioes"
       }
   }

   // MARK: - AccountSummaries
   struct AccountSummaries: Codable {
       let alternateOpportunity, balance, blockedBalance, buyPower: String?
       let currentMarginLimit, expectedProfitLoss, facilityAmount, holdingCost: String?
       let interestRatePerc, maintMArgin, maintenanceMargin, marginAmount: String?
       let marketValue, netProfitLoss, realisedProfitLoss, remainingBalance: String?
       let unUtlizedMarginAmount, unpaidInterset, unsettledBalance, withdrowal: String?

       enum CodingKeys: String, CodingKey {
           case alternateOpportunity = "AlternateOpportunity"
           case balance = "Balance"
           case blockedBalance = "BlockedBalance"
           case buyPower = "BuyPower"
           case currentMarginLimit = "CurrentMarginLimit"
           case expectedProfitLoss = "ExpectedProfitLoss"
           case facilityAmount = "FacilityAmount"
           case holdingCost = "HoldingCost"
           case interestRatePerc = "InterestRatePerc"
           case maintMArgin = "MaintMArgin"
           case maintenanceMargin = "MaintenanceMargin"
           case marginAmount = "MarginAmount"
           case marketValue = "MarketValue"
           case netProfitLoss = "NetProfitLoss"
           case realisedProfitLoss = "RealisedProfitLoss"
           case remainingBalance = "RemainingBalance"
           case unUtlizedMarginAmount = "UnUtlizedMarginAmount"
           case unpaidInterset = "UnpaidInterset"
           case unsettledBalance = "UnsettledBalance"
           case withdrowal = "Withdrowal"
       }
   }

   // MARK: - PortfolioChart
   struct PortfolioChart: Codable {
       let chartData: [ChartDatum]?

       enum CodingKeys: String, CodingKey {
           case chartData = "ChartData"
       }
   }

   // MARK: - ChartDatum
   struct ChartDatum: Codable {
       let avg, tickerID: String?

       enum CodingKeys: String, CodingKey {
           case avg = "AVG"
           case tickerID = "TICKER_ID"
       }
   }

   // MARK: - PortfolioChartAll
   struct PortfolioChartAll: Codable {
       let chartDataa: [ChartDataa]?

       enum CodingKeys: String, CodingKey {
           case chartDataa = "ChartDataa"
       }
   }

   // MARK: - ChartDataa
   struct ChartDataa: Codable {
       let avg, costValue, qty, symbolAR: String?
       let symbolEN, tickerID, currency: String?

       enum CodingKeys: String, CodingKey {
           case avg = "AVG"
           case costValue = "CostValue"
           case qty = "Qty"
           case symbolAR = "Symbol_AR"
           case symbolEN = "Symbol_EN"
           case tickerID = "TICKER_ID"
           case currency
       }
   }

   // MARK: - Portfolioe
   struct Portfolio: Codable {
       let id = UUID().uuidString
       
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
       let totalEPLossPerc, totalExpectedProfitLoss, totalExpectedSellComm, totalMarketValue: Double?
       let totalNetProfitLoss, totalRealizedProfitLoss: Double?
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
                   case totalEPLossPerc = "Total_E_P_Loss_perc"
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
       
       static func initializer() -> Self {
           return Portfolio(assetNameE: "", companyShortA: "", companyShortE: "", contractSize: "", custodianA: "", custodianE: "", clientID: "", compID: "", companyNameA: "", companyNameE: "", countryCode: "", curCode: "", currDiff: 0, custodianID: "", ePrice: 0, exchange: "", isderivative: "", isin: "", islamic: "", locBookedPSValue: 0, locNValue: 0, mainClinetID: "", marketType: "", nValue: 0, pCost: 0, portID: "", portName: "", pPerc: 0, pProf: 0, prClosePrice: 0, prPriceDate: "", precision: "", profit: 0, profitLossInAED: "", psValue: 0, qtySettled: 0, qtyT0: 0, qtyT1: 0, qtyT2: 0, qtyUnsettled: 0, qty: 0, qtyToTransfer: 0, rate: 0, realizedToday: "", sectorA: "", sectorE: "", symbol: "", totalEPLossPerc: 0, totalExpectedProfitLoss: 0, totalExpectedSellComm: 0, totalMarketValue: 0, totalNetProfitLoss: 0, totalRealizedProfitLoss: 0, tradingProfitLOC: "", typeA: "", typeE: "", usrCode: "")
       }
   }

struct GetPortfolioUIModel {
    var accountSummaries: AccountSummaries
    var portfolioChart: PortfolioChart
    var portfolioChartAll: PortfolioChartAll
    var portfolioes: [Portfolio]
    
    static func mapToUIModel(_ model:GetPortfolioResponseModel)->Self {
        return  GetPortfolioUIModel(accountSummaries: model.accountSummaries ?? AccountSummaries(alternateOpportunity: "", balance: "", blockedBalance: "", buyPower: "", currentMarginLimit: "", expectedProfitLoss: "", facilityAmount: "", holdingCost: "", interestRatePerc: "", maintMArgin: "", maintenanceMargin: "", marginAmount: "", marketValue: "", netProfitLoss: "", realisedProfitLoss: "", remainingBalance: "", unUtlizedMarginAmount: "", unpaidInterset: "", unsettledBalance: "", withdrowal: ""), portfolioChart: model.portfolioChart ?? PortfolioChart(chartData: []), portfolioChartAll: model.portfolioChartAll ?? PortfolioChartAll(chartDataa: []), portfolioes: model.portfolioes ?? [])
    }
    
    static func initializer() -> Self {
        return GetPortfolioUIModel(accountSummaries: AccountSummaries(alternateOpportunity: "", balance: "", blockedBalance: "", buyPower: "", currentMarginLimit: "", expectedProfitLoss: "", facilityAmount: "", holdingCost: "", interestRatePerc: "", maintMArgin: "", maintenanceMargin: "", marginAmount: "", marketValue: "", netProfitLoss: "", realisedProfitLoss: "", remainingBalance: "", unUtlizedMarginAmount: "", unpaidInterset: "", unsettledBalance: "", withdrowal: ""), portfolioChart: PortfolioChart(chartData: []), portfolioChartAll: PortfolioChartAll(chartDataa: []), portfolioes: [])

    }

}
