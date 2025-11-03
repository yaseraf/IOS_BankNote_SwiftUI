//
//  GenericUseCase.swift
//  QSC_SwiftUI
//
//  Created by FIT on 25/08/2025.
//

import Foundation

protocol LookupsUseCaseProtocol{
    func GetLookups(requestModel: GetLookupsRequestModel, completion: @escaping(Result<[GetLookupsUIModel], NetworkError>) -> Void) async
    func GetCompaniesLookups(requestModel: GetCompaniesLookupsRequestModel, completion: @escaping(Result<[GetCompaniesLookupsUIModel], NetworkError>) -> Void) async
}

class LookupsUseCase {
    private let repository: LookupsRepositoryProtocol
    init(repository: LookupsRepositoryProtocol = LookupsRepository()) {
        self.repository = repository
    }
}

extension LookupsUseCase: LookupsUseCaseProtocol {
    func GetLookups(requestModel: GetLookupsRequestModel, completion: @escaping (Result<[GetLookupsUIModel], NetworkError>) -> Void) async {
        let route = GenericRoute.GetLookups(requestModel: requestModel)
        await repository.GetLookups(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = responseModel.map({
                    GetLookupsUIModel.mapToUIModel($0)
                })
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
}
