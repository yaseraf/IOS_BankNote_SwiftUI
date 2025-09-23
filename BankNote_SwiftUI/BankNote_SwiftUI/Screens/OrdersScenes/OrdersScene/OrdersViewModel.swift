//
//  OrdersViewModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 09/09/2025.
//

import Foundation

class OrdersViewModel: ObservableObject {
    private let coordinator: OrdersCoordinatorProtocol
    private let lookupsUseCase: LookupsUseCaseProtocol
    @Published var ordersData: [OrderListUIModel]?
    @Published var getLookupsList: [GetLookupsUIModel]?
    @Published var filterOSSList: [GetLookupsUIModel]? = []

    @Published var getLookupsAPIResult:APIResultType<[GetLookupsUIModel]>?
    @Published var sendOrdersAPIResult: APIResultType<OrderListUIModel>?

    init(coordinator: OrdersCoordinatorProtocol, lookupsUseCase: LookupsUseCaseProtocol) {
        self.coordinator = coordinator
        self.lookupsUseCase = lookupsUseCase
        
        ordersData = []
        
        Connection_Hub.shared.orderListDelegate = self
        GetLookupsAPI(success: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.sendOrdersSignalR()
        }
    }
}

// MARK: Routing
extension OrdersViewModel {
    func openOrderEntryScreen(symbol:String) {
        coordinator.openOrderEntryScene(symbol: symbol)
    }
}

// MARK: Mock Data
extension OrdersViewModel {
    func getOrdersData() {
//        var data: [OrdersUIModel] = []
//        
//        data.append(OrdersUIModel(image: "ic_adnocdistStock", type: "buy".localized, name: "ADNOCDIST", time: "28/05/2025    02:47 pm", value: -84.59, status: "pending".localized))
//        data.append(OrdersUIModel(image: "ic_nvidiaStock", type: "buy".localized, name: "NVIDIA", time: "27/05/2025    12:34 pm", value: -150.35, status: "completed".localized))
//        data.append(OrdersUIModel(image: "ic_topUp", type: "", name: "top_up", time: "27/05/2025    10:29pm", value: -400, status: "completed".localized))
//        
//        ordersData = data
    }

}

// MARK: API Calls
extension OrdersViewModel {
    func GetLookupsAPI(success:Bool) {
        let requestModel = GetLookupsRequestModel()
        getLookupsAPIResult = .onLoading(show: true)
        
        Task.init {
            await lookupsUseCase.GetLookups(requestModel: requestModel) {[weak self] result in
                self?.getLookupsAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    self?.getLookupsAPIResult = .onSuccess(response: success)
//                    debugPrint("get lookups success: \(success)")
                    self?.getLookupsList = success.filter({$0.type == "OSS"})
                    self?.filterOSSList = self?.getLookupsList

//                    self?.filterLookUps("OSS")
//                    let egxMarketData = marketData.filter { $0.exchangeID?.lowercased() == "egx" }
//                    self?.filterMarketStatus(marketData: egxMarketData)

                case .failure(let failure):
                        self?.getLookupsAPIResult = .onFailure(error: failure)
                    debugPrint("get lookups failure: \(failure)")

                }
            }
        }
    }

}

// MARK: SignalR
extension OrdersViewModel {
    func sendOrdersSignalR(){
        debugPrint("Trying signalR method")
        if Connection_Hub.shared.isConnected() {
            debugPrint("SignalR is connected")
        } else {
            debugPrint("SignalR is not connected")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.sendOrdersSignalR()
            }
        }
        
        sendOrdersAPIResult = .onLoading(show:  true)
        
        if Connection_Hub.shared.chatHub != nil {
            do {
                
                let string = "[{\"ClientID\": \"\(KeyChainController.shared().clientID ?? "")\" , \"WebUserID\": \"\(KeyChainController.shared().webCode ?? "")\" , \"Exchange\": \"\" , \"Symbol\": \"\" , \"OrderID\": \"\" , \"SellBuyFlag\": \"\"}]"
                
                let data = string.data(using: .utf8)!
                do {
                    if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [Dictionary<String,Any>] {

                        try Connection_Hub.shared.chatHub?.invoke(HubMethodType.sendOrders.rawValue, arguments: [UserDefaultController().username ?? "", jsonArray[0]]) { (result, error) in
                            if let e = error {
                                printToLog("sendOrders invoke Error: \(e)")
                            } else {
                                self.sendOrdersAPIResult = .onLoading(show: false)
                                printToLog("sendOrders invoke, \([UserDefaultController().username ?? "", jsonArray[0]]) Success!")
//                                self.GetLookupsAPI(success: true)

                            }
                        }
                    } else {
                        printToLog("sendOrders bad json")
                    }
                } catch let error {
                        printToLog("sendOrders chatHub error: \(error.localizedDescription)")
                    }
                  }  catch let error {
                      printToLog("sendOrders chatHub error: \(error.localizedDescription)")
                  }
                }
        }

}

// MARK: Delegates
extension OrdersViewModel: OrderListDelegate {
    func onOrderReceived(orders: [OrderListUIModel]) {
        ordersData = orders
    }
}

// MARK: Functions
extension OrdersViewModel {
    func filterLookUps(_ type: String) {
        
        // Filter on 3 types: OPT, EXT, TIF
        for i in 0..<(getLookupsList?.count ?? 0) {
            if getLookupsList?[i].type == type {
                if type == "OSS" {
                    filterOSSList?.append(getLookupsList?[i] ?? GetLookupsUIModel.initializer())
                    
                }
            }
        }
    }

}
