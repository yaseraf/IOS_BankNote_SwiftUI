//
//  AuthRepository.swift
//  QSC_SwiftUI
//
//  Created by FIT on 20/08/2025.
//

import Foundation
protocol HomeRepositoryProtocol {
    func GetAllProfilesLookupsByUserCode (route:HomeRoute, completion: @escaping(Result<[GetAllProfilesLookupsByUserCodeResponseModel], NetworkError>) -> Void) async
    func GetMarketWatchByProfileID(route: HomeRoute, completion: @escaping(Result<[GetMarketWatchByProfileIDResponseModel], NetworkError>) -> Void) async
    func GetExchangeSummary(route: HomeRoute, completion: @escaping(Result<[GetExchangeSummaryResponseModel], NetworkError>) -> Void) async
    func getUserAccounts(route: HomeRoute, completion: @escaping(Result<[GetUserAccountsResponseModel], NetworkError>) -> Void) async
    func getPortfolio(route: HomeRoute, completion: @escaping(Result<GetPortfolioResponseModel, NetworkError>) -> Void) async
    func GetALLMarketWatchBySymbol(route: HomeRoute, completion: @escaping(Result<GetALLMarketWatchBySymbolResponseModel, NetworkError>) -> Void) async
    func GetAllMarketNewsBySymbol(route: HomeRoute, completion: @escaping(Result<[GetAllMarketNewsBySymbolResponseModel], NetworkError>) -> Void) async
    func GetExpectedProfitLoss(route: HomeRoute, completion: @escaping(Result<[GetExpectedProfitLossResponseModel], NetworkError>) -> Void) async
    func GetRiskManagement(route: HomeRoute, completion: @escaping(Result<GetRiskManagementResponseModel, NetworkError>) -> Void) async
    func getInvoices(route: HomeRoute, completion: @escaping(Result<GetInvoicesResponseModel, NetworkError>) -> Void) async
    func getStatementOfAccount(route: HomeRoute, completion: @escaping(Result<[GetStatementOfAccountResponseModel], NetworkError>) -> Void) async
    func getTransactionSummary(route: HomeRoute, completion: @escaping(Result<[GetTransactionSummaryResponseModel], NetworkError>) -> Void) async

    // MARK: Banknote / Tiers / Badges / Transactions Packages
    func GetBankNote(route: HomeRoute, completion: @escaping(Result<GetBankNoteResponseModel, NetworkError>) -> Void) async
    func GetTiers(route: HomeRoute, completion: @escaping(Result<GetTiersResponseModel, NetworkError>) -> Void) async
    func UpdateTiersCode(route: HomeRoute, completion: @escaping(Result<UpdateTiersCodeResponseModel, NetworkError>) -> Void) async
    func GetBankNotesMainBadges(route: HomeRoute, completion: @escaping(Result<GetBankNotesMainBadgesResponseModel, NetworkError>) -> Void) async
    func GetBankNotesBadges(route: HomeRoute, completion: @escaping(Result<GetBankNotesBadgesResponseModel, NetworkError>) -> Void) async
    func GetTransactionsPackages(route: HomeRoute, completion: @escaping(Result<GetTransactionsPackagesResponseModel, NetworkError>) -> Void) async
    func CreateBuyBankNotesJV(route: HomeRoute, completion: @escaping(Result<CreateBuyBankNotesJVResponseModel, NetworkError>) -> Void) async
    func UpdateBankNotesTransQTY(route: HomeRoute, completion: @escaping(Result<UpdateBankNotesTransQTYResponseModel, NetworkError>) -> Void) async
    func GetClientBankNotes(route: HomeRoute, completion: @escaping(Result<GetClientBankNotesResponseModel, NetworkError>) -> Void) async
    func GetClientTransActionsPackages(route: HomeRoute, completion: @escaping(Result<GetClientTransactionsPackagesResponseModel, NetworkError>) -> Void) async
    func CalcFreeSubBadgesBankNotes(route: HomeRoute, completion: @escaping(Result<CalcFreeSubBadgesBankNotesResponseModel, NetworkError>) -> Void) async
    func TransferAmountToAccounts(route: HomeRoute, completion: @escaping(Result<TransferAmountToAccountsResponseModel, NetworkError>) -> Void) async

    // MARK: Paymob

    func PaymobGetSdkToken(route: HomeRoute, completion: @escaping(Result<PaymobGetSdkTokenResponseModel, NetworkError>) -> Void) async

}

class HomeRepository: HomeRepositoryProtocol {    
    func getPortfolio(route: HomeRoute, completion: @escaping (Result<GetPortfolioResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route, responseType: GetPortfolioResponseModel.self, completion: completion).requestApi()
    }
    
    func getUserAccounts(route: HomeRoute, completion: @escaping (Result<[GetUserAccountsResponseModel], NetworkError>) -> Void) async {
        await RequestApi(route: route, responseType: [GetUserAccountsResponseModel].self, completion: completion).requestApi()
    }
    
    func GetExchangeSummary(route: HomeRoute, completion: @escaping (Result<[GetExchangeSummaryResponseModel], NetworkError>) -> Void) async {
        await RequestApi(route: route,responseType: [GetExchangeSummaryResponseModel].self, completion: completion).requestApi()
    }
    
