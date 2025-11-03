//
//  SelectPriceFactorViewModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 19/08/2025.
//

import Foundation
class SelectPriceFactorViewModel: ObservableObject {
    private let coordinator: GenericCoordinatorProtocol
    let delegate: SelectPriceFactorDelegate?
    
    @Published var priceFactors: [PriceFactorUIModel]?
    
    init(coordinator: GenericCoordinatorProtocol, delegate: SelectPriceFactorDelegate) {
        self.coordinator = coordinator
        self.delegate = delegate
        priceFactors = []
    }
    
    func getPriceFactors() {
        var data: [PriceFactorUIModel] = []
        data.append(PriceFactorUIModel(factorId: 0, factorName: "the_highest_price"))
        data.append(PriceFactorUIModel(factorId: 1, factorName: "last_price"))
        data.append(PriceFactorUIModel(factorId: 2, factorName: "average_price"))
        data.append(PriceFactorUIModel(factorId: 3, factorName: "total_quantity"))
        data.append(PriceFactorUIModel(factorId: 4, factorName: "lower_price"))
        
        priceFactors = data
    }
    
    func onDismiss() {
        coordinator.dismiss()
    }
    
    func onConfirm(factor: PriceFactorUIModel) {
        delegate?.onSelect(factor: factor)
        coordinator.dismiss()
    }
}
