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

        }
    }
    
    var method: APIMethodType{
        get{
            switch self {
            case .GetAllProfilesLookupsByUserCode, .GetMarketWatchByProfileID, .GetExchangeSummary, .getUserAccounts, .getPortfolio:
                return .get
            }
        }
    }
    
    var requestType: APITypeOfRequest{
        switch self {
        case .GetAllProfilesLookupsByUserCode, .GetMarketWatchByProfileID, .GetExchangeSummary, .getUserAccounts, .getPortfolio:
                .requestPlain
        }
    }
}
