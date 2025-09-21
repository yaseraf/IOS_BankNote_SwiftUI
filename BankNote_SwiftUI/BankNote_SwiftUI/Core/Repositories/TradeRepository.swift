//
//  TradeRepository.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 18/09/2025.
//

import Foundation
protocol TradeRepositoryProtocol {
    func GetExchangeSummary(route: TradeRoute, completion: @escaping(Result<[GetExchangeSummaryResponseModel], NetworkError>) -> Void) async
    func GetAllProfilesLookupsByUserCode(route: HomeRoute, completion: @escaping(Result<[GetAllProfilesLookupsByUserCodeResponseModel], NetworkError>) -> Void) async
    func GetMarketWatchByProfileID(route: TradeRoute, completion: @escaping(Result<[GetMarketWatchByProfileIDResponseModel], NetworkError>) -> Void) async
    func GetFullMarketNews(route: TradeRoute, completion: @escaping(Result<[GetAllMarketNewsResponseModel], NetworkError>) -> Void) async

}

class TradeRepository: TradeRepositoryProtocol {
    func GetExchangeSummary(route: TradeRoute, completion: @escaping (Result<[GetExchangeSummaryResponseModel], NetworkError>) -> Void) async {
        await RequestApi(route: route, responseType: [GetExchangeSummaryResponseModel].self, completion: completion).requestApi()
    }
    func GetAllProfilesLookupsByUserCode(route: HomeRoute, completion: @escaping (Result<[GetAllProfilesLookupsByUserCodeResponseModel], NetworkError>) -> Void) async {
        await RequestApi(route: route, responseType: [GetAllProfilesLookupsByUserCodeResponseModel].self, completion: completion).requestApi()
    }
    func GetMarketWatchByProfileID(route: TradeRoute, completion: @escaping (Result<[GetMarketWatchByProfileIDResponseModel], NetworkError>) -> Void) async {
        await RequestApi(route: route, responseType: [GetMarketWatchByProfileIDResponseModel].self, completion: completion).requestApi()
    }
    func GetFullMarketNews(route: TradeRoute, completion: @escaping (Result<[GetAllMarketNewsResponseModel], NetworkError>) -> Void) async {
        await RequestApi(route: route, responseType: [GetAllMarketNewsResponseModel].self, completion: completion).requestApi()
    }
}
