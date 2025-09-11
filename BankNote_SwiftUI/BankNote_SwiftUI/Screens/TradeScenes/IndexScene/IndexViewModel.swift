//
//  IndexViewModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 10/09/2025.
//

import Foundation

class IndexViewModel: ObservableObject {
    private let coordinator: TradeCoordinatorProtocol
    
    @Published var indexData: [IndexUIModel]?
    
    init(coordinator: TradeCoordinatorProtocol) {
        self.coordinator = coordinator
        
        indexData = []
    }
    
    func popViewController() {
        coordinator.popViewController()
    }
    
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
