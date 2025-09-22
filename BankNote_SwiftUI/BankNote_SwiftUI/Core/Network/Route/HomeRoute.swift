//
//  AuthRoute.swift
//  QSC
//
//  Created by FIT on 27/07/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation
enum HomeRoute:APITargetType{
    
    case getUserAccounts(requestModel: GetUserAccountsRequestModel)
    case getPortfolio(requestModel: GetPortfolioRequestModel)
    case GetAllProfilesLookupsByUserCode(requestModel: GetAllProfilesLookupsByUserCodeRequestModel)
    case GetMarketWatchByProfileID(requestModel: GetMarketWatchByProfileIDRequestModel)
    case GetExchangeSummary(requestModel: GetExchangeSummaryRequestModel)
    case GetCompaniesLookups(requestModel: GetCompaniesLookupsRequestModel)
    case GetALLMarketWatchBySymbol(requestModel: GetALLMarketWatchBySymbolRequestModel)
    case GetAllMarketNewsBySymbol(requestModel: GetAllMarketNewsBySymbolRequestModel)
    case GetExpectedProfitLoss(requestModel: GetExpectedProfitLossRequestModel)

    var baseURL: URL{
        get{
            return URL(string: AppEnvironmentController.currentNetworkConfiguration.basePath
                       + path)!
        }
    }
    
    var headers: [String : String]{
        get{
            switch self {
                
            default:
                return  NetworkUtility.getHeader(.withoutToken)
                
            }
        }
    }
    
    func getCurrentDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ddMMyyyyHHmmss"
        let currentDate = Date()
        let dateString = dateFormatter.string(from: currentDate)
        return dateString
    }

    
    var path: String{
        switch self {
        case .getUserAccounts:
            return "GeneralWServices/GetUserAccounts/\(KeyChainController().webCode ?? "")"
        case .getPortfolio:
            return "FinancialWServices/GetPortfolioAndAccSumAndChart/\(KeyChainController().mainClientID ?? "")/\(KeyChainController().clientID ?? "")/\(KeyChainController().webCode ?? "")/\(UserDefaultController().currentDate ?? "")/\(KeyChainController().brokerID ?? "")/\(KeyChainController().UCODE ?? "")"
        case .GetAllProfilesLookupsByUserCode:
            return "MarektWServices/GetAllProfilesLookupsByUSerCode/\(KeyChainController().webCode ?? "")"
        case .GetMarketWatchByProfileID:
            return "MarektWServices/GetMarketWatchByProfileID/\(UserDefaultController().profileID ?? "")/\(KeyChainController().webCode ?? "")"
        case .GetExchangeSummary:
            return "MarektWServices/GetExchangeSummary/\(KeyChainController().webCode ?? "")"
        case .GetCompaniesLookups:
            return "GeneralWServices/GetCompaniesLookups/\(KeyChainController().webCode ?? "")"
        case .GetALLMarketWatchBySymbol:
            return "MarektWServices/GetALLMarketWatchBySymbol/\(KeyChainController().webCode ?? "")/\(UserDefaultController().selectedSymbol ?? "")/\(UserDefaultController().selectedSymbolType ?? "")"
        case .GetAllMarketNewsBySymbol:
            return "GeneralWServices/GetAllMarketNewsBySymbol/\(UserDefaultController().selectedSymbol ?? "")/\(KeyChainController().webCode ?? "")"
        case .GetExpectedProfitLoss:
            return "FinancialWServices/GetExpectedProfitLoss/\(KeyChainController.shared().mainClientID ?? "")/\(KeyChainController.shared().clientID ?? "")/\(KeyChainController.shared().webCode ?? "")/\(getCurrentDateString())/\(KeyChainController.shared().brokerID ?? "")"


        }
    }
    
    var method: APIMethodType{
        get{
            switch self {
            case .GetAllProfilesLookupsByUserCode, .GetMarketWatchByProfileID, .GetExchangeSummary, .getUserAccounts, .getPortfolio, .GetCompaniesLookups, .GetALLMarketWatchBySymbol, .GetAllMarketNewsBySymbol, .GetExpectedProfitLoss:
                return .get
            }
        }
    }
    
    var requestType: APITypeOfRequest{
        switch self {
        case .GetAllProfilesLookupsByUserCode, .GetMarketWatchByProfileID, .GetExchangeSummary, .getUserAccounts, .getPortfolio, .GetCompaniesLookups, .GetALLMarketWatchBySymbol, .GetAllMarketNewsBySymbol, .GetExpectedProfitLoss:
                .requestPlain
        }
    }
}
