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
    func AddMarketWatchProfileName(route: HomeRoute, completion: @escaping(Result<AddMarketWatchProfileNameResponseModel, NetworkError>) -> Void) async
    func AddMarketWatchProfileSymbols(route: HomeRoute, completion: @escaping(Result<[AddMarketWatchProfileSymbolsResponseModel], NetworkError>) -> Void) async
    func DeleteMarketWatchProfileSymbols(route: HomeRoute, completion: @escaping(Result<DeleteMarketWatchProfileSymbolsResponseModel, NetworkError>) -> Void) async

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
    func AddMarketWatchProfileName(route: HomeRoute, completion: @escaping (Result<AddMarketWatchProfileNameResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route, responseType: AddMarketWatchProfileNameResponseModel.self, completion: completion).requestApi()
    }
    func AddMarketWatchProfileSymbols(route: HomeRoute, completion: @escaping (Result<[AddMarketWatchProfileSymbolsResponseModel], NetworkError>) -> Void) async {
        await RequestApi(route: route, responseType: [AddMarketWatchProfileSymbolsResponseModel].self, completion: completion).requestApi()
    }
    func DeleteMarketWatchProfileSymbols(route: HomeRoute, completion: @escaping (Result<DeleteMarketWatchProfileSymbolsResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route, responseType: DeleteMarketWatchProfileSymbolsResponseModel.self, completion: completion).requestApi()
    }

}
