//
//  VerifyScanIDFrontViewModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 15/09/2025.
//

import Foundation
import SwiftUI

class VerifyScanIDFrontViewModel: ObservableObject {
    private let coordinator: AuthCoordinatorProtocol
    private let delegate:CameraPreviewDelegate
    
    @Published var savedImageOne:Image?
    @Published var isFrontID:Bool
    @Published var address:String
    @Published var name:String
    @Published var dateOfBirth:String
    @Published var idNumber:String
    @Published var idKey:String
    
    init(coordinator: AuthCoordinatorProtocol, delegate: CameraPreviewDelegate, savedImageOne:Image?, isFrontID: Bool, address: String, name: String, dateOfBirth: String, idNumber: String, idKey: String) {
        self.coordinator = coordinator
        self.delegate = delegate
        self.savedImageOne = savedImageOne
        self.isFrontID = isFrontID
        self.address = address
        self.name = name
        self.dateOfBirth = dateOfBirth
        self.idNumber = idNumber
        self.idKey = idKey
        
        self.dateOfBirth = formatJsonDate(self.dateOfBirth)
        
    }
}

// MARK: Routing
extension VerifyScanIDFrontViewModel {
    
    func popViewController() {
        coordinator.popViewController()
    }
    
    func openScanIDBackScene() {
        coordinator.openScanIDBackScene()
    }
    
}

// MARK: Functions
extension VerifyScanIDFrontViewModel {
    func formatJsonDate(_ jsonDate: String) -> String {
        let pattern = #"\/Date\((\d+)([+-]\d+)?\)\/"#
        let regex = try? NSRegularExpression(pattern: pattern)
        let range = NSRange(jsonDate.startIndex..<jsonDate.endIndex, in: jsonDate)
        
        if let match = regex?.firstMatch(in: jsonDate, options: [], range: range),
           let millisRange = Range(match.range(at: 1), in: jsonDate) {
            
            let millisString = String(jsonDate[millisRange])
            if let millis = Double(millisString) {
                let date = Date(timeIntervalSince1970: millis / 1000)
                let formatter = DateFormatter()
                formatter.dateFormat = "dd/MM/yyyy"
                formatter.locale = Locale.current
                return formatter.string(from: date)
            }
        }
        
        return "Invalid date"
    }

}
