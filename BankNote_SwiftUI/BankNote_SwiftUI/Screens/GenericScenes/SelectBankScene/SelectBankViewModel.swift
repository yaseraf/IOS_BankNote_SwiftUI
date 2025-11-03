//
//  SelectSharesViewModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 03/08/2025.
//

import Foundation

class SelectBankViewModel: ObservableObject {
    private var coordinator: GenericCoordinatorProtocol
    private let delegate: SelectBankDelegate
    
    @Published var selectedBank: BankUIModel?
    @Published var banksData: [BankUIModel]?
    
    init(coordinator: GenericCoordinatorProtocol, delegate: SelectBankDelegate, selectedBank: BankUIModel?) {
        self.coordinator = coordinator
        self.delegate = delegate
        self.selectedBank = selectedBank
    }
    
    func onConfirm(bank: BankUIModel?) {
        delegate.onSelect(bank: bank)
        coordinator.dismiss()
    }
    
    func onDismiss() {
        coordinator.dismiss()
    }
    
    func getBanksData() {
        var bankData: [BankUIModel] = []
        bankData.append(BankUIModel(bankNumber: "XXXX-0011-1111"))
        bankData.append(BankUIModel(bankNumber: "QA39-xxxx-7777)"))
        bankData.append(BankUIModel(bankNumber: "QA79-xxxx-1110"))
       

        banksData = bankData
    }
}
