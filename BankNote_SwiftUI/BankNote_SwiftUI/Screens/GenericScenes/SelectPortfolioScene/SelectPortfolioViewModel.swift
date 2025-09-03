//
//  SelectSharesViewModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 03/08/2025.
//

import Foundation

class SelectPortfolioViewModel: ObservableObject {
    private var coordinator: GenericCoordinatorProtocol
    private let delegate: SelectPortfolioDelegate
    
    @Published var selectedUser: UserUIModel?
    @Published var usersData: [UserUIModel]?
    
    init(coordinator: GenericCoordinatorProtocol, delegate: SelectPortfolioDelegate, selectedUser: UserUIModel?) {
        self.coordinator = coordinator
        self.delegate = delegate
        self.selectedUser = selectedUser
    }
    
    func onConfirm(user: UserUIModel?) {
        delegate.onSelect(user: user)
        coordinator.dismiss()
    }
    
    func onDismiss() {
        coordinator.dismiss()
    }
    
    func getUsersData() {
        var userData: [UserUIModel] = []
        userData.append(UserUIModel(userID: "398235", nameEn: "AlSaed Younes", nameAr: "السيد يونس", purchasingPower: 41914134, purchasingValue: 41914134, commission: 41914134, totalValue: 41914134))
        userData.append(UserUIModel(userID: "397235", nameEn: "Marwan Elsayed Younes", nameAr: "مروان السيد أحمد", purchasingPower: 41914134, purchasingValue: 41914134, commission: 41914134, totalValue: 41914134))
        userData.append(UserUIModel(userID: "396235", nameEn: "Mona Elsayed Younes", nameAr: "مني السيد أحمد", purchasingPower: 41914134, purchasingValue: 41914134, commission: 41914134, totalValue: 41914134))

        usersData = userData
    }
}
