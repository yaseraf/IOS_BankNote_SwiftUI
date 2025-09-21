//
//  Constants.swift

//  Copyright (c) IDS 2017  All rights reserved.
//

import UIKit
import WebKit

class Connection_Hub {
    static let shared = Connection_Hub()

    var chatHub: Hub?
    var connection: SignalR?
    var connectionDelegate: ConnectionDelegate?
    var marketWatchDelegate: MarketWatchDelegate?
    var topActivitiesDelegate: TopActivitiesDelegate?
    var orderListDelegate: OrderListDelegate?
    var exchangeSummaryDelegate: ExchangeSummaryDelegate?
    
    var userDefaultController = UserDefaultController.instance
    
    @Published var getLookupsAPIResult:APIResultType<[GetLookupsUIModel]>?
    
    @Published var getLookupsList: [GetLookupsUIModel]? {
        didSet {
            tryUpdateMarketStatus()
        }
    }
    
    @Published var exchangeMarketSummaryData: [GetExchangeSummaryUIModel]? {
        didSet {
            tryUpdateMarketStatus()
        }
    }

   private func restartConnection(){
        if Connection_Hub.shared.connection != nil {
            Connection_Hub.shared.connection?.stop()
            Connection_Hub.shared.connection?.start()
        } else {
            Connection_Hub.shared.setupHubSignalR()
        }
    }

    func isConnected()->Bool{
       return connection?.state == .connected
    }

