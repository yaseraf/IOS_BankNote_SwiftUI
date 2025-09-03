//
//  AuthRoute.swift
//  QSC
//
//  Created by FIT on 27/07/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation
enum HomeRoute:APITargetType{
    
//    case updateInvestmentType(requestModel: UpdateInvestmentTypeRequestModel)
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
            case .GetAllProfilesLookupsByUserCode, .GetMarketWatchByProfileID, .GetExchangeSummary:
                return .get
            }
        }
    }
    
    var requestType: APITypeOfRequest{
        switch self {
        case .GetAllProfilesLookupsByUserCode, .GetMarketWatchByProfileID, .GetExchangeSummary:
                .requestPlain
        }
    }
}
