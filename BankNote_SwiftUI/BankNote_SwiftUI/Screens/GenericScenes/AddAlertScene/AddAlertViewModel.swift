//
//  AddAlertViewModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 19/08/2025.
//

import Foundation
class AddAlertViewModel: ObservableObject {
    private let coordinator: GenericCoordinatorProtocol
    
    @Published var selectedShare: SharesUIModel?
    @Published var selectedPriceFactor: PriceFactorUIModel?
    @Published var shareValue: String
    @Published var selectedExpiryTime: String?
    
    init(coordinator: GenericCoordinatorProtocol) {
        self.coordinator = coordinator
        
        selectedShare = .initializer()
        selectedPriceFactor = .initializer()
        shareValue = ""
        selectedExpiryTime = ""
    }
    
    func onBackTap() {
        coordinator.popViewController()
    }
    
    func onAddTap() {
        coordinator.popViewController()
    }
    
    func openSelectSharesScene() {
        SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getGenericCoordinator().openSelectSharesScene(delegate: self)
    }
    
    func openSelectPriceFactorScene() {
        SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getGenericCoordinator().openSelectPriceFactorScene(delegate: self)
    }
    
    func openSelectExpiryTimeScene() {
        SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getGenericCoordinator().openRangeCalendarScene(delegate: self, title: "expiry_date".localized, isMultiSelect: false)
    }

}

extension AddAlertViewModel: SelectSharesDelegate {
    func onSelect(share: SharesUIModel?) {
        selectedShare = share
    }
}

extension AddAlertViewModel: SelectPriceFactorDelegate {
    func onSelect(factor: PriceFactorUIModel) {
        selectedPriceFactor = factor
    }
}

extension AddAlertViewModel: RangeCalendarDelegate {
    func onSelect(selectedDateFrom: Date?, selectedDateTo: Date?) {
        selectedExpiryTime = selectedDateFrom?.toString(dateFormat: .ddMMyyyy)
    }
}