    func setupHubSignalR(){
        let chatHub = Hub("MyHub")
        
        bindingReceiverFunction(chatHub: chatHub)

        // Client
        let  connection = SignalR(AppEnvironmentController.currentNetworkConfiguration.signalRBasePath, connectionType: .hub)
        connection.useWKWebView = true
        connection.signalRVersion = .v2_2_2 // v2_2_0 v2_1_0
        connection.transport = .auto // webSockets //.webSockets //.serverSentEvents // longPolling
        connection.addHub(chatHub)


        self.connection = connection
        self.chatHub = chatHub

//        debugPrint("SignalR sent username: \(UserDefaultController().username ?? "")")

        connection.queryString = [
            "ischat": true
            , "username": "\(KeyChainController().username ?? "")" //HubUtility.shared.userName // "FIT"
            , "password": "" //HubUtility.shared.password // "FIT"
            , "webCode": "" //Int(HubUtility.shared.WebCode) ?? 0
            , "baseurl": "123"
            , "key":  "-"
            , "value":  "-"
            // , "cookies": cookieSession
        ]

        
        //MARK: SignalR events
        connection.starting = {
            printToLog("Connection starting...")
            HubUtility.shared.hubConnectionStatus = HubConnectionStatus.starting
            printToLog("Connection starting success")
        }
        
        connection.reconnecting = {
            printToLog("Connection reconnecting...")
            HubUtility.shared.hubConnectionStatus = HubConnectionStatus.reconnecting
            printToLog("Connection reconnecting success")
        }
        
        connection.reconnected = {
            printToLog("Connection reconnected")
            HubUtility.shared.hubConnectionStatus = HubConnectionStatus.reconnected
            printToLog("Connection reconnected success")
        }
        
        connection.disconnected = {
            printToLog("Connection disconnected...")
            HubUtility.shared.hubConnectionStatus = HubConnectionStatus.disconnected
            printToLog("Connection disconnected success")
            self.userDefaultController.signalRConnected = false
            self.connectionDelegate?.onDisconnect()
        }
        
        connection.connectionSlow = {
            printToLog("Connection slow...")
            HubUtility.shared.hubConnectionStatus = HubConnectionStatus.connectionSlow
            printToLog("Connection slow success")
        }
        
        connection.error = { error in
            HubUtility.shared.hubConnectionStatus = HubConnectionStatus.error
            printToLog("Connection error Error: \(error ?? ["":""])")
            let errorModel = HubUtility.shared.decodeToModel(from: error, type: SignalRErrorResponseModel.self)
            printToLog("errorModel:\(errorModel ?? SignalRErrorResponseModel())")

            guard  let errorModel = errorModel else {
                if SceneDelegate.getAppCoordinator()?.isUserLoggedIn ?? false {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2){

                        printToLog("connectionHub chatHub is alive ? \(Connection_Hub.shared.chatHub != nil)")
                        printToLog("connectionHub connection is alive ? \(Connection_Hub.shared.connection != nil)")

                        self.restartConnection()

                        printToLog("connectionHub chatHub is alive ? \(Connection_Hub.shared.chatHub != nil)")
                        printToLog("connectionHub connection is alive ? \(Connection_Hub.shared.connection != nil)")
                    }
                }
                return
            }
                if errorModel.source == .timeoutException {
                    printToLog("Connection timed out. Restarting...")

                    self.restartConnection()
                }else{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                        printToLog("connectionHub error chatHub is alive ? \(Connection_Hub.shared.chatHub != nil)")
                        printToLog("connectionHub error connection is alive ? \(Connection_Hub.shared.connection != nil)")
                        self.restartConnection()

                        printToLog("connectionHub error chatHub is alive ? \(Connection_Hub.shared.chatHub != nil)")
                        printToLog("connectionHub error connection is alive ? \(Connection_Hub.shared.connection != nil)")

                    }
                }





        }
        
        connection.connected = {
            HubUtility.shared.hubConnectionStatus = HubConnectionStatus.connected
            if self.connection != nil {
//                printToLog("Connection connected ID: \(self.connection?.connectionID ?? "- -")")
                self.userDefaultController.signalRConnected = true
                self.callGetLookupsAPI()
                self.connectionDelegate?.onConnect()
            } else {
//                printToLog("Connection connected ID: xxx ! ! self.connection is nil :) ! !")
                debugPrint("SignalR Failed to connect")
            }
        }
        
        connection.start()
        // // }
    }
    
    
    func bindingFunction<T:Decodable>(method:HubMethodType,type:T.Type,result:((T?)->Void)?){
        guard let chatHub  = chatHub else {return}
        Connection_Hub.shared.connection?.connect({
            print("reConnect")
        })
        
        if !Connection_Hub.shared.isConnected() {
            debugPrint("Reconnecting")
            Connection_Hub.shared.connection?.start()
        }
        
        chatHub.onReceive(method) { args in // get ktir data kl shwy
            debugPrint("method with args: \(method) Args: \(args ?? [])")
            let responseModel =  HubUtility.shared.decodeToModel(from: args?.first, type: type)
//            printToLog("chatHub.onReceive \(method) getting responseModel : \(responseModel)")

            result?(responseModel)
        }
    }
    
    func bindingReceiverFunction(chatHub: Hub){
        
        //MARK: Tops
        chatHub.onReceive(.sendTopGainerObject) { args in  //HubInvokes.SendTopGainerObject
            printToLog("chatHub.onReceive SendTopGainerObject ") //args: ", args)


            let responseModel =  HubUtility.shared.decodeToModel(from: args?.first, type: [TopActivitiesResponseModel].self)
            
            let uiModel =    responseModel?.compactMap({
                TopActivitiesUIModel.mapToUIModel($0)

            })
            
            self.topActivitiesDelegate?.onTopGainerReceived(data: uiModel ?? [])

        }
        
        chatHub.onReceive(.sendTopLoserObject) { args in
            printToLog("chatHub.onReceive SendTopLoserObject ") //args: ", args)
            
            let responseModel =  HubUtility.shared.decodeToModel(from: args?.first, type: [TopActivitiesResponseModel].self)
            
            let uiModel =    responseModel?.compactMap({
                TopActivitiesUIModel.mapToUIModel($0)

            })
            
            self.topActivitiesDelegate?.onTopLoserReceived(data: uiModel ?? [])
            

        }
        
        chatHub.onReceive(.sendTopVolumeObject) { args in
            printToLog("chatHub.onReceive SendTopVolumeObject ") //args: ", args)
            

        }
        
        chatHub.onReceive(.sendTopValueObject) { args in
            printToLog("chatHub.onReceive sendTopValueObject ") //args: ", args)

        }
        
        chatHub.onReceive(.sendMostActiveObject) { args in
            printToLog("chatHub.onReceive sendMostActiveObject ") //args: ", args)

            let responseModel =  HubUtility.shared.decodeToModel(from: args?.first, type: [TopActivitiesResponseModel].self)
            
            let uiModel =    responseModel?.compactMap({
                TopActivitiesUIModel.mapToUIModel($0)

            })
            
            self.topActivitiesDelegate?.onMostActiveReceived(data: uiModel ?? [])
            
        }
        

        //MARK: Market Exchange Status
        chatHub.onReceive(.sendExchangeMarketObject) { args in
            
            debugPrint("market args")
            
            let responseModel =  HubUtility.shared.decodeToModel(from: args?.first, type: [GetExchangeSummaryResponseModel].self)
            
            let uiModel = responseModel?.compactMap({
                GetExchangeSummaryUIModel.mapToUIModel($0)
            })

            self.exchangeMarketSummaryData = uiModel
            
//            self.connectionDelegate?.onSendExchangeMarketObject(data: uiModel ?? [])
            
            self.exchangeSummaryDelegate?.onDataFetch(model: uiModel ?? [])
            
        }
        
        chatHub.onReceive(.sendServerDateTimeVer2) { args in // it is stop called
//            printToLog("chatHub.onReceive sendServerDateTimeVer2 getting data : \(args)")
        }
        
        
        //MARK: Market T&S
        chatHub.onReceive(.getMarketTradesFullObject) { args in
//            printToLog("chatHub.onReceive getMarketTradesFullObject: \(args)")
            // printToLog("chatHub.onReceive getMarketTradesFullObject args: \(args)")
        }
        
        
        //MARK: Symbol Details
        chatHub.onReceive(.sendSymbolTradesFullObject) { args in // we stop use this function after add getSymbolTradesFullObject
//            printToLog("chatHub.onReceive sendSymbolTradesFullObject") // args: ", args)

        }
        
        chatHub.onReceive(.getSymbolTradesFullObject) { args in
//            printToLog("chatHub.onReceive getSymbolTradesFullObject: \(args)") //, args)
        }
        
        chatHub.onReceive(.sendSymbolTradesSummaryObject) { args in
//            printToLog("chatHub.onReceive getSymbolTradesSummaryObject args: \(args)")
            
            //            let responseModelList =  HubUtility.shared.decodeToModel(from: jsonString, type: [symbolTradesSummaryObject].self)

            
            
            let jsonString = """
            [{\"Sequence\":0.0,\"Symbol\":\"COMI.CA\",\"SymbolA\":\"التجاري الدولي\",\"SymbolE\":\"CIB (EGYPT)\",\"Exchange\":\"EGX\",\"MarketType\":null,\"Price\":\"78.410000\",\"Volume\":\"13018.000000\",\"Value\":1020741.380000000000,\"TrdNo\":12.0,\"TradeTime\":\"31122024135357\",\"SellBuyFlag\":null,\"NetChange\":\"-0.200\",\"NetChgPerc\":\"-0.254\",\"Precision\":\"3\",\"TradeID\":null,\"LastUpdateTime\":\"2024-12-31\"},{\"Sequence\":0.0,\"Symbol\":\"COMI.CA\",\"SymbolA\":\"التجاري الدولي\",\"SymbolE\":\"CIB (EGYPT)\",\"Exchange\":\"EGX\",\"MarketType\":null,\"Price\":\"79.390000\",\"Volume\":\"38.000000\",\"Value\":3016.820000000000,\"TrdNo\":1.0,\"TradeTime\":\"31122024121639\",\"SellBuyFlag\":null,\"NetChange\":\"0.780\",\"NetChgPerc\":\"0.992\",\"Precision\":\"3\",\"TradeID\":null,\"LastUpdateTime\":\"2024-12-31\"},{\"Sequence\":0.0,\"Symbol\":\"COMI.CA\",\"SymbolA\":\"التجاري الدولي\",\"SymbolE\":\"CIB (EGYPT)\",\"Exchange\":\"EGX\",\"MarketType\":null,\"Price\":\"79.450000\",\"Volume\":\"38.000000\",\"Value\":3019.100000000000,\"TrdNo\":1.0,\"TradeTime\":\"31122024121038\",\"SellBuyFlag\":null,\"NetChange\":\"0.840\",\"NetChgPerc\":\"1.069\",\"Precision\":\"3\",\"TradeID\":null,\"LastUpdateTime\":\"2024-12-31\"},{\"Sequence\":0.0,\"Symbol\":\"COMI.CA\",\"SymbolA\":\"التجاري الدولي\",\"SymbolE\":\"CIB (EGYPT)\",\"Exchange\":\"EGX\",\"MarketType\":null,\"Price\":\"79.470000\",\"Volume\":\"8000.000000\",\"Value\":635760.000000000000,\"TrdNo\":1.0,\"TradeTime\":\"31122024120807\",\"SellBuyFlag\":null,\"NetChange\":\"0.860\",\"NetChgPerc\":\"1.094\",\"Precision\":\"3\",\"TradeID\":null,\"LastUpdateTime\":\"2024-12-31\"}]
            """
            


            if let jsonData = jsonString.data(using: .utf8) {
                do {
                    let marketDataList = try JSONDecoder().decode([symbolTradesSummaryObject].self, from: jsonData)
//                    print(marketDataList)
//                    let uiModelList = marketDataList.compactMap({
//                        symbolTradesSummaryObjectUIModel.mapToUIModel($0)
//                    })
                    print("Decoding success")
                } catch {
                    print("Decoding error: \(error)")
                }
            }

        }
        
        chatHub.onReceive(.sendMarketTradesFullObject) { args in
            printToLog("chatHub.onReceive sendMarketTradesFullObject args ") //, args == nil ? "-" : JSON(arg!).stringValue.comp)
        }
        
        chatHub.onReceive(.sendSymbolDetails) { args in
            printToLog("chatHub.onReceive sendSymbolDetails args ") //, args == nil ? "-" : JSON(arg!).stringValue.comp)

            
        }
        
        chatHub.onReceive(.SubscribeFullMDSymbol) { args in
//            printToLog("chatHub.onReceive SubscribeFullMDSymbol args: \( args as Any)")
        //    //HubUtility.shared.topStockTrades = dataParser.parseTopItem(data: args).checkIfChange(withList: HubUtility.shared.topStockTrades).setSymbolChart(fromList: HubUtility.shared.topStockTrades)
        //    //printToLog("chatHub.onReceive HubUtility.shared.SubscribeFullMDSymbol: ", HubUtility.shared.topStockTrades.count)
        }
        
        chatHub.onReceive(.getFullMDSymbol) { args in
//            printToLog("chatHub.onReceive getFullMDSymbol args: \( args as Any)")

        //    printToLog("chatHub.onReceive getFullMDSymbol args: \( args as Any)")
        //    //HubUtility.shared.topStockTrades = dataParser.parseTopItem(data: args).checkIfChange(withList: HubUtility.shared.topStockTrades).setSymbolChart(fromList: HubUtility.shared.topStockTrades)
        //    //printToLog("chatHub.onReceive HubUtility.shared.getFullMDSymbol: ", HubUtility.shared.topStockTrades.count)
        }
        
        chatHub.onReceive(.getRelatedStocks) { args in
//            printToLog("chatHub.onReceive getRelatedStocks args: \( args as Any)")
            let responseModel =  HubUtility.shared.decodeToModel(from: args?.first, type: [RelatedStocksResponseModel].self)

            let uiModel = responseModel?.map({
                RelatedStocksUIModel.mapToUIModel($0)
            })
            
        }
        
        chatHub.onReceive(.getMostWatchStocks) { args in
//            printToLog("chatHub.onReceive getMostWatchStocks args: \( args as Any)")
            let responseModel =  HubUtility.shared.decodeToModel(from: args?.first, type: [RelatedStocksResponseModel].self)

            let uiModel = responseModel?.map({
                RelatedStocksUIModel.mapToUIModel($0)
            })
            
        }
        
        
        //MARK: Watch List
        chatHub.onReceive(.sendMarketWatchObject) { args in // get ktir data kl shwy
            
            debugPrint("Sender of data")
            
            let responseModel =  HubUtility.shared.decodeToModel(from: args?.first, type: GetMarketWatchByProfileIDResponseModel.self)
            
            let uiModel = GetMarketWatchByProfileIDUIModel.mapToUIModel(responseModel ?? .empty)
            
            self.marketWatchDelegate?.onWatchlistDataReceive(data: uiModel)

        }
        
        chatHub.onReceive(.unSubscribeMarketWatchSymbols) { args in // get ktir data kl shwy
            let responseModel =  HubUtility.shared.decodeToModel(from: args?.first, type: SubscribeMarketWatchSymbolsResponseModel.self)
            
//            printToLog("chatHub.onReceive subscribe getting responseModel unsubc : \(responseModel)")

        }
        
        //MARK: Orders
        chatHub.onReceive(.sendOrders) { args in
            
//            debugPrint("Send orders args: \(args) ENDEND")
            debugPrint("Send orders args")

            let responseModel =  HubUtility.shared.decodeToModel(from: args?.first, type: [OrderListResponseModel].self)
            
            
            let uiModel = responseModel?.compactMap({
                OrderListUIModel.mapToUIModel($0)
            })
            
            self.orderListDelegate?.onOrderReceived(order: uiModel ?? [])
            
        }
        
        chatHub.onReceive(.sendOrderDetails) { args in
//            printToLog("chatHub.onReceive sendOrderDetails args: \(args as Any)")

        }
        
        chatHub.onReceive(.sendNotifyOrderObject) { args in
//            printToLog("chatHub.onReceive sendNotifyOrderObject args")
//            printToLog("chatHub.onReceive sendNotifyOrderObject args: \(args as Any)")
            
            
            let responseModel =  HubUtility.shared.decodeToModel(from: args?.first, type: SendOrdersResponseModel.self)
            
//            printToLog("chatHub.onReceive sendNotifyOrderObject getting responseModel : \(responseModel)")

//            let uiModel = SendOrdersUIModel.mapToUIModel(responseModel ?? .init())
            
            

//            if uiModel?.StatusCode?.lowercased() == "c" {
//                showLocalNotification(title: "cancel_order".localized, body: "cancel_order_desc".localized)
//            } else {
//                if UserDefaultController().isModifyOrderNotification == true {
//                    showLocalNotification(title: "modify_order".localized, body: "modify_order_desc".localized)
//                } else {
//                    showLocalNotification(title: "place_order".localized, body: "place_order_desc".localized)
//                }
//            }
        }
        
        chatHub.onReceive(.sendAddOrderRequest) { args in
//            printToLog("chatHub.onReceive sendAddOrderRequest args \(args as Any)")
            //let orders = dataParser.parseOrderList(data: args)
            //printToLog("chatHub.onReceive HubUtility.shared.sendOrders success orders count : \( orders.count )")
            //NotificationCenter.default.post(name: Notification.Name(HubNotification.ReloadOrderDetails), object: orders)
        }
        
        
        //MARK: Notifications
        chatHub.onReceive(.sendUserAlertsObject) { args in
//            printToLog("chatHub.onReceive sendUserAlertsObject args: \(args as Any)") //: \( args as Any)")
            
//            let responseModel =  HubUtility.shared.decodeToModel(from: args?.first, type: GetAllPushNotificationsByUserResponseModel.self)
            
//            let uiModel = NotificationUIModel.mapToUIModel(responseModel ?? GetAllPushNotificationsByUserResponseModel.init(date: "", descA: "", descE: "", id: "", isdelete: "", isorder: "", isPush: "", isRead: "", mobileType: "", registrationsID: "", symbol: "", titleA: "", titleE: "", totalValue: "", type: "", url: "", user: "", webcode: ""))
        }
        
        chatHub.onReceive(.sendUserPushAlertsObject) { args in
//            printToLog("chatHub.onReceive sendUserPushAlertsObject args: \(args as Any)") //: \( args as Any)")
            
//            let responseModel =  HubUtility.shared.decodeToModel(from: args?.first, type: GetAllPushNotificationsByUserResponseModel.self)
            
//            let uiModel = NotificationUIModel.mapToUIModel(responseModel ?? GetAllPushNotificationsByUserResponseModel.init(date: "", descA: "", descE: "", id: "", isdelete: "", isorder: "", isPush: "", isRead: "", mobileType: "", registrationsID: "", symbol: "", titleA: "", titleE: "", totalValue: "", type: "", url: "", user: "", webcode: ""))
        }

        
        chatHub.onReceive(.sendNotifyMarketNewsObject) { args in
//            printToLog("chatHub.onReceive sendNotifyMarketNewsObject args: \( args as Any)")
        }
        
        
        //MARK: Portfolio
        chatHub.onReceive(.getPortfolioInitial) { args in
//            printToLog("chatHub.onReceive GetPortfolioInitial args: \(args as Any)")
        }
        
    }
    
    
    
    func logout(withReload: Bool){
        self.chatHub?.connection.stop()
        self.connection?.stop()

        self.connection = nil
        self.chatHub = nil
        
        HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
//        print("[WebCacheCleaner] All cookies deleted")
        
        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
            records.forEach { record in
                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {
//                    print("[WebCacheCleaner] cookies: Record \(record) deleted")
                })
            }
            WKWebsiteDataStore.default().removeData(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes(),for: records, completionHandler: {
//                print("[WebCacheCleaner] delete allWebsiteDataTypes cookies success")
            })
        }
        

    }
    
}

