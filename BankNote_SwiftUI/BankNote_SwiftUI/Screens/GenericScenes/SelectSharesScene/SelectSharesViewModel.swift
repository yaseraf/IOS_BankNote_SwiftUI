//
//  SelectSharesViewModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 03/08/2025.
//

import Foundation

class SelectSharesViewModel: ObservableObject {
    private var coordinator: GenericCoordinatorProtocol
    private let delegate: SelectSharesDelegate
    
    @Published var sharesDataTelecom: [SharesUIModel]?
    @Published var sharesDataInsurance: [SharesUIModel]?
    @Published var selectedShare: SharesUIModel?
    
    
    
    init(coordinator: GenericCoordinatorProtocol, delegate: SelectSharesDelegate) {
        self.coordinator = coordinator
        self.delegate = delegate
    }
    
    func onConfirm(share: SharesUIModel?) {
        delegate.onSelect(share: share)
        coordinator.dismiss()
    }
    
    func onDismiss() {
        coordinator.dismiss()
    }
    
    func getSharesData() {
        var testData: [SharesUIModel] = []
        
        
        testData.append(SharesUIModel(stockId: 1, image: "ic_QNBK", name: "QNBK", fullNameE: "Doha Bank", fullNameA: "بنك الدوحة"))
        
        testData.append(SharesUIModel(stockId: 2, image: "ic_ABQK", name: "ABQK", fullNameE: "Ahli Bank", fullNameA: "البنك الأهلي"))
        
        testData.append(SharesUIModel(stockId: 3, image: "ic_DOHI", name: "DOHI", fullNameE: "Doha Insurance Group", fullNameA: "مجموعة الدوحة للتأمين"))
        
        sharesDataTelecom = testData
        
        testData.removeAll()
        
        testData.append(SharesUIModel(stockId: 4, image: "ic_QIB", name: "QIBK", fullNameE: "Qatar Islamic Bank", fullNameA: "المصرف"))
        
        testData.append(SharesUIModel(stockId: 5, image: "ic_DOHI", name: "DOHI", fullNameE: "Doha Insurance Group", fullNameA: "مجموعة الدوحة للتأمين"))

        testData.append(SharesUIModel(stockId: 6, image: "ic_ABQK", name: "ABQK", fullNameE: "Ahli Bank", fullNameA: "البنك الأهلي"))
        
        testData.append(SharesUIModel(stockId: 7, image: "ic_DOHI", name: "DOHI", fullNameE: "Doha Insurance Group", fullNameA: "مجموعة الدوحة للتأمين"))
        
        testData.append(SharesUIModel(stockId: 8, image: "ic_QNBK", name: "QNBK", fullNameE: "Doha Bank", fullNameA: "بنك الدوحة"))
        
        sharesDataInsurance = testData

    }
}