    func GetAllProfilesLookupsByUserCode(route: HomeRoute, completion: @escaping (Result<[GetAllProfilesLookupsByUserCodeResponseModel], NetworkError>) -> Void) async {
        await RequestApi(route: route,responseType: [GetAllProfilesLookupsByUserCodeResponseModel].self, completion: completion).requestApi()
    }
    func GetMarketWatchByProfileID(route: HomeRoute, completion: @escaping (Result<[GetMarketWatchByProfileIDResponseModel], NetworkError>) -> Void) async {
        await RequestApi(route: route, responseType: [GetMarketWatchByProfileIDResponseModel].self, completion: completion).requestApi()
    }
    func GetALLMarketWatchBySymbol(route: HomeRoute, completion: @escaping (Result<GetALLMarketWatchBySymbolResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route, responseType: GetALLMarketWatchBySymbolResponseModel.self, completion: completion).requestApi()
    }
    func GetAllMarketNewsBySymbol(route: HomeRoute, completion: @escaping (Result<[GetAllMarketNewsBySymbolResponseModel], NetworkError>) -> Void) async {
        await RequestApi(route: route, responseType: [GetAllMarketNewsBySymbolResponseModel].self, completion: completion).requestApi()
    }
    func GetExpectedProfitLoss(route: HomeRoute, completion: @escaping (Result<[GetExpectedProfitLossResponseModel], NetworkError>) -> Void) async {
        await RequestApi(route: route, responseType: [GetExpectedProfitLossResponseModel].self, completion: completion).requestApi()
    }
    func GetRiskManagement(route: HomeRoute, completion: @escaping (Result<GetRiskManagementResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route, responseType: GetRiskManagementResponseModel.self, completion: completion).requestApi()
    }
    func getInvoices(route: HomeRoute, completion: @escaping (Result<GetInvoicesResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route, responseType: GetInvoicesResponseModel.self, completion: completion).requestApi()
    }
    
    func getStatementOfAccount(route: HomeRoute, completion: @escaping (Result<[GetStatementOfAccountResponseModel], NetworkError>) -> Void) async {
        await RequestApi(route: route, responseType: [GetStatementOfAccountResponseModel].self, completion: completion).requestApi()
    }
    
    func getTransactionSummary(route: HomeRoute, completion: @escaping (Result<[GetTransactionSummaryResponseModel], NetworkError>) -> Void) async {
        await RequestApi(route: route, responseType: [GetTransactionSummaryResponseModel].self, completion: completion).requestApi()
    }

    
    // MARK: Banknote / Tiers / Badges / Transactions Packages
    func GetBankNote(route: HomeRoute, completion: @escaping (Result<GetBankNoteResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route, responseType: GetBankNoteResponseModel.self, completion: completion).requestApi()
    }
    func GetTiers(route: HomeRoute, completion: @escaping (Result<GetTiersResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route, responseType: GetTiersResponseModel.self, completion: completion).requestApi()
    }
    func UpdateTiersCode(route: HomeRoute, completion: @escaping (Result<UpdateTiersCodeResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route, responseType: UpdateTiersCodeResponseModel.self, completion: completion).requestApi()
    }
    func GetBankNotesMainBadges(route: HomeRoute, completion: @escaping (Result<GetBankNotesMainBadgesResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route, responseType: GetBankNotesMainBadgesResponseModel.self, completion: completion).requestApi()
    }
    func GetBankNotesBadges(route: HomeRoute, completion: @escaping (Result<GetBankNotesBadgesResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route, responseType: GetBankNotesBadgesResponseModel.self, completion: completion).requestApi()
    }
    func GetTransactionsPackages(route: HomeRoute, completion: @escaping (Result<GetTransactionsPackagesResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route, responseType: GetTransactionsPackagesResponseModel.self, completion: completion).requestApi()
    }
    func CreateBuyBankNotesJV(route: HomeRoute, completion: @escaping (Result<CreateBuyBankNotesJVResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route, responseType: CreateBuyBankNotesJVResponseModel.self, completion: completion).requestApi()
    }
    func UpdateBankNotesTransQTY(route: HomeRoute, completion: @escaping (Result<UpdateBankNotesTransQTYResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route, responseType: UpdateBankNotesTransQTYResponseModel.self, completion: completion).requestApi()
    }
    func GetClientBankNotes(route: HomeRoute, completion: @escaping (Result<GetClientBankNotesResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route, responseType: GetClientBankNotesResponseModel.self, completion: completion).requestApi()
    }
    func GetClientTransActionsPackages(route: HomeRoute, completion: @escaping (Result<GetClientTransactionsPackagesResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route, responseType: GetClientTransactionsPackagesResponseModel.self, completion: completion).requestApi()
    }
    func CalcFreeSubBadgesBankNotes(route: HomeRoute, completion: @escaping (Result<CalcFreeSubBadgesBankNotesResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route, responseType: CalcFreeSubBadgesBankNotesResponseModel.self, completion: completion).requestApi()
    }
    func TransferAmountToAccounts(route: HomeRoute, completion: @escaping (Result<TransferAmountToAccountsResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route, responseType: TransferAmountToAccountsResponseModel.self, completion: completion).requestApi()
    }
    func PaymobGetSdkToken(route: HomeRoute, completion: @escaping (Result<PaymobGetSdkTokenResponseModel, NetworkError>) -> Void) async {
        await RequestApi(route: route, responseType: PaymobGetSdkTokenResponseModel.self, completion: completion).requestApi()
    }
}
