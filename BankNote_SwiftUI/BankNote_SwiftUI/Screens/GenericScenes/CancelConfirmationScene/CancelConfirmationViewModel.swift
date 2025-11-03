//
//  SelectSharesViewModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 03/08/2025.
//

import Foundation

class CancelConfirmationViewModel: ObservableObject {
    private var coordinator: GenericCoordinatorProtocol
    
    @Published var transactionType: TransactionTypes?
    
    init(coordinator: GenericCoordinatorProtocol, transactionType: TransactionTypes) {
        self.coordinator = coordinator
        self.transactionType = transactionType
    }
    
    func onConfirm() {
        coordinator.dismiss()
        coordinator.popViewController()
    }
    
    func onDismiss() {
        coordinator.dismiss()
    }

}
