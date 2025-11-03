//
//  CountryPickerViewModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 07/09/2025.
//

import Foundation

class CountryPickerViewModel: ObservableObject {
    private let coordinator: AuthCoordinatorProtocol
    
    init(coordinator: AuthCoordinatorProtocol) {
        self.coordinator = coordinator
    }
}
