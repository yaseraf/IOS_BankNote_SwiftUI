//
//  RangeCalendarViewModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 14/08/2025.
//

import Foundation
class RangeCalendarViewModel: ObservableObject {
    private let coordinator: GenericCoordinatorProtocol
    let delegate: RangeCalendarDelegate
    
    @Published var title: String?
    @Published var selectedDateFrom: Date?
    @Published var selectedDateTo: Date?
    @Published var isMultiSelect: Bool?
    
    init(coordinator: GenericCoordinatorProtocol, delegate: RangeCalendarDelegate, title: String?, isMultiSelect: Bool?) {
        self.coordinator = coordinator
        self.delegate = delegate
        self.title = title
        self.isMultiSelect = isMultiSelect
    }
    
    func onDismissTap() {
        coordinator.dismiss()
        delegate.onSelect(selectedDateFrom: selectedDateFrom, selectedDateTo: selectedDateTo)
    }
    
    func onConfirmTap() {
        coordinator.dismiss()
        delegate.onSelect(selectedDateFrom: selectedDateFrom, selectedDateTo: selectedDateTo)
    }
}
