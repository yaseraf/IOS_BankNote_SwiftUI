//
//  AuthRoute.swift
//  QSC
//
//  Created by FIT on 27/07/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation
enum HomeRoute:APITargetType{
    
    case getUserAccounts(requestModel: GetUserAccountsRequestModel)
    case getPortfolio(requestModel: GetPortfolioRequestModel)
    case GetAllProfilesLookupsByUserCode(requestModel: GetAllProfilesLookupsByUserCodeRequestModel)
    case GetMarketWatchByProfileID(requestModel: GetMarketWatchByProfileIDRequestModel)
    case GetExchangeSummary(requestModel: GetExchangeSummaryRequestModel)
    case GetCompaniesLookups(requestModel: GetCompaniesLookupsRequestModel)
    case GetALLMarketWatchBySymbol(requestModel: GetALLMarketWatchBySymbolRequestModel)
    case GetAllMarketNewsBySymbol(requestModel: GetAllMarketNewsBySymbolRequestModel)
    case GetExpectedProfitLoss(requestModel: GetExpectedProfitLossRequestModel)
    case GetRiskManagement(requestModel: GetRiskManagementRequestModel)
    
    // MARK: Banknote / Tiers / Badges / Transactions Packages
    case GetBankNote(requestModel: GetBankNoteRequestModel)
    case GetTiers(requestModel: GetTiersRequestModel)
    case GetBankNotesMainBadges(requestModel: GetBankNotesMainBadgesRequestModel)
    case GetBankNotesBadges(requestModel: GetBankNotesBadgesRequestModel)
    case GetTransactionsPackages(requestModel: GetTransactionsPackagesRequestModel)
    case CreateBuyBankNotesJV(requestModel: CreateBuyBankNotesJVRequestModel)
    case UpdateBankNotesTransQTY(requestModel: UpdateBankNotesTransQTYRequestModel)
    case GetClientBankNotes(requestModel: GetClientBankNotesRequestModel)
    case GetClientTransActionsPackages(requestModel: GetClientTransactionsPackagesRequestModel)
    case CalcFreeSubBadgesBankNotes(requestModel: CalcFreeSubBadgesBankNotesRequestModel)
    case TransferAmountToAccounts(requestModel: TransferAmountToAccountsRequestModel)
    
    // MARK: Paymob
    case PaymobAuthorize(requestModel: PaymobAuthorizeRequestModel)
    
    var baseURL: URL{
        get{
            return URL(string: AppEnvironmentController.currentNetworkConfiguration.basePath
                       + path)!
        }
    }
    
    var headers: [String : String]{
        get{
            switch self {
                
            default:
                return  NetworkUtility.getHeader(.withoutToken)
                
            }
        }
    }
    
