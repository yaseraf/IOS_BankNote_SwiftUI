//
//  AlertsViewModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 18/08/2025.
//

import Foundation
class AlertsViewModel: ObservableObject {
    private let coordinator: GenericCoordinatorProtocol
    
    @Published var alertsData: [AlertsUIModel]?
    
    init(coordinator: GenericCoordinatorProtocol) {
        self.coordinator = coordinator
        alertsData = []
    }
    
    func onBackTap() {
        coordinator.popViewController()
    }
    
    func openAddAlertsScene() {
        coordinator.openAddAlertScene()
    }
    
    func getAlertsData() {
        var data: [AlertsUIModel] = []
        data.append(AlertsUIModel(image: "ic_qnbLogo", fullNameEn: "Qatar National Bank", fullNameAr: "بنك قطر الوطني", symbol: "QNB", date: "04-12-2025", value: 1500, alertNo: 4, priceFactor: "avg", state: "new"))
        
        alertsData = data
    }
}
