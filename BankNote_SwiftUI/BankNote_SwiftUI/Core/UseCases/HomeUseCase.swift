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
    func GetALLMarketWatchBySymbol(requestModel: GetALLMarketWatchBySymbolRequestModel, completion: @escaping(Result<GetALLMarketWatchBySymbolUIModel, NetworkError>) -> Void) async
    func GetAllMarketNewsBySymbol(requestModel: GetAllMarketNewsBySymbolRequestModel, completion: @escaping(Result<[GetAllMarketNewsBySymbolUIModel], NetworkError>) -> Void) async
    func GetExpectedProfitLoss(requestModel: GetExpectedProfitLossRequestModel, completion: @escaping(Result<[GetExpectedProfitLossUIModel], NetworkError>) -> Void) async
    func GetRiskManagement(requestModel: GetRiskManagementRequestModel, completion: @escaping(Result<GetRiskManagementUIModel, NetworkError>) -> Void) async
    
    // MARK: Banknote / Tiers / Badges / Transactions Packages
    func GetBankNote(requestModel: GetBankNoteRequestModel, completion: @escaping(Result<GetBankNoteUIModel, NetworkError>) -> Void) async
    func GetTiers(requestModel: GetTiersRequestModel, completion: @escaping(Result<GetTiersUIModel, NetworkError>) -> Void) async
    func GetBankNotesMainBadges(requestModel: GetBankNotesMainBadgesRequestModel, completion: @escaping(Result<GetBankNotesMainBadgesUIModel, NetworkError>) -> Void) async
    func GetBankNotesBadges(requestModel: GetBankNotesBadgesRequestModel, completion: @escaping(Result<GetBankNotesBadgesUIModel, NetworkError>) -> Void) async
    func GetTransactionsPackages(requestModel: GetTransactionsPackagesRequestModel, completion: @escaping(Result<GetTransactionsPackagesUIModel, NetworkError>) -> Void) async
    func CreateBuyBankNotesJV(requestModel: CreateBuyBankNotesJVRequestModel, completion: @escaping(Result<CreateBuyBankNotesJVUIModel, NetworkError>) -> Void) async
    func UpdateBankNotesTransQTY(requestModel: UpdateBankNotesTransQTYRequestModel, completion: @escaping(Result<UpdateBankNotesTransQTYUIModel, NetworkError>) -> Void) async
    func GetClientBankNotes(requestModel: GetClientBankNotesRequestModel, completion: @escaping(Result<GetClientBankNotesUIModel, NetworkError>) -> Void) async
    func GetClientTransActionsPackages(requestModel: GetClientTransactionsPackagesRequestModel, completion: @escaping(Result<GetClientTransactionsPackagesUIModel, NetworkError>) -> Void) async
    func CalcFreeSubBadgesBankNotes(requestModel: CalcFreeSubBadgesBankNotesRequestModel, completion: @escaping(Result<CalcFreeSubBadgesBankNotesUIModel, NetworkError>) -> Void) async
    func TransferAmountToAccounts(requestModel: TransferAmountToAccountsRequestModel, completion: @escaping(Result<TransferAmountToAccountsUIModel, NetworkError>) -> Void) async

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
    
    func GetAllMarketNewsBySymbol(requestModel: GetAllMarketNewsBySymbolRequestModel, completion: @escaping (Result<[GetAllMarketNewsBySymbolUIModel], NetworkError>) -> Void) async {
        let route = HomeRoute.GetAllMarketNewsBySymbol(requestModel: requestModel)
        await repository.GetAllMarketNewsBySymbol(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel =    responseModel.map({
                    GetAllMarketNewsBySymbolUIModel.mapToUIModel($0)
                })
                completion(.success(uiModel))

            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func GetExpectedProfitLoss(requestModel: GetExpectedProfitLossRequestModel, completion: @escaping (Result<[GetExpectedProfitLossUIModel], NetworkError>) -> Void) async {
        let route = HomeRoute.GetExpectedProfitLoss(requestModel: requestModel)
        await repository.GetExpectedProfitLoss(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = responseModel.map({
                    GetExpectedProfitLossUIModel.mapToUIModel($0)
                })
                completion(.success(uiModel))

            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }

    func GetRiskManagement(requestModel: GetRiskManagementRequestModel, completion: @escaping (Result<GetRiskManagementUIModel, NetworkError>) -> Void) async {
        let route = HomeRoute.GetRiskManagement(requestModel: requestModel)
        await repository.GetRiskManagement(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = GetRiskManagementUIModel.mapToUIModel(responseModel)
                completion(.success(uiModel))

            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    // MARK: Banknote / Tiers / Badges / Transactions Packages

    func GetBankNote(requestModel: GetBankNoteRequestModel, completion: @escaping (Result<GetBankNoteUIModel, NetworkError>) -> Void) async {
        let route = HomeRoute.GetBankNote(requestModel: requestModel)
        await repository.GetBankNote(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = GetBankNoteUIModel.mapToUIModel(responseModel)
                
                completion(.success(uiModel))

            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func GetTiers(requestModel: GetTiersRequestModel, completion: @escaping (Result<GetTiersUIModel, NetworkError>) -> Void) async {
        let route = HomeRoute.GetTiers(requestModel: requestModel)
        await repository.GetTiers(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = GetTiersUIModel.mapToUIModel(responseModel)
                
                completion(.success(uiModel))

            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func GetBankNotesMainBadges(requestModel: GetBankNotesMainBadgesRequestModel, completion: @escaping (Result<GetBankNotesMainBadgesUIModel, NetworkError>) -> Void) async {
        let route = HomeRoute.GetBankNotesMainBadges(requestModel: requestModel)
        await repository.GetBankNotesMainBadges(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = GetBankNotesMainBadgesUIModel.mapToUIModel(responseModel)
                
                completion(.success(uiModel))

            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func GetBankNotesBadges(requestModel: GetBankNotesBadgesRequestModel, completion: @escaping (Result<GetBankNotesBadgesUIModel, NetworkError>) -> Void) async {
        let route = HomeRoute.GetBankNotesBadges(requestModel: requestModel)
        await repository.GetBankNotesBadges(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = GetBankNotesBadgesUIModel.mapToUIModel(responseModel)

                completion(.success(uiModel))

            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func GetTransactionsPackages(requestModel: GetTransactionsPackagesRequestModel, completion: @escaping (Result<GetTransactionsPackagesUIModel, NetworkError>) -> Void) async {
        let route = HomeRoute.GetTransactionsPackages(requestModel: requestModel)
        await repository.GetTransactionsPackages(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = GetTransactionsPackagesUIModel.mapToUIModel(responseModel)

                completion(.success(uiModel))

            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }

    func CreateBuyBankNotesJV(requestModel: CreateBuyBankNotesJVRequestModel, completion: @escaping (Result<CreateBuyBankNotesJVUIModel, NetworkError>) -> Void) async {
        let route = HomeRoute.CreateBuyBankNotesJV(requestModel: requestModel)
        await repository.CreateBuyBankNotesJV(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = CreateBuyBankNotesJVUIModel.mapToUIModel(responseModel)
                completion(.success(uiModel))

            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func UpdateBankNotesTransQTY(requestModel: UpdateBankNotesTransQTYRequestModel, completion: @escaping (Result<UpdateBankNotesTransQTYUIModel, NetworkError>) -> Void) async {
        let route = HomeRoute.UpdateBankNotesTransQTY(requestModel: requestModel)
        await repository.UpdateBankNotesTransQTY(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = UpdateBankNotesTransQTYUIModel.mapToUIModel(responseModel)
                completion(.success(uiModel))

            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func GetClientBankNotes(requestModel: GetClientBankNotesRequestModel, completion: @escaping (Result<GetClientBankNotesUIModel, NetworkError>) -> Void) async {
        let route = HomeRoute.GetClientBankNotes(requestModel: requestModel)
        await repository.GetClientBankNotes(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = GetClientBankNotesUIModel.mapToUIModel(responseModel)
                completion(.success(uiModel))

            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }

    func GetClientTransActionsPackages(requestModel: GetClientTransactionsPackagesRequestModel, completion: @escaping (Result<GetClientTransactionsPackagesUIModel, NetworkError>) -> Void) async {
        let route = HomeRoute.GetClientTransActionsPackages(requestModel: requestModel)
        await repository.GetClientTransActionsPackages(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = GetClientTransactionsPackagesUIModel.mapToUIModel(responseModel)
                completion(.success(uiModel))

            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }

    func CalcFreeSubBadgesBankNotes(requestModel: CalcFreeSubBadgesBankNotesRequestModel, completion: @escaping (Result<CalcFreeSubBadgesBankNotesUIModel, NetworkError>) -> Void) async {
        let route = HomeRoute.CalcFreeSubBadgesBankNotes(requestModel: requestModel)
        await repository.CalcFreeSubBadgesBankNotes(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = CalcFreeSubBadgesBankNotesUIModel.mapToUIModel(responseModel)
                completion(.success(uiModel))

            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func TransferAmountToAccounts(requestModel: TransferAmountToAccountsRequestModel, completion: @escaping (Result<TransferAmountToAccountsUIModel, NetworkError>) -> Void) async {
        let route = HomeRoute.TransferAmountToAccounts(requestModel: requestModel)
        await repository.TransferAmountToAccounts(route: route) { result in
            switch result {
            case .success(let responseModel):
                let uiModel = TransferAmountToAccountsUIModel.mapToUIModel(responseModel)
                completion(.success(uiModel))

            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }






}
