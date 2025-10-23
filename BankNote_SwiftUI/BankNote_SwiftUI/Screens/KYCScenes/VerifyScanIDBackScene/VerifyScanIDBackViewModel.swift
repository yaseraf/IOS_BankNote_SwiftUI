//
//  VerifyScanIDFrontViewModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 15/09/2025.
//

import Foundation
import SwiftUI

class VerifyScanIDBackViewModel: ObservableObject {
    private let coordinator: AuthCoordinatorProtocol
    private let delegate:CameraPreviewDelegate

    @Published var savedImageOne:Image?
    @Published var isFrontID:Bool
    @Published var gender:String
    @Published var jobTitle:String
    @Published var religion:String
    @Published var maritalStatus:String

    init(coordinator: AuthCoordinatorProtocol, delegate: CameraPreviewDelegate, savedImageOne:Image?, isFrontID: Bool, gender: String, jobTitle: String, religion: String, maritalStatus: String) {
        self.coordinator = coordinator
        self.savedImageOne = savedImageOne
        self.isFrontID = isFrontID
        self.delegate = delegate
        self.gender = gender
        self.jobTitle = jobTitle
        self.religion = religion
        self.maritalStatus = maritalStatus
    }
}

// MARK: Routing
extension VerifyScanIDBackViewModel {
    func popViewController() {
        delegate.onRetake(isFrontScan: isFrontID)
        coordinator.popViewController()
    }
    
    func openLivenessCheckScene() {
        coordinator.openLivenessCheckScene()
    }
    
}

// MARK: Functions
extension VerifyScanIDBackViewModel {
    
}