// Im going to call the lookup once in the home
// Then save each sector in a container, for example i want only MRS so i save single container MRS in CoreData



extension Connection_Hub {
    func callGetLookupsAPI() {
        let requestModel = GetLookupsRequestModel()
        let useCase = LookupsUseCase()
        
        getLookupsAPIResult = .onLoading(show: true)
        
        Task.init {
            await useCase.GetLookups(requestModel: requestModel) {[weak self] result in
                switch result {
                case .success(let success):
                    self?.getLookupsAPIResult = .onSuccess(response: success)

                    debugPrint("Lookup success")
                    self?.getLookupsList = success.filter({$0.type == "MRS"})
       
                case .failure(let failure):
                        self?.getLookupsAPIResult = .onFailure(error: failure)
                }
            }
        }
    }
    
    private func tryUpdateMarketStatus() {
        // Only update when BOTH are ready
        guard let lookups = getLookupsList,
              let marketData = exchangeMarketSummaryData else {
            return
        }
        updateMarketStatus(using: marketData, lookups: lookups)
    }

    
    func updateMarketStatus(using marketData: [GetExchangeSummaryUIModel], lookups: [GetLookupsUIModel]) {
        guard let firstStatusCode = marketData.first?.statusCode else { return }

        if let lookupItem = getLookupsList?.first(where: { $0.type == "MRS" && $0.id == firstStatusCode }) {
            let userDefaultController = UserDefaultController.instance
            userDefaultController.marketStatusTitle = AppUtility.shared.isRTL ? lookupItem.descA : lookupItem.descE
            userDefaultController.marketStatusCode = lookupItem.id
        }
    }
}



public enum MessageType: Int, Codable {
    case Invocation = 1
    case StreamItem = 2
    case Completion = 3
    case StreamInvocation = 4
    case CancelInvocation = 5
    case Ping = 6
    case Close = 7
}