    func getCurrentDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ddMMyyyyHHmmss"
        let currentDate = Date()
        let dateString = dateFormatter.string(from: currentDate)
        return dateString
    }

    
    var path: String{
        switch self {
        case .getUserAccounts:
            return "GeneralWServices/GetUserAccounts/\(KeyChainController().webCode ?? "")"
        case .getPortfolio:
            return "FinancialWServices/GetPortfolioAndAccSumAndChart/\(KeyChainController().mainClientID ?? "")/\(KeyChainController().clientID ?? "")/\(KeyChainController().webCode ?? "")/\(UserDefaultController().currentDate ?? "")/\(KeyChainController().brokerID ?? "")/\(KeyChainController().UCODE ?? "")"
        case .GetAllProfilesLookupsByUserCode:
            return "MarektWServices/GetAllProfilesLookupsByUSerCode/\(KeyChainController().webCode ?? "")"
        case .GetMarketWatchByProfileID:
            return "MarektWServices/GetMarketWatchByProfileID/\(UserDefaultController().profileID ?? "")/\(KeyChainController().webCode ?? "")"
        case .GetExchangeSummary:
            return "MarektWServices/GetExchangeSummary/\(KeyChainController().webCode ?? "")"
        case .GetCompaniesLookups:
            return "GeneralWServices/GetCompaniesLookups/\(KeyChainController().webCode ?? "")"
        case .GetALLMarketWatchBySymbol:
            return "MarektWServices/GetALLMarketWatchBySymbol/\(KeyChainController().webCode ?? "")/\(UserDefaultController().selectedSymbol ?? "")/\(UserDefaultController().selectedSymbolType ?? "")"
        case .GetAllMarketNewsBySymbol:
            return "GeneralWServices/GetAllMarketNewsBySymbol/\(UserDefaultController().selectedSymbol ?? "")/\(KeyChainController().webCode ?? "")"
        case .GetExpectedProfitLoss:
            return "FinancialWServices/GetExpectedProfitLoss/\(KeyChainController.shared().mainClientID ?? "")/\(KeyChainController.shared().clientID ?? "")/\(KeyChainController.shared().webCode ?? "")/\(getCurrentDateString())/\(KeyChainController.shared().brokerID ?? "")"
        case .GetRiskManagement:
            return "TradingWServices/GetRiskManagment"
            
            // MARK: Banknote / Tiers / Badges / Transactions Packages

        case .GetBankNote:
            return "GeneralWservices/GetBankNote"
        case .GetTiers:
            return "GeneralWServices/GetTiers"
        case .GetBankNotesMainBadges:
            return "GeneralWServices/GetBankNotesMainBadges"
        case .GetBankNotesBadges:
            return "GeneralWServices/GetBankNotesBadges"
        case .GetTransactionsPackages:
            return "GeneralWServices/GetTransactionsPackages"
        case .CreateBuyBankNotesJV:
            return "GeneralWServices/CreateBuyBankNotesJV"
        case .UpdateBankNotesTransQTY:
            return "GeneralWServices/UpdateBankNotesTransQTY"
        case .GetClientBankNotes:
            return "GeneralWServices/GetClinetBankNotes"
        case .GetClientTransActionsPackages:
            return "GeneralWServices/GetClientTransActionsPackages"
        case .CalcFreeSubBadgesBankNotes:
            return "GeneralWServices/CalcFreeSubBadgesBankNotes"
        case .TransferAmountToAccounts:
            return "GeneralWServices/TransferAmountToAccounts"
            
            // MARK: Paymob
            
        case .PaymobAuthorize:
            return "GeneralWServices/PaymobAuthorize"
        }
    }
    
    var method: APIMethodType{
        get{
            switch self {
            case .GetAllProfilesLookupsByUserCode, .GetMarketWatchByProfileID, .GetExchangeSummary, .getUserAccounts, .getPortfolio, .GetCompaniesLookups, .GetALLMarketWatchBySymbol, .GetAllMarketNewsBySymbol, .GetExpectedProfitLoss:
                return .get
            case .GetRiskManagement, .GetBankNote, .GetTiers, .GetBankNotesMainBadges,  .GetBankNotesBadges, .GetTransactionsPackages, .CreateBuyBankNotesJV, .UpdateBankNotesTransQTY, .GetClientBankNotes, .GetClientTransActionsPackages, .CalcFreeSubBadgesBankNotes, .TransferAmountToAccounts, .PaymobAuthorize:
                return .post
            }
        }
    }
    
    var requestType: APITypeOfRequest{
        switch self {
        case .GetAllProfilesLookupsByUserCode, .GetMarketWatchByProfileID, .GetExchangeSummary, .getUserAccounts, .getPortfolio, .GetCompaniesLookups, .GetALLMarketWatchBySymbol, .GetAllMarketNewsBySymbol, .GetExpectedProfitLoss:
                .requestPlain
            
        case .GetRiskManagement(let requestModel):
                .requestJsonEncodable(requestModel)
        case .GetBankNote(let requestModel):
                .requestJsonEncodable(requestModel)
        case .GetTiers(let requestModel):
                .requestJsonEncodable(requestModel)
        case .GetBankNotesMainBadges(let requestModel):
                .requestJsonEncodable(requestModel)
        case .GetBankNotesBadges(let requestModel):
                .requestJsonEncodable(requestModel)
        case .GetTransactionsPackages(let requestModel):
                .requestJsonEncodable(requestModel)
        case .CreateBuyBankNotesJV(let requestModel):
                .requestJsonEncodable(requestModel)
        case .UpdateBankNotesTransQTY(let requestModel):
                .requestJsonEncodable(requestModel)
        case .GetClientBankNotes(let requestModel):
                .requestJsonEncodable(requestModel)
        case .GetClientTransActionsPackages(let requestModel):
                .requestJsonEncodable(requestModel)
        case .CalcFreeSubBadgesBankNotes(let requestModel):
                .requestJsonEncodable(requestModel)
        case .TransferAmountToAccounts(let requestModel):
                .requestJsonEncodable(requestModel)
        case .PaymobAuthorize(let requestModel):
                .requestJsonEncodable(requestModel)
        }
    }
}
