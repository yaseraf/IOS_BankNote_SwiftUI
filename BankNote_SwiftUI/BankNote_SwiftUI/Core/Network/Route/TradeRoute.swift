//
//  GenericRoute.swift
//  QSC_SwiftUI
//
//  Created by FIT on 25/08/2025.
//

import Foundation

enum TradeRoute:APITargetType{
    
    case GetExchangeSummary(requestModel: GetExchangeSummaryRequestModel)
    case GetMarketWatchByProfileID(requestModel: GetMarketWatchByProfileIDRequestModel)
    case GetFullMarketNews(requestModel: GetAllMarketNewsRequestModel)

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
        case .GetExchangeSummary:
            return "MarektWServices/GetExchangeSummary/\(KeyChainController().webCode ?? "")"
        case .GetMarketWatchByProfileID:
            return "MarektWServices/GetMarketWatchByProfileID/\(UserDefaultController().profileID ?? "")/\(KeyChainController().webCode ?? "")"
        case .GetFullMarketNews:
            return "MarektWServices/GetFullMarketNews/\(KeyChainController().webCode ?? "")" // Get ALL news
        }
    }
    
    var method: APIMethodType{
        get{
            switch self {
            case .GetExchangeSummary, .GetMarketWatchByProfileID, .GetFullMarketNews:
                return .get
            }
        }
    }
    
    var requestType: APITypeOfRequest{
        switch self {
        case .GetExchangeSummary, .GetMarketWatchByProfileID, .GetFullMarketNews:
                .requestPlain
        }
    }
}
