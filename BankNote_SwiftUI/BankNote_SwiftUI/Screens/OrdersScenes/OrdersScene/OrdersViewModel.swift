//
//  OrdersViewModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 09/09/2025.
//

import Foundation

class OrdersViewModel: ObservableObject {
    private let coordinator: OrdersCoordinatorProtocol
    
    @Published var ordersData: [OrdersUIModel]?
    
    init(coordinator: OrdersCoordinatorProtocol) {
        self.coordinator = coordinator
        
        ordersData = []
    }
    
    func getOrdersData() {
        var data: [OrdersUIModel] = []
        
        data.append(OrdersUIModel(image: "ic_adnocdistStock", type: "buy".localized, name: "ADNOCDIST", time: "28/05/2025    02:47 pm", value: -84.59, status: "pending".localized))
        data.append(OrdersUIModel(image: "ic_nvidiaStock", type: "buy".localized, name: "NVIDIA", time: "27/05/2025    12:34 pm", value: -150.35, status: "completed".localized))
        data.append(OrdersUIModel(image: "ic_topUp", type: "", name: "top_up", time: "27/05/2025    10:29pm", value: -400, status: "completed".localized))
        
        ordersData = data
    }
}
