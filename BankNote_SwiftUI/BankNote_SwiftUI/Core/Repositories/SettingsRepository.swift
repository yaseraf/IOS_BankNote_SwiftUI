//
//  TradeRepository.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 18/09/2025.
//

import Foundation
protocol SettingsRepositoryProtocol {
    func UsersLogOff(route: SettingsRoute, completion: @escaping(Result<EmptyResponseModel, NetworkError>) -> Void) async
}

class SettingsRepository: SettingsRepositoryProtocol {
    func UsersLogOff(route: SettingsRoute, completion: @escaping (Result<EmptyResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route,responseType: EmptyResponseModel.self, completion: completion).requestApi()
    }
}
