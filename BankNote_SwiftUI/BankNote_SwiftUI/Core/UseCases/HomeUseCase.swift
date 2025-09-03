//
//  LoginUseCase.swift
//  QSC_SwiftUI
//
//  Created by FIT on 20/08/2025.
//

import Foundation
protocol HomeUseCaseProtocol{
    func GetAllProfilesLookupsByUserCode(requestModel: GetAllProfilesLookupsByUserCodeRequestModel , completion: @escaping(Result<[GetAllProfilesLookupsByUserCodeUIModel], NetworkError>) -> Void) async
    func GetMarketWatchByProfileID(requestModel: GetMarketWatchByProfileIDRequestModel , completion: @escaping(Result<[GetMarketWatchByProfileIDUIModel], NetworkError>) -> Void) async
    func GetExchangeSummary(requestModel: GetExchangeSummaryRequestModel , completion: @escaping(Result<[GetExchangeSummaryUIModel], NetworkError>) -> Void) async

}

class HomeUseCase {
    private let repository: HomeRepositoryProtocol
    init(repository: HomeRepositoryProtocol = HomeRepository()) {
        self.repository = repository
    }
}

extension HomeUseCase: HomeUseCaseProtocol {
    func GetExchangeSummary(requestModel: GetExchangeSummaryRequestModel, completion: @escaping (Result<[GetExchangeSummaryUIModel], NetworkError>) -> Void) async {
        let route = HomeRoute.GetExchangeSummary(requestModel: requestModel)
        await repository.GetExchangeSummary(route: route) { result in
            switch result {
            case .success(let responseModel):
                
                let uiModel = responseModel.map({
                    GetExchangeSummaryUIModel.mapToUIModel($0)
                })
                
                completion(.success(uiModel))
                
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func GetMarketWatchByProfileID(requestModel: GetMarketWatchByProfileIDRequestModel, completion: @escaping (Result<[GetMarketWatchByProfileIDUIModel], NetworkError>) -> Void) async {
        let route = HomeRoute.GetMarketWatchByProfileID(requestModel: requestModel)
        await repository.GetMarketWatchByProfileID(route: route) { result in
            switch result {
            case .success(let responseModel):
                
                let uiModel = responseModel.map({
                    GetMarketWatchByProfileIDUIModel.mapToUIModel($0)
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
                    
                    let uiModel = responseModel.map({
                        GetAllProfilesLookupsByUserCodeUIModel.mapToUIModel($0)
                    })
                    
                    completion(.success(uiModel))
                    
                case .failure(let failure):
                    completion(.failure(failure))
                }
            }
        }
    }
