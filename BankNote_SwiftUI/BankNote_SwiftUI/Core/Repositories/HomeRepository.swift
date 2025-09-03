//
//  AuthRepository.swift
//  QSC_SwiftUI
//
//  Created by FIT on 20/08/2025.
//

import Foundation
protocol HomeRepositoryProtocol {
    func GetAllProfilesLookupsByUserCode (route:HomeRoute, completion: @escaping(Result<[GetAllProfilesLookupsByUserCodeResponseModel], NetworkError>) -> Void) async
    func GetMarketWatchByProfileID(route: HomeRoute, completion: @escaping(Result<[GetMarketWatchByProfileIDResponseModel], NetworkError>) -> Void) async
    func GetExchangeSummary(route: HomeRoute, completion: @escaping(Result<[GetExchangeSummaryResponseModel], NetworkError>) -> Void) async
}

class HomeRepository: HomeRepositoryProtocol {
    func GetExchangeSummary(route: HomeRoute, completion: @escaping (Result<[GetExchangeSummaryResponseModel], NetworkError>) -> Void) async {
        await RequestApi(route: route,responseType: [GetExchangeSummaryResponseModel].self, completion: completion).requestApi()
    }
    
    func GetAllProfilesLookupsByUserCode(route: HomeRoute, completion: @escaping (Result<[GetAllProfilesLookupsByUserCodeResponseModel], NetworkError>) -> Void) async {
        await RequestApi(route: route,responseType: [GetAllProfilesLookupsByUserCodeResponseModel].self, completion: completion).requestApi()
    }
    func GetMarketWatchByProfileID(route: HomeRoute, completion: @escaping (Result<[GetMarketWatchByProfileIDResponseModel], NetworkError>) -> Void) async {
        await RequestApi(route: route, responseType: [GetMarketWatchByProfileIDResponseModel].self, completion: completion).requestApi()
    }

}
