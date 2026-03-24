//
//  PortfolioViewModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 08/09/2025.
//

import Foundation
import SwiftUI

class PortfolioViewModel: ObservableObject {
    private let coordinator: PortfolioCoordinatorProtocol
    private let useCase: HomeUseCaseProtocol

    @Published var portfolioData: GetPortfolioUIModel?
    @Published var pieChartData: [PieSliceData]?
    @Published var stockData:GetALLMarketWatchBySymbolUIModel?

    @Published var getPortfolioAPIResult:APIResultType<GetPortfolioUIModel>?

    
    init(coordinator: PortfolioCoordinatorProtocol, useCase: HomeUseCaseProtocol) {
        self.coordinator = coordinator
        self.useCase = useCase
        
        pieChartData = []
        Connection_Hub.shared.notifyOrderDelegate = self

    }
    
    
}

// MARK: Mock Data
extension PortfolioViewModel {
    func getPortfolioData() {
//        var data: [PortfolioUIModel] = []
//
//        data.append(PortfolioUIModel(image: "ic_adnocdistStock", name: "ADNOCDIST", price: 3.85, change: 0.45, changePerc: 1.25))
//        data.append(PortfolioUIModel(image: "ic_nvidiaStock", name: "NVIDIA", price: 650.50, change: 25.00, changePerc: -2.10))
//        data.append(PortfolioUIModel(image: "ic_fabStock", name: "FAB", price: 7.50, change: 0.80, changePerc: 0.45))
//        data.append(PortfolioUIModel(image: "ic_teslaStock", name: "Tesla", price: 890.00, change: 12.10, changePerc: 1.35))
//
//        portfoliosData = data
    }
}

// MARK: Routing
extension PortfolioViewModel {
    func openStockDetailsScene(symbol: String, marketType: String, custodianID: String, custodianName: String) {
        
        let selectedStock:GetCompaniesLookupsUIModel = AppUtility.shared.loadCompanies().filter({$0.symbol == UserDefaultController().selectedSymbol ?? ""}).first ?? .testUIModel()

        UserDefaultController().selectedSymbol = symbol
        UserDefaultController().selectedSymbolID = selectedStock.symbolID
        UserDefaultController().selectedSymbolType = marketType
        UserDefaultController().selectedCustodian = custodianID
        UserDefaultController().CUSTODYID = custodianID
        UserDefaultController().selectedCustodianName = custodianName
        coordinator.openStockDetailsScene(symbol: symbol, marketType: marketType)
    }
}

// MARK: API CALLS
extension PortfolioViewModel {
    func callGetPortfolioAPI(success: Bool) {
                
        let requestModel = GetPortfolioRequestModel()
        
        getPortfolioAPIResult = .onLoading(show: true)
        
        Task.init {
            await useCase.getPortfolio(requestModel: requestModel) {[weak self] result in
                
                self?.getPortfolioAPIResult = .onLoading(show: false)
                
                switch result {
                case .success(let success):
                    
                    debugPrint("Success to get user portfolio")
                        self?.getPortfolioAPIResult = .onSuccess(response: success)
                    
                    self?.portfolioData = success
                    self?.pieChartData = self?.makePieSliceData(from: success.portfolioChart.chartData ?? [])
                    
                case .failure(let failure):
                        debugPrint("Failed to get user portfolio")
                        self?.getPortfolioAPIResult = .onFailure(error: failure)
                }
            }
        }
    }
}

// MARK: Functions
extension PortfolioViewModel {
    func makePieSliceData(from portfolioes: [ChartDatum]) -> [PieSliceData] {
        
        // 1. Sort descending by prClosePrice
        let sorted = portfolioes.sorted{(Double($0.avg ?? "") ?? 0) > (Double($1.avg ?? "") ?? 0)}
        
        // 2. Take top 4
//        let top4 = Array(sorted.prefix(4))
        
        // 3. Compute total of top4 prices
        let total = sorted.map { Double($0.avg ?? "") ?? 0 }.reduce(0, +)
        
        let pieColors = [
            Color(hex: "#629AF9"), // blue
            Color(hex: "#FC814B"), // green
            Color(hex: "#9C4EF7"), // orange
            Color(hex: "#4A7061")  // pink
        ]
        
        // 4. Normalize to 100%
        return sorted.enumerated().map { index, portfolio in
            let percentage = ((Double(portfolio.avg ?? "") ?? 0) / total) * 100
            return PieSliceData(
                value: percentage,
                color: pieColors[index % pieColors.count], // or your colorForCompany mapping
                label: portfolio.tickerID ?? ""
            )
        }
    }
}

// MARK: - Delegates
extension PortfolioViewModel: NotifyOrderDelegate {
    func onNotifyOrder(newOrder: SendOrdersUIModel) {
        if newOrder.StatusCode?.lowercased() == "p" || newOrder.StatusCode?.lowercased() == "s" { // Partially or fully filled
            callGetPortfolioAPI(success: true)
        }
    }
    func onNewOrder(newOrder: OrderListUIModel) {
    }
}
