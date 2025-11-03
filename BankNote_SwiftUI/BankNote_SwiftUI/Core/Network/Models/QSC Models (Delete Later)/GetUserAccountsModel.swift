//
//  GetUserAccountsModel.swift
//  mahfazati
//
//  Created by FIT on 05/09/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation

struct GetUserAccountsRequestModel: Codable {
    
}

struct GetUserAccountsResponseModel: Codable {
    
        let ALLOW_DERIV_TRADING: String?
        let AccType: String?
        let AccountDesc: String?
        let AccountID: String?
        let BankInterfaceStatus: String?
        let CLIENT_TYPE: String?
        let CL_BANK_ID: String?
        let CL_BANK_ID2: String?
        let CL_CLIENT_TYPE: String?
        let CUR_CODE: String?
        let ClientID: String?
        let ClientNameA: String?
        let ClientNameE: String?
        let Email_Address: String?
        let Exchange: String?
        let ExchangeID: String?
        let Exchange_DESC_A: String?
        let Exchange_DESC_E: String?
        let INDIVIDUAL: String?
        let IS_DEFAULT_ACC: String?
        let IS_INTER: String?
        let IS_Islamic: String?
        let IS_MARGIN_ACC: String?
        let IS_SAMEDAY: String?
        let MainClientID: String?
        let MainClientNameA: String?
        let MainClientNameE: String?
        let Mobile_NO: String?
        let NIN: String?
        let POA_EXPIRY: String?
        let POST_TO_COREBK: String?
        let PreferredLang: String?
        let cl_allow_short_sell_market: String?
}

protocol GetUserAccountsDelegate{
    func onSelect(model:GetUserAccountsUIModel)
}

protocol AccountDetailsDelegate{
    func onDismiss(model:GetUserAccountsUIModel)
    func refreshHomeScreen()
}

struct GetUserAccountsUIModel:  Codable{
    let ALLOW_DERIV_TRADING: String?
    var AccType: String?
    let AccountDesc: String?
    var AccountID: String?
    let BankInterfaceStatus: String?
    let CLIENT_TYPE: String?
    let CL_BANK_ID: String?
    let CL_BANK_ID2: String?
    let CL_CLIENT_TYPE: String?
    let CUR_CODE: String
    let ClientID: String?
    let ClientNameA: String?
    let ClientNameE: String?
    let Email_Address: String?
    let Exchange: String?
    let ExchangeID: String?
    let Exchange_DESC_A: String?
    let Exchange_DESC_E: String?
    let INDIVIDUAL: String?
    let IS_DEFAULT_ACC: String?
    let IS_INTER: String?
    let IS_Islamic: String?
    let IS_MARGIN_ACC: String?
    let IS_SAMEDAY: String?
    let MainClientID: String?
    let MainClientNameA: String?
    let MainClientNameE: String?
    let Mobile_NO: String?
    let NIN: String?
    let POA_EXPIRY: String?
    let POST_TO_COREBK: String?
    let PreferredLang: String?
    let cl_allow_short_sell_market: String?
    
}

extension GetUserAccountsUIModel {
    static func mapToUIModel(_ model:GetUserAccountsResponseModel)->Self {
        return  GetUserAccountsUIModel(ALLOW_DERIV_TRADING: model.ALLOW_DERIV_TRADING ?? "", AccType: model.AccType ?? "", AccountDesc: model.AccountDesc ?? "", AccountID: model.AccountID ?? "", BankInterfaceStatus: model.BankInterfaceStatus ?? "", CLIENT_TYPE: model.CLIENT_TYPE ?? "", CL_BANK_ID: model.CL_BANK_ID ?? "", CL_BANK_ID2: model.CL_BANK_ID2 ?? "", CL_CLIENT_TYPE: model.CL_CLIENT_TYPE ?? "", CUR_CODE: model.CUR_CODE ?? "", ClientID: model.ClientID ?? "", ClientNameA: model.ClientNameA ?? "", ClientNameE: model.ClientNameE ?? "", Email_Address: model.Email_Address ?? "", Exchange: model.Exchange ?? "", ExchangeID: model.ExchangeID ?? "", Exchange_DESC_A: model.Exchange_DESC_A ?? "", Exchange_DESC_E: model.Exchange_DESC_E ?? "", INDIVIDUAL: model.INDIVIDUAL ?? "", IS_DEFAULT_ACC: model.IS_DEFAULT_ACC ?? "", IS_INTER: model.IS_INTER ?? "", IS_Islamic: model.IS_Islamic ?? "", IS_MARGIN_ACC: model.IS_MARGIN_ACC ?? "", IS_SAMEDAY: model.IS_SAMEDAY ?? "", MainClientID: model.MainClientID ?? "", MainClientNameA: model.MainClientNameA ?? "", MainClientNameE: model.MainClientNameE ?? "", Mobile_NO: model.Mobile_NO ?? "", NIN: model.NIN ?? "", POA_EXPIRY: model.POA_EXPIRY ?? "", POST_TO_COREBK: model.POST_TO_COREBK ?? "", PreferredLang: model.PreferredLang ?? "", cl_allow_short_sell_market: model.cl_allow_short_sell_market ?? "")
    }
    
    static func testUIModel() -> Self {
        return GetUserAccountsUIModel(ALLOW_DERIV_TRADING: "", AccType: "", AccountDesc: "", AccountID: "", BankInterfaceStatus: "", CLIENT_TYPE: "", CL_BANK_ID: "", CL_BANK_ID2: "", CL_CLIENT_TYPE: "", CUR_CODE: "", ClientID: "", ClientNameA: "", ClientNameE: "", Email_Address: "", Exchange: "", ExchangeID: "", Exchange_DESC_A: "", Exchange_DESC_E: "", INDIVIDUAL: "", IS_DEFAULT_ACC: "", IS_INTER: "", IS_Islamic: "", IS_MARGIN_ACC: "", IS_SAMEDAY: "", MainClientID: "", MainClientNameA: "", MainClientNameE: "", Mobile_NO: "", NIN: "", POA_EXPIRY: "", POST_TO_COREBK: "", PreferredLang: "", cl_allow_short_sell_market: "")
    }
}
