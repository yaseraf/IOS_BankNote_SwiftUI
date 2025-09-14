//
//  BankNotesViewModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 14/09/2025.
//

import Foundation
import SwiftUI

// The main data model for a row item.
struct RowItem: Identifiable {
    let id = UUID()
    let title: String
    let value: String
    let color: Color
    let icon: String?
}

class BankNotesViewModel:ObservableObject {
    private let coordinator: SettingsCoordinatorProtocol
    
    
    
    @Published var topUpItems: [RowItem] = [
        RowItem(title: "100 EGP", value: "1000 BN", color: .purple, icon: nil),
        RowItem(title: "150 EGP", value: "1500 BN", color: .purple, icon: nil),
        RowItem(title: "200 EGP", value: "2000 BN", color: .purple, icon: nil),
        RowItem(title: "250 EGP", value: "2500 BN", color: .purple, icon: nil),
        RowItem(title: "300 EGP", value: "3000 BN", color: .purple, icon: nil),
    ]
    
    @Published var rewardsItems: [RowItem] = [
        RowItem(title: "1 Month Spotify", value: "1000 BN", color: Color("SpotifyGreen"), icon: "play.circle"),
        RowItem(title: "25% OFF Netflix", value: "1500 BN", color: Color("NetflixRed"), icon: "play.rectangle"),
    ]
    
    init(coordinator: SettingsCoordinatorProtocol) {
        self.coordinator = coordinator
    }
}

// MARK: Routing
extension BankNotesViewModel {
    func popViewController() {
        coordinator.popViewController()
    }
    
    func openPaymentMethodScene() {
        SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getHomeCoordinator().openPaymentMethodScene(transactionType: .topUp)
    }
}
