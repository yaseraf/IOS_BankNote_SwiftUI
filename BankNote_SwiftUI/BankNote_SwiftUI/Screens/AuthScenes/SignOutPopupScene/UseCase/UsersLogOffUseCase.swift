//
//  InvoiceDetailsUseCase.swift
//  mahfazati
//
//  Created by FIT on 12/09/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation

protocol UsersLogOffUseCaseProtocol{
    func UsersLogOff(requestModel: UsersLogOffRequestModel, completion: @escaping(Result<UsersLogOffUIModel, NetworkError>) -> Void) async
}

class UsersLogOffUseCase {
//    private let repository: ManageRepositoryProtocol
//    init(repository: ManageRepositoryProtocol = ManageRepository()) {
//        self.repository = repository
//    }
}

extension UsersLogOffUseCase: UsersLogOffUseCaseProtocol {
    func UsersLogOff(requestModel: UsersLogOffRequestModel, completion: @escaping (Result<UsersLogOffUIModel, NetworkError>) -> Void) async {
//        let route = manageRoute.UsersLogOff(requestModel: requestModel)
//        await repository.UsersLogOff(route: route) { result in
//            switch result {
//            case .success(let responseModel):
//                let uiModel = UsersLogOffUIModel.mapToUIModel(responseModel)
//                completion(.success(uiModel))
//            case .failure(let failure):
//                completion(.failure(failure))
//            }
//        }
    }
}
