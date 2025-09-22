//
//  TradeUseCase.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 18/09/2025.
//

import Foundation
protocol SettingsUseCaseProtocol{
    func UsersLogOff(requestModel: UsersLogOffRequestModel, completion: @escaping(Result<UsersLogOffUIModel, NetworkError>) -> Void) async

}

class SettingsUseCase {
    private let repository: SettingsRepositoryProtocol
    init(repository: SettingsRepositoryProtocol = SettingsRepository()) {
        self.repository = repository
    }
}

extension SettingsUseCase: SettingsUseCaseProtocol {
    func UsersLogOff(requestModel: UsersLogOffRequestModel, completion: @escaping (Result<UsersLogOffUIModel, NetworkError>) -> Void) async {
        let route = SettingsRoute.UsersLogOff(requestModel: requestModel)
        await repository.UsersLogOff(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = UsersLogOffUIModel.mapToUIModel(responseModel)
                completion(.success(uiModel))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
