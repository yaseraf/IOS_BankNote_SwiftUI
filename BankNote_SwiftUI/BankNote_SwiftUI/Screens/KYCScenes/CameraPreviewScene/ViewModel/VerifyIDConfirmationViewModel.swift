//
//  CameraPreviewViewModel.swift
//  mahfazati
//
//  Created by FIT on 09/08/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation
import SwiftUI
//import MLImage
//import MLKit

class VerifyIDConfirmationViewModel:ObservableObject{
    private let coordinator: AuthCoordinatorProtocol
    private let delegate:CameraPreviewDelegate
    
    @Published var savedImageOne:Image?
    @Published var isFrontID:Bool
    @Published var address:String
    @Published var name:String
    @Published var dateOfBirth:String
    @Published var idNumber:String
    @Published var idKey:String
    @Published var gender:String
    @Published var jobTitle:String
    @Published var religion:String
    @Published var maritalStatus:String
    
    init(coordinator: AuthCoordinatorProtocol, delegate: CameraPreviewDelegate, savedImageOne:Image?, isFrontID: Bool, address: String, name: String, dateOfBirth: String, idNumber: String, idKey: String, gender: String, jobTitle: String, religion: String, maritalStatus: String) {
        
        self.coordinator = coordinator
        self.delegate = delegate
        self.savedImageOne = savedImageOne
        self.isFrontID = isFrontID
        self.address = address
        self.name = name
        self.dateOfBirth = dateOfBirth
        self.idNumber = idNumber
        self.idKey = idKey
        self.gender = gender
        self.jobTitle = jobTitle
        self.religion = religion
        self.maritalStatus = maritalStatus
        
        self.dateOfBirth = formatJsonDate(self.dateOfBirth)
        
    }
    
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
    
    func dismiss() {
        delegate.onRetake(isFrontScan: isFrontID)
        coordinator.popViewController()
    }
    
    func openTakeSelfieScene() {
        
        if isFrontID {
            coordinator.openCameraPreviewFor(type: .scanMode(.nationalId), savedImageOne: savedImageOne, stepIndexBind: 2, isFrontBind: false)
        } else {
            coordinator.openTakeSelfieScene(livenessCheck: true)

        }
    }
}
