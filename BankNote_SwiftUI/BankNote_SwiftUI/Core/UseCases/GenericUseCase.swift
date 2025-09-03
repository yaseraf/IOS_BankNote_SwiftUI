//
//  GenericUseCase.swift
//  QSC_SwiftUI
//
//  Created by FIT on 25/08/2025.
//

import Foundation

protocol GenericUseCaseProtocol{
    func GetLookups(requestModel: GetLookupsRequestModel, completion: @escaping(Result<[GetLookupsUIModel], NetworkError>) -> Void) async
}

class GenericUseCase {
    private let repository: GenericRepositoryProtocol
    init(repository: GenericRepositoryProtocol = GenericRepository()) {
        self.repository = repository
    }
}

extension GenericUseCase: GenericUseCaseProtocol {
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
}
