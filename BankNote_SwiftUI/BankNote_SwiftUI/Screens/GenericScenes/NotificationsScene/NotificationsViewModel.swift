//
//  NotificationsViewModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 08/03/2026.
//

import Foundation
import SwiftUICharts
import SwiftUI

class NotificationsViewModel:ObservableObject{
    private let coordinator:HomeCoordinatorProtocol
    private let lookupsUseCase: LookupsUseCaseProtocol
    
    @Published var tabSelect:NotificationsTabs = .orders
    
    @Published var notifications: [NotificationObject]?
    @Published var filterOSSList: [GetLookupsUIModel]? = []
    @Published var getLookupsList: [GetLookupsUIModel]?

    @Published var getLookupsAPIResult:APIResultType<[GetLookupsUIModel]>?

    init(coordinator: HomeCoordinatorProtocol, tabSelect:NotificationsTabs, lookupsUseCase: LookupsUseCaseProtocol) {
        self.coordinator = coordinator
        self.tabSelect = tabSelect
        self.lookupsUseCase = lookupsUseCase
        
        self.notifications = UserDefaultController().notifiedOrders
        self.callGetLookupsAPI()

        Connection_Hub.shared.notifyOrderDelegate = self
        Connection_Hub.shared.alertsDelegate = self

                        
    }

    func changeTap(tab:NotificationsTabs){
        self.tabSelect = tab
    }
    

}

// MARK: Routing
extension NotificationsViewModel {
    func popViewController() {
        coordinator.popViewController()
    }
}

// MARK: API Calls
extension NotificationsViewModel {
    func callGetLookupsAPI() {
        let requestModel = GetLookupsRequestModel()
        getLookupsAPIResult = .onLoading(show: true)
        
        Task.init {
            await lookupsUseCase.GetLookups(requestModel: requestModel) {[weak self] result in
                self?.getLookupsAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    self?.getLookupsAPIResult = .onSuccess(response: success)
                    self?.getLookupsList = success.filter({$0.type == "OSS"})
                    UserDefaultController().tifList = success.filter({$0.type == "TIF"})
                    UserDefaultController().CUSTODYID = success.filter({$0.type == "CUST"}).first?.id ?? ""
                    self?.filterOSSList = self?.getLookupsList
//                    self?.filterLookUps()

                case .failure(let failure):
                        self?.getLookupsAPIResult = .onFailure(error: failure)
                    debugPrint("get lookups failure: \(failure)")

                }
            }
        }
    }

}

// MARK: Delegates
extension NotificationsViewModel: NotifyOrderDelegate {
    func onNotifyOrder(newOrder: SendOrdersUIModel) {
        notifications?.append(NotificationObject(symbol: newOrder.Symbol ?? "", companyName: AppUtility.shared.isRTL ? newOrder.CompanyShortNameA ?? "" : newOrder.CompanyShortNameE ?? "", orderId: newOrder.OrderID ?? "", quantity: newOrder.TotalVolume ?? "", price: newOrder.Price ?? "", statusCode: newOrder.StatusCode ?? "", alertTitle: "", alertDesc: "", newsTitle: "", newsDesc: "", objectType: "o"))
    }
    func onNewOrder(newOrder: OrderListUIModel) {
    }
}

extension NotificationsViewModel:AlertsDelegate {
    func onReceiveCount() {
        
    }
    
    func onReceiveAlert(model: NotificationUIModel) {
        showLocalNotification(title: (AppUtility.shared.isRTL ? model.titleA : model.titleE) ?? "" , body: (AppUtility.shared.isRTL ? model.descA : model.descE) ?? "")
        
        notifications?.append(NotificationObject(symbol: model.symbol ?? "", companyName: "", orderId: "", quantity: "", price: "", statusCode: "", alertTitle: AppUtility.shared.isRTL ? model.titleA ?? "" : model.titleE ?? "", alertDesc: AppUtility.shared.isRTL ? model.descA ?? "" : model.descE ?? "", newsTitle: "", newsDesc: "", objectType: "a"))
    }
    
    func onReceiveNews(model: MarketNewsObject) {
        notifications?.append(NotificationObject(symbol: model.Symbol ?? "", companyName: "", orderId: "", quantity: "", price: "", statusCode: "", alertTitle: "", alertDesc: "", newsTitle: model.NotifyID ?? "", newsDesc: AppUtility.shared.isRTL ? model.NewsDescA ?? "" : model.NewsDescE ?? "", objectType: "n"))
    }
}
