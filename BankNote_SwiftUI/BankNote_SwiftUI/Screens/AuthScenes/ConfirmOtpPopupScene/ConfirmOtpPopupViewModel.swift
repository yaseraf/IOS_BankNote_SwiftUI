//
//  VerifyOtpPopupViewModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 22/07/2025.
//

import Foundation
import Combine

class ConfirmOtpPopupViewModel: ObservableObject {
    private var coordinator: AuthCoordinatorProtocol
    private var anyCancellable: AnyCancellable? = nil
    @Published var timerViewModel:OTPTimerViewModel
    @Published var otpExpirationTimer: Double = 60
    
    @Published var forgotType: ForgotDataEnum

    init(coordinator: AuthCoordinatorProtocol, forgotType: ForgotDataEnum) {
        self.coordinator = coordinator
        self.forgotType = forgotType
        self.timerViewModel = .init()
        
        anyCancellable = timerViewModel.objectWillChange.sink { [weak self] (_) in
            self?.objectWillChange.send()
        }
    }
    
    func onDismiss() {
        coordinator.dismiss()
        
    }
    
    func onVerify() {
        if forgotType == .forgotPassword {
            coordinator.dismiss()
            coordinator.openChangePasswordScene()
        } else if forgotType == .forgotPin {
            coordinator.dismiss()
            coordinator.openChangePinScene()
        }
    }
    
    
}

// MARK: Timer
extension ConfirmOtpPopupViewModel {


    func initTimer() {
        timerViewModel.initTimer()
    }

    func startTimer() {
        timerViewModel.startTimer(resentOtpTimer: otpExpirationTimer)
    }

     func handleTimerValue(second: Int) {
         timerViewModel.handleTimerValue(second: second )

    }

    func endTimerIfNeed() {
        timerViewModel.endTimerIfNeed()
    }
}
