//
//  TradeUseCase.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 18/09/2025.
//

import Foundation
protocol TradeUseCaseProtocol{
    func GetExchangeSummary(requestModel: GetExchangeSummaryRequestModel, completion: @escaping(Result<[GetExchangeSummaryUIModel], NetworkError>) -> Void) async
    func GetAllProfilesLookupsByUserCode(requestModel: GetAllProfilesLookupsByUserCodeRequestModel, completion: @escaping(Result<[GetAllProfilesLookupsByUserCodeUIModel], NetworkError>) -> Void) async
}

class TradeUseCase {
    private let repository: TradeRepositoryProtocol
    init(repository: TradeRepositoryProtocol = TradeRepository()) {
        self.repository = repository
    }
}

extension TradeUseCase: TradeUseCaseProtocol {
    func GetExchangeSummary(requestModel: GetExchangeSummaryRequestModel, completion: @escaping (Result<[GetExchangeSummaryUIModel], NetworkError>) -> Void) async {
        let route = TradeRoute.GetExchangeSummary(requestModel: requestModel)
        await repository.GetExchangeSummary(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel =    responseModel.map({
                   GetExchangeSummaryUIModel.mapToUIModel($0)
                })
                completion(.success(uiModel))

            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func GetAllProfilesLookupsByUserCode(requestModel: GetAllProfilesLookupsByUserCodeRequestModel, completion: @escaping (Result<[GetAllProfilesLookupsByUserCodeUIModel], NetworkError>) -> Void) async {
        let route = HomeRoute.GetAllProfilesLookupsByUserCode(requestModel: requestModel)
        await repository.GetAllProfilesLookupsByUserCode(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel =    responseModel.map({
                    GetAllProfilesLookupsByUserCodeUIModel.mapToUIModel($0)

                })
                completion(.success(uiModel))

            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
