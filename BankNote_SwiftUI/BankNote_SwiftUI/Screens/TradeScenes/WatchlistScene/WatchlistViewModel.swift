//
//  WatchlistViewModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 10/09/2025.
//

import Foundation

class WatchlistViewModel: ObservableObject {
    private let coordinator: TradeCoordinator
    private let useCase: TradeUseCaseProtocol

    @Published var watchlistData: [WatchlistUIModel]?
    @Published var list:[GetMarketWatchByProfileIDUIModel]?

    @Published var getMarketWatchByProfileIDAPIResult:APIResultType<[GetMarketWatchByProfileIDUIModel]>?
    @Published var subscribleMarketWatchSymbolsAPIResult:APIResultType<[GetMarketWatchByProfileIDUIModel]>?

    init(coordinator: TradeCoordinator, useCase: TradeUseCaseProtocol) {
        self.coordinator = coordinator
        self.useCase = useCase
        
        Connection_Hub.shared.marketWatchDelegate = self
        
        watchlistData = []
    }
    
    
}

// MARK: Routing
extension WatchlistViewModel {
    func popViewController() {
        coordinator.popViewController()
    }
}

// MARK: Mock Data Fetch
extension WatchlistViewModel {
    func getWatchlistData() {
        var data: [WatchlistUIModel] = []
        data.append(WatchlistUIModel(image: "ic_fawry", name: "FWRY", fullName: "Fawry For Banking Technology", change: 35, changePerc: 3.01))
        data.append(WatchlistUIModel(image: "ic_etel", name: "ETEL", fullName: "Telecom Egypt", change: 35, changePerc: -2.1))
        
        watchlistData = data
    }
}

// MARK: API Calls
extension WatchlistViewModel {
    func GetMarketWatchByProfileIDAPI(success:Bool) {
        let requestModel = GetMarketWatchByProfileIDRequestModel()
        getMarketWatchByProfileIDAPIResult = .onLoading(show: true)
        
        UserDefaultController().profileID = "2"
        
        Task.init {
            await useCase.GetMarketWatchByProfileID(requestModel: requestModel) {[weak self] result in
                self?.getMarketWatchByProfileIDAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    self?.getMarketWatchByProfileIDAPIResult = .onSuccess(response: success)
                    debugPrint("market overview stocks success")
                    self?.list = success
                    
                    self?.getSubscribeMarketWatchSymbols()

                case .failure(let failure):
                        self?.getMarketWatchByProfileIDAPIResult = .onFailure(error: failure)
                    debugPrint("market overview stocks failure: \(failure)")
                }
            }
        }
    }

}

// MARK: SignalR
extension WatchlistViewModel {
    func getSubscribeMarketWatchSymbols(){
        if list?.count ?? 0 <= 0 {return}

        var arraySymbols: [String] = []
        
        for i in 0...(list?.count ?? 0) - 1 {
            if i == 4 { break }
            arraySymbols.append(list?[i].symbol ?? "")
        }
        
        subscribleMarketWatchSymbolsAPIResult = .onLoading(show:  true)
        
        debugPrint("Username sent SignalR: \(UserDefaultController().username ?? "")")
        debugPrint("symbols sent SignalR: \(arraySymbols)")
    
        if Connection_Hub.shared.chatHub != nil {
            do {
                printToLog("test invoke subscribeMarketWatchSymbols '\(arraySymbols)'")
                try Connection_Hub.shared.chatHub?.invoke("SubscribeMarketWatchSymbols", arguments: [UserDefaultController().username ?? "", arraySymbols]) { (result, error) in
                    if let e = error {
                        printToLog("SubscribeMarketWatchSymbols invoke '\(arraySymbols)' Error: \(e)")
                        self.subscribleMarketWatchSymbolsAPIResult = .onLoading(show:  false)
                    } else {
                        printToLog("SubscribeMarketWatchSymbols invoke '\(arraySymbols)' Success!, appDelegate.userNameNotEncryptrd\("info3@fitmena.com")")
                        self.subscribleMarketWatchSymbolsAPIResult = .onLoading(show:  false)
                    }
                }
            } catch let error {
                printToLog("SubscribeMarketWatchSymbols chatHub '\(arraySymbols)' error: \(error.localizedDescription)")
                self.subscribleMarketWatchSymbolsAPIResult = .onLoading(show:  false)

            }
        }
    }
    
    func UnSubscribleMarketWatchSymbols() {
        subscribleMarketWatchSymbolsAPIResult = .onLoading(show:  true)
        
        if Connection_Hub.shared.chatHub != nil {
            do {
                printToLog("test invoke unSubscribeMarketWatchSymbols")
                try Connection_Hub.shared.chatHub?.invoke(HubMethodType.unSubscribeMarketWatchSymbols.rawValue, arguments: [UserDefaultController().username ?? ""]) { (result, error) in
                    if let e = error {
                        printToLog("unSubscribeMarketWatchSymbols invoke Error: \(e)")
                    } else {
                        printToLog("unSubscribeMarketWatchSymbols invoke Success!, appDelegate.userNameNotEncryptrd\("info3@fitmena.com")")
                        printToLog("unSubscribeMarketWatchSymbols invoke result: \(result)")
                    }
                }
            } catch let error {
                printToLog("unSubscribeMarketWatchSymbols chatHub error: \(error.localizedDescription)")
            }
        }
    }
}


// MARK: Delegates
extension WatchlistViewModel: MarketWatchDelegate {
    func onWatchlistDataReceive(data: GetMarketWatchByProfileIDUIModel) {
        self.subscribleMarketWatchSymbolsAPIResult = .onLoading(show:  false)

        for (index, listItem) in (list ?? []).enumerated() {
            if listItem.symbol == data.symbol {
                list?[index].lastTradePrice = data.lastTradePrice
                list?[index].netChange = data.netChange
                list?[index].netChangePerc = data.netChangePerc
            }
        }
    }
}
