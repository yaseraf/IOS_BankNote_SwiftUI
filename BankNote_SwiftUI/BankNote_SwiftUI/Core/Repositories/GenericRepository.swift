//
//  GenericRepository.swift
//  QSC_SwiftUI
//
//  Created by FIT on 25/08/2025.
//

import Foundation
protocol LookupsRepositoryProtocol {
    func GetLookups(route: GenericRoute, completion: @escaping(Result<[GetLookupsResponseModel], NetworkError>) -> Void) async
    func GetCompaniesLookups(route: HomeRoute, completion: @escaping(Result<[GetCompaniesLookupsResponseModel], NetworkError>) -> Void) async
}

class LookupsRepository: LookupsRepositoryProtocol {
    func GetLookups(route: GenericRoute, completion: @escaping (Result<[GetLookupsResponseModel], NetworkError>) -> Void) async {
        await RequestApi(route: route, responseType: [GetLookupsResponseModel].self, completion: completion).requestApi()
    }
    func GetCompaniesLookups(route: HomeRoute, completion: @escaping (Result<[GetCompaniesLookupsResponseModel], NetworkError>) -> Void) async {
        await RequestApi(route: route, responseType: [GetCompaniesLookupsResponseModel].self, completion: completion).requestApi()
    }
}
