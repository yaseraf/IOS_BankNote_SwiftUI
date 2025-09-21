//
//  LoginUseCase.swift
//  QSC_SwiftUI
//
//  Created by FIT on 20/08/2025.
//

import Foundation
protocol HomeUseCaseProtocol{
    func getUserAccounts(requestModel: GetUserAccountsRequestModel, completion: @escaping(Result<[GetUserAccountsUIModel], NetworkError>) -> Void) async
    func getPortfolio(requestModel: GetPortfolioRequestModel, completion: @escaping(Result<GetPortfolioUIModel, NetworkError>) -> Void) async
    func GetCompaniesLookups(requestModel: GetCompaniesLookupsRequestModel, completion: @escaping(Result<[GetCompaniesLookupsUIModel], NetworkError>) -> Void) async
    func GetALLMarketWatchBySymbol(requestModel: GetALLMarketWatchBySymbolRequestModel, completion: @escaping(Result<GetALLMarketWatchBySymbolUIModel, NetworkError>) -> Void) async

}

class HomeUseCase {
    private let repository: HomeRepositoryProtocol
    init(repository: HomeRepositoryProtocol = HomeRepository()) {
        self.repository = repository
    }
}

extension HomeUseCase: HomeUseCaseProtocol {
    func getUserAccounts(requestModel: GetUserAccountsRequestModel, completion: @escaping (Result<[GetUserAccountsUIModel], NetworkError>) -> Void) async {
        let route = HomeRoute.getUserAccounts(requestModel: requestModel)
        await repository.getUserAccounts(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel =    responseModel.map({
                   GetUserAccountsUIModel.mapToUIModel($0)

                })
                completion(.success(uiModel))

            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func getPortfolio(requestModel: GetPortfolioRequestModel, completion: @escaping (Result<GetPortfolioUIModel, NetworkError>) -> Void) async {
        let route = HomeRoute.getPortfolio(requestModel: requestModel)
        await repository.getPortfolio(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = GetPortfolioUIModel.mapToUIModel(responseModel)
                completion(.success(uiModel))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func GetCompaniesLookups(requestModel: GetCompaniesLookupsRequestModel, completion: @escaping (Result<[GetCompaniesLookupsUIModel], NetworkError>) -> Void) async {
        let route = HomeRoute.GetCompaniesLookups(requestModel: requestModel)
        await repository.GetCompaniesLookups(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel =    responseModel.map({
                   GetCompaniesLookupsUIModel.mapToUIModel($0)
                })
                completion(.success(uiModel))

            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    func GetALLMarketWatchBySymbol(requestModel: GetALLMarketWatchBySymbolRequestModel, completion: @escaping (Result<GetALLMarketWatchBySymbolUIModel, NetworkError>) -> Void) async {
        let route = HomeRoute.GetALLMarketWatchBySymbol(requestModel: requestModel)
        await repository.GetALLMarketWatchBySymbol(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = GetALLMarketWatchBySymbolUIModel.mapToUIModel(responseModel)
                completion(.success(uiModel))

            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
