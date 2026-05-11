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
    func GetMarketWatchByProfileID(requestModel: GetMarketWatchByProfileIDRequestModel, completion: @escaping(Result<[GetMarketWatchByProfileIDUIModel], NetworkError>) -> Void) async
    func GetFullMarketNews(requestModel: GetAllMarketNewsRequestModel, completion: @escaping(Result<[GetAllMarketNewsUIModel], NetworkError>) -> Void) async
    func AddMarketWatchProfileName(requestModel: AddMarketWatchProfileNameRequestModel, completion: @escaping(Result<AddMarketWatchProfileNameUIModel, NetworkError>) -> Void) async
    func AddMarketWatchProfileSymbols(requestModel: AddMarketWatchProfileSymbolsRequestModel, completion: @escaping(Result<[AddMarketWatchProfileSymbolsUIModel], NetworkError>) -> Void) async
    func DeleteMarketWatchProfileSymbols(requestModel: DeleteMarketWatchProfileSymbolsRequestModel, completion: @escaping(Result<DeleteMarketWatchProfileSymbolsUIModel, NetworkError>) -> Void) async

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
    
    func GetMarketWatchByProfileID(requestModel: GetMarketWatchByProfileIDRequestModel, completion: @escaping (Result<[GetMarketWatchByProfileIDUIModel], NetworkError>) -> Void) async {
        let route = TradeRoute.GetMarketWatchByProfileID(requestModel: requestModel)
        await repository.GetMarketWatchByProfileID(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel =    responseModel.map({
                   GetMarketWatchByProfileIDUIModel.mapToUIModel($0)
                })
                completion(.success(uiModel))

            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func GetFullMarketNews(requestModel: GetAllMarketNewsRequestModel, completion: @escaping (Result<[GetAllMarketNewsUIModel], NetworkError>) -> Void) async {
        let route = TradeRoute.GetFullMarketNews(requestModel: requestModel)
        await repository.GetFullMarketNews(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel =    responseModel.map({
                    GetAllMarketNewsUIModel.mapToUIModel($0)
                })
                completion(.success(uiModel))

            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func AddMarketWatchProfileName(requestModel: AddMarketWatchProfileNameRequestModel, completion: @escaping (Result<AddMarketWatchProfileNameUIModel, NetworkError>) -> Void) async {
        let route = HomeRoute.AddMarketWatchProfileName(requestModel: requestModel)
        await repository.AddMarketWatchProfileName(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = AddMarketWatchProfileNameUIModel.mapToUIModel(responseModel)
                completion(.success(uiModel))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func AddMarketWatchProfileSymbols(requestModel: AddMarketWatchProfileSymbolsRequestModel, completion: @escaping (Result<[AddMarketWatchProfileSymbolsUIModel], NetworkError>) -> Void) async {
        let route = HomeRoute.AddMarketWatchProfileSymbols(requestModel: requestModel)
        await repository.AddMarketWatchProfileSymbols(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = responseModel.map({
                    AddMarketWatchProfileSymbolsUIModel.mapToUIModel($0)
                })
                completion(.success(uiModel))

            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func DeleteMarketWatchProfileSymbols(requestModel: DeleteMarketWatchProfileSymbolsRequestModel, completion: @escaping (Result<DeleteMarketWatchProfileSymbolsUIModel, NetworkError>) -> Void) async {
        let route = HomeRoute.DeleteMarketWatchProfileSymbols(requestModel: requestModel)
        await repository.DeleteMarketWatchProfileSymbols(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = DeleteMarketWatchProfileSymbolsUIModel.mapToUIModel(responseModel)

                completion(.success(uiModel))

            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }


}
