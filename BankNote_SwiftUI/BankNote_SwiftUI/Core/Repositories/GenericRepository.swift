//
//  GenericRepository.swift
//  QSC_SwiftUI
//
//  Created by FIT on 25/08/2025.
//

import Foundation
protocol GenericRepositoryProtocol {
    func GetLookups(route: GenericRoute, completion: @escaping(Result<[GetLookupsResponseModel], NetworkError>) -> Void) async
}

class GenericRepository: GenericRepositoryProtocol {
    func GetLookups(route: GenericRoute, completion: @escaping (Result<[GetLookupsResponseModel], NetworkError>) -> Void) async {
        await RequestApi(route: route, responseType: [GetLookupsResponseModel].self, completion: completion).requestApi()
    }
}
