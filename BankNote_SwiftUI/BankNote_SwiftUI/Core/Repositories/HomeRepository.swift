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
    func getUserAccounts(route: HomeRoute, completion: @escaping(Result<[GetUserAccountsResponseModel], NetworkError>) -> Void) async
    func getPortfolio(route: HomeRoute, completion: @escaping(Result<GetPortfolioResponseModel, NetworkError>) -> Void) async
    func GetALLMarketWatchBySymbol(route: HomeRoute, completion: @escaping(Result<GetALLMarketWatchBySymbolResponseModel, NetworkError>) -> Void) async
    func GetAllMarketNewsBySymbol(route: HomeRoute, completion: @escaping(Result<[GetAllMarketNewsBySymbolResponseModel], NetworkError>) -> Void) async
    func GetExpectedProfitLoss(route: HomeRoute, completion: @escaping(Result<[GetExpectedProfitLossResponseModel], NetworkError>) -> Void) async
    func GetRiskManagement(route: HomeRoute, completion: @escaping(Result<GetRiskManagementResponseModel, NetworkError>) -> Void) async

}

class HomeRepository: HomeRepositoryProtocol {
    func getPortfolio(route: HomeRoute, completion: @escaping (Result<GetPortfolioResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route, responseType: GetPortfolioResponseModel.self, completion: completion).requestApi()
    }
    
    func getUserAccounts(route: HomeRoute, completion: @escaping (Result<[GetUserAccountsResponseModel], NetworkError>) -> Void) async {
        await RequestApi(route: route, responseType: [GetUserAccountsResponseModel].self, completion: completion).requestApi()
    }
    
    func GetExchangeSummary(route: HomeRoute, completion: @escaping (Result<[GetExchangeSummaryResponseModel], NetworkError>) -> Void) async {
        await RequestApi(route: route,responseType: [GetExchangeSummaryResponseModel].self, completion: completion).requestApi()
    }
    
    func GetAllProfilesLookupsByUserCode(route: HomeRoute, completion: @escaping (Result<[GetAllProfilesLookupsByUserCodeResponseModel], NetworkError>) -> Void) async {
        await RequestApi(route: route,responseType: [GetAllProfilesLookupsByUserCodeResponseModel].self, completion: completion).requestApi()
    }
    func GetMarketWatchByProfileID(route: HomeRoute, completion: @escaping (Result<[GetMarketWatchByProfileIDResponseModel], NetworkError>) -> Void) async {
        await RequestApi(route: route, responseType: [GetMarketWatchByProfileIDResponseModel].self, completion: completion).requestApi()
    }
    func GetALLMarketWatchBySymbol(route: HomeRoute, completion: @escaping (Result<GetALLMarketWatchBySymbolResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route, responseType: GetALLMarketWatchBySymbolResponseModel.self, completion: completion).requestApi()
    }
    func GetAllMarketNewsBySymbol(route: HomeRoute, completion: @escaping (Result<[GetAllMarketNewsBySymbolResponseModel], NetworkError>) -> Void) async {
        await RequestApi(route: route, responseType: [GetAllMarketNewsBySymbolResponseModel].self, completion: completion).requestApi()
    }
    func GetExpectedProfitLoss(route: HomeRoute, completion: @escaping (Result<[GetExpectedProfitLossResponseModel], NetworkError>) -> Void) async {
        await RequestApi(route: route, responseType: [GetExpectedProfitLossResponseModel].self, completion: completion).requestApi()
    }
    func GetRiskManagement(route: HomeRoute, completion: @escaping (Result<GetRiskManagementResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route, responseType: GetRiskManagementResponseModel.self, completion: completion).requestApi()
    }

}
