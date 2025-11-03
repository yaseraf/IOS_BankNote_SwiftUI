//
//  GetDeviceConfigsUseCaseProtocol.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 17/09/2025.
//

import Foundation
protocol GetDeviceConfigsUseCaseProtocol{
    
    
    func GetDeviceConfigs(requestModel: GetDeviceConfigsRequestModel , completion: @escaping(Result<GetDeviceConfigsUIModel, NetworkError>) -> Void) async
}
    
    class GetDeviceConfigsUseCase {
        private let repository: AuthRepositoryProtocol
        init(repository: AuthRepositoryProtocol = AuthRepository()) {
            self.repository = repository
        }
    }

    extension GetDeviceConfigsUseCase: GetDeviceConfigsUseCaseProtocol {
        func GetDeviceConfigs(requestModel: GetDeviceConfigsRequestModel, completion: @escaping (Result<GetDeviceConfigsUIModel, NetworkError>) -> Void) async {
            let route = AuthRoute.GetDeviceConfigs(requestModel: requestModel)
            await repository.GetDeviceConfigs(route: route) { result in
                switch result {
                case .success(let responseModel):
                    
                    let uiModel = GetDeviceConfigsUIModel.mapToUIModel(responseModel)
                    
                    completion(.success(uiModel))
                    
                case .failure(let failure):
                    completion(.failure(failure))
                }
            }
            
        }
        
}
