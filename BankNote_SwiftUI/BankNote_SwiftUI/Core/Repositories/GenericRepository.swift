//
//  GenericRepository.swift
//  QSC_SwiftUI
//
//  Created by FIT on 25/08/2025.
//

import Foundation
protocol LookupsRepositoryProtocol {
    func GetLookups(route: GenericRoute, completion: @escaping(Result<[GetLookupsResponseModel], NetworkError>) -> Void) async
}

class LookupsRepository: LookupsRepositoryProtocol {
    func GetLookups(route: GenericRoute, completion: @escaping (Result<[GetLookupsResponseModel], NetworkError>) -> Void) async {
        await RequestApi(route: route, responseType: [GetLookupsResponseModel].self, completion: completion).requestApi()
    }
}
