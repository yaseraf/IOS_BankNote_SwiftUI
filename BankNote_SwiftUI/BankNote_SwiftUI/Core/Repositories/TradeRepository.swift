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
}

class TradeRepository: TradeRepositoryProtocol {
    func GetExchangeSummary(route: TradeRoute, completion: @escaping (Result<[GetExchangeSummaryResponseModel], NetworkError>) -> Void) async {
        await RequestApi(route: route, responseType: [GetExchangeSummaryResponseModel].self, completion: completion).requestApi()
    }
    func GetAllProfilesLookupsByUserCode(route: HomeRoute, completion: @escaping (Result<[GetAllProfilesLookupsByUserCodeResponseModel], NetworkError>) -> Void) async {
        await RequestApi(route: route, responseType: [GetAllProfilesLookupsByUserCodeResponseModel].self, completion: completion).requestApi()
    }
}
