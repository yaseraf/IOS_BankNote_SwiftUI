//
//  PortfolioViewModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 08/09/2025.
//

import Foundation

class PortfolioViewModel: ObservableObject {
    private let coordinator: PortfolioCoordinatorProtocol
    
    @Published var portfoliosData: [PortfolioUIModel]?

    init(coordinator: PortfolioCoordinatorProtocol) {
        self.coordinator = coordinator

        self.portfoliosData = []
    }
    
    func getPortfolioData() {
        var data: [PortfolioUIModel] = []
        
        data.append(PortfolioUIModel(image: "ic_adnocdistStock", name: "ADNOCDIST", price: 3.85, change: 0.45, changePerc: 1.25))
        data.append(PortfolioUIModel(image: "ic_nvidiaStock", name: "NVIDIA", price: 650.50, change: 25.00, changePerc: -2.10))
        data.append(PortfolioUIModel(image: "ic_fabStock", name: "FAB", price: 7.50, change: 0.80, changePerc: 0.45))
        data.append(PortfolioUIModel(image: "ic_teslaStock", name: "Tesla", price: 890.00, change: 12.10, changePerc: 1.35))
        
        portfoliosData = data
    }
}

// MARK: Routing
extension PortfolioViewModel {
    func openStockDetailsScene() {
        coordinator.openStockDetailsScene()
    }
}
