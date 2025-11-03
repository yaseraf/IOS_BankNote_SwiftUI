//
//  IndexViewModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 10/09/2025.
//

import Foundation

class IndexViewModel: ObservableObject {
    private let coordinator: TradeCoordinatorProtocol
    private let useCase: TradeUseCaseProtocol

    @Published var indexData: [IndexUIModel]?
    @Published var listMarketOverView:[GetExchangeSummaryUIModel]?

    @Published var getExchangeSummaryAPIResult:APIResultType<[GetExchangeSummaryUIModel]>?

    init(coordinator: TradeCoordinatorProtocol, useCase: TradeUseCaseProtocol) {
        self.coordinator = coordinator
        self.useCase = useCase
        
        Connection_Hub.shared.exchangeSummaryDelegate = self
        
        indexData = []
        listMarketOverView = []
    }
    
        
    }

// MARK: Routing
extension IndexViewModel {
    func popViewController() {
        coordinator.popViewController()
    }
}

// MARK: Mock Data
extension IndexViewModel {
    func getIndexData() {
        var data: [IndexUIModel] = []
        
        data.append(IndexUIModel(image: "ic_indexPlaceholder", name: "EGX 30", changePerc: 0.016, value: 2262.43))
        data.append(IndexUIModel(image: "ic_indexPlaceholder", name: "EGX 70", changePerc: -0.20, value: 9550.43))
        data.append(IndexUIModel(image: "ic_indexPlaceholder", name: "EGX 100", changePerc: 0.016, value: 9550.43))
        data.append(IndexUIModel(image: "ic_indexPlaceholder", name: "EGX 100", changePerc: 0.016, value: 9550.43))
        data.append(IndexUIModel(image: "ic_indexPlaceholder", name: "EGX 100", changePerc: 0.016, value: 9550.43))
        
        indexData = data
    }

}

// MARK: API CALLS
extension IndexViewModel {
    func GetExchangeSummaryAPI(success:Bool) {
        let requestModel = GetExchangeSummaryRequestModel()
        
        getExchangeSummaryAPIResult = .onLoading(show: true)
        
        Task.init {
            await useCase.GetExchangeSummary(requestModel: requestModel) {[weak self] result in
                
                self?.getExchangeSummaryAPIResult = .onLoading(show: false)

                switch result {
                case .success(let success):
                     self?.getExchangeSummaryAPIResult = .onSuccess(response: success)
                    debugPrint("Exchange summary success")

                    self?.listMarketOverView = success
                    
                case .failure(let failure):
                        self?.getExchangeSummaryAPIResult = .onFailure(error: failure)
                    debugPrint("Overview failure: \(failure)")
                }
            }
        }
    }

}

// MARK: Delegates
extension IndexViewModel: ExchangeSummaryDelegate {
    func onDataFetch(model: [GetExchangeSummaryUIModel]) {
        UserDefaultController().isMarketOpen = model.first?.statusCode == "0002" || model.first?.statusCode == "0003" ? true : false
        
        for (index, item) in (listMarketOverView ?? []).enumerated() {
            if let match = model.first(where: { $0.isinCode == item.indexCode }) {
                listMarketOverView?[index].currentValue = match.currentValue
                listMarketOverView?[index].netChange = match.netChange
                listMarketOverView?[index].netChangePerc = match.netChangePerc
                listMarketOverView?[index].statusCode = match.statusCode
                
                // Handled in Coonection_Hub
//                self.filterMarketStatus()
            }
        }
    }
}
