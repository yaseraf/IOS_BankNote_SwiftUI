//
//  GenericRoute.swift
//  QSC_SwiftUI
//
//  Created by FIT on 25/08/2025.
//

import Foundation

enum SettingsRoute:APITargetType{
    
    case UsersLogOff(requestModel: UsersLogOffRequestModel)

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
        case .UsersLogOff:
            return "GeneralWServices/UsersLogOff/\(KeyChainController().webCode ?? "")"
        }
    }
    
    var method: APIMethodType{
        get{
            switch self {
            case .UsersLogOff:
                return .post
            }
        }
    }
    
    var requestType: APITypeOfRequest{
        switch self {
        case .UsersLogOff:
                .requestPlain
        }
    }
}
