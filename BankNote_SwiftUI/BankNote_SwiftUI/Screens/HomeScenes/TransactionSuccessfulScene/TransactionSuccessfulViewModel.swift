//
//  TransactionSuccessfulViewModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 10/09/2025.
//

import Foundation

class TransactionSuccessfulViewModel: ObservableObject {
    private let coordinator: HomeCoordinatorProtocol
    
    @Published var transactionType: TransactionTypes?
    
    init(coordinator: HomeCoordinatorProtocol, transactionType: TransactionTypes) {
        self.coordinator = coordinator
        
        self.transactionType = transactionType
    }
    
}

extension TransactionSuccessfulViewModel {
    func popViewController() {
        coordinator.popMultipleViews(count: 3)
    }
}
