//
//  GetCompaniesLookupsModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 17/09/2025.
//

import Foundation

struct GetCompaniesLookupsRequestModel {
    
}

struct GetCompaniesLookupsResponseModel: Codable {
    let aboutDescE, aboutDescA: String?
    let allowdBuyLimit, companyA, companyE, currCode: String?
    let exchange, ipoValidityDate, isCryptoSymbol, isDerivative: String?
    let isUsOnline, isFund, isIPOQuickSell, isMargin: String?
    let isValidateMinMax, isinCode, lastDay, marketType, precision: String?
    let shortName, shortNamea, symbol, symbolCompanyA: String?
    let symbolCompanyDesc, symbolCompanyE, symbolID, templateMargin: String?
    let allowShortSell: String?

    enum CodingKeys: String, CodingKey {
        case aboutDescE = "ABOUT_DESC_E"
        case aboutDescA = "ABOUT_DESC_A"
        case allowdBuyLimit = "AllowdBuyLimit"
        case companyA = "CompanyA"
        case companyE = "CompanyE"
        case currCode = "CurrCode"
        case exchange = "Exchange"
        case ipoValidityDate = "IPOValidityDate"
        case isCryptoSymbol = "IS_CRYPTO_SYMBOL"
        case isDerivative = "IS_DERIVATIVE"
        case isUsOnline = "IS_US_ONLINE"
        case isFund = "IsFund"
        case isIPOQuickSell = "IsIPOQuickSell"
        case isMargin = "IsMargin"
        case isValidateMinMax = "IsValidateMinMax"
        case isinCode = "IsinCode"
        case lastDay = "LastDay"
        case marketType = "MarketType"
        case precision = "Precision"
        case shortName = "SHORT_NAME"
        case shortNamea = "SHORT_NAMEA"
        case symbol = "Symbol"
        case symbolCompanyA = "SymbolCompanyA"
        case symbolCompanyDesc = "SymbolCompanyDesc"
        case symbolCompanyE = "SymbolCompanyE"
        case symbolID = "SymbolID"
        case templateMargin = "TemplateMargin"
        case allowShortSell = "allow_short_sell"
    }
}


struct GetCompaniesLookupsUIModel: Codable{
    let aboutDescE, aboutDescA: String?
    let allowdBuyLimit, companyA, companyE, currCode: String?
    let exchange, ipoValidityDate, isCryptoSymbol, isDerivative: String?
    let isUsOnline, isFund, isIPOQuickSell, isMargin: String?
    let isValidateMinMax, isinCode, lastDay, marketType, precision: String?
    let shortNameE, shortNameA, symbol, symbolCompanyA: String
    let symbolCompanyDesc, symbolCompanyE, symbolID, templateMargin: String?
    let allowShortSell: String?
}

extension GetCompaniesLookupsUIModel {
    static func mapToUIModel(_ model:GetCompaniesLookupsResponseModel)->Self {
        return  GetCompaniesLookupsUIModel(aboutDescE: model.aboutDescE ?? "", aboutDescA: model.aboutDescA ?? "" ,allowdBuyLimit: model.allowdBuyLimit ?? "", companyA: model.companyA ?? "", companyE: model.companyE ?? "", currCode: model.currCode ?? "", exchange: model.exchange ?? "", ipoValidityDate: model.ipoValidityDate ?? "", isCryptoSymbol: model.isCryptoSymbol ?? "", isDerivative: model.isDerivative ?? "", isUsOnline: model.isUsOnline ?? "", isFund: model.isFund ?? "", isIPOQuickSell: model.isIPOQuickSell ?? "", isMargin: model.isMargin ?? "", isValidateMinMax: model.isValidateMinMax ?? "", isinCode: model.isinCode ?? "", lastDay: model.lastDay, marketType: model.marketType ?? "", precision: model.precision ?? "", shortNameE: model.shortName ?? "", shortNameA: model.shortNamea ?? "", symbol: model.symbol ?? "", symbolCompanyA: model.symbolCompanyA ?? "", symbolCompanyDesc: model.symbolCompanyDesc ?? "", symbolCompanyE: model.symbolCompanyE ?? "", symbolID: model.symbolID ?? "", templateMargin: model.templateMargin ?? "", allowShortSell: model.allowShortSell ?? "")
    }
    
    static func testUIModel() ->Self {
        return GetCompaniesLookupsUIModel(aboutDescE: "", aboutDescA: "" ,allowdBuyLimit: "", companyA: "", companyE: "", currCode: "", exchange: "", ipoValidityDate: "", isCryptoSymbol: "", isDerivative: "", isUsOnline: "", isFund: "", isIPOQuickSell: "", isMargin: "", isValidateMinMax: "", isinCode: "", lastDay: "", marketType: "", precision: "", shortNameE: "", shortNameA: "", symbol: "", symbolCompanyA: "", symbolCompanyDesc: "", symbolCompanyE: "", symbolID: "", templateMargin: "", allowShortSell: "")
    }
}

extension GetCompaniesLookupsUIModel {
    init(entity: CompanyEntity) {
        self.aboutDescA = entity.aboutDescA ?? ""
        self.aboutDescE = entity.aboutDescE ?? ""
        self.allowdBuyLimit = entity.allowdBuyLimit
        self.allowShortSell = entity.allowShortSell
        self.companyA = entity.companyA ?? ""
        self.companyE = entity.companyE ?? ""
        self.currCode = entity.currCode ?? ""
        self.exchange = entity.exchange ?? ""
        self.ipoValidityDate = entity.ipoValidityDate ?? ""
        self.isCryptoSymbol = entity.isCryptoSymbol
        self.isDerivative = entity.isDerivative
        self.isFund = entity.isFund
        self.isIPOQuickSell = entity.isIPOQuickSell
        self.isMargin = entity.isMargin
        self.isUsOnline = entity.isUsOnline
        self.isValidateMinMax = entity.isValidateMinMax
        self.isinCode = entity.isinCode ?? ""
        self.lastDay = entity.lastDay ?? ""
        self.marketType = entity.marketType ?? ""
        self.precision = entity.precision
        self.shortNameA = entity.shortNameA ?? ""
        self.shortNameE = entity.shortNameE ?? ""
        self.symbol = entity.symbol ?? ""
        self.symbolCompanyA = entity.symbolCompanyA ?? ""
        self.symbolCompanyDesc = entity.symbolCompanyDesc ?? ""
        self.symbolCompanyE = entity.symbolCompanyE ?? ""
        self.symbolID = entity.symbolID
        self.templateMargin = entity.templateMargin
    }
}

