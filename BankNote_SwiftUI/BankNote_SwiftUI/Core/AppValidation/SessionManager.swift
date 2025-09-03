import Foundation
import Combine
import SwiftUI

class SessionManager: ObservableObject {
    static let shared = SessionManager()
    
    private let usersLogOffUseCase: UsersLogOffUseCaseProtocol = UsersLogOffUseCase()
    private var inactivityTimer: Timer?
    private var warningTimer: Timer?
    private var countdownTimer: Timer?
    
    @Published var isSessionActive: Bool = true
    @Published var usersLogOffAPIResult: APIResultType<UsersLogOffUIModel>?
    @Published var isWarningVisible: Bool = false
    @Published var countdown: Int = 10 // Countdown value
    
    var sessionDelegate: SessionDelegate?
    
    func resetInactivityTimer(duration: TimeInterval = 300) {
        stopInactivityTimer()
        startWarningTimer(beforeLogout: duration - 10)
        inactivityTimer = Timer.scheduledTimer(withTimeInterval: duration, repeats: false) { [weak self] _ in
            self?.sessionTimedOut()
            debugPrint("Inactivity timer reset")
        }
    }
        
    func stopInactivityTimer() {
        inactivityTimer?.invalidate()
        inactivityTimer = nil
        warningTimer?.invalidate()
        warningTimer = nil
        countdownTimer?.invalidate()
        countdownTimer = nil
        isWarningVisible = false
        sessionDelegate?.onSessionWarning()
    }
    
    private func startWarningTimer(beforeLogout: TimeInterval) {
        warningTimer = Timer.scheduledTimer(withTimeInterval: beforeLogout, repeats: false) { [weak self] _ in
            self?.showLogoutWarning()
        }
    }
    
    private func showLogoutWarning() {
        isWarningVisible = true
        sessionDelegate?.onSessionWarning()
        countdown = 10
        startCountdown()
        debugPrint("Warning: You will be logged out in 10 seconds.")
    }
    
    private func startCountdown() {
        countdownTimer?.invalidate()
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.countdown > 0 {
                self.countdown -= 1
                sessionDelegate?.onSessionWarning()
            } else {
                self.countdownTimer?.invalidate()
                self.countdownTimer = nil
            }
        }
    }
    
    private func sessionTimedOut() {
        isSessionActive = false
        UsersLogOffAPI(success: true)
        print("Session timed out due to inactivity.")
    }
    
    func UsersLogOffAPI(success: Bool) {
        if UserDefaultController().isLoggedIn == false {
            return
        }
        
        let requestModel = UsersLogOffRequestModel()
        usersLogOffAPIResult = .onLoading(show: true)
        
        Task.init {
            await usersLogOffUseCase.UsersLogOff(requestModel: requestModel) {[weak self] result in
                self?.usersLogOffAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    self?.usersLogOffAPIResult = .onSuccess(response: success)
                    UserDefaultController().isLoggedIn = false
                    UserDefaultController().selectedUserAccount = nil
                    UserDefaultController().isUserInactive = true
                    UserDefaultController().isAutoLogin = false
                    debugPrint("Logoff success")

                    Task { @MainActor in
                        guard let window = SceneDelegate.getAppCoordinator()?.logout() else { return }
                        self?.isWarningVisible = false
                        self?.sessionDelegate?.onSessionWarning()
                    }
                case .failure(let failure):
                    self?.usersLogOffAPIResult = .onFailure(error: failure)
                    debugPrint("Logoff fail")
                    self?.isWarningVisible = false
                    self?.sessionDelegate?.onSessionWarning()
                }
            }
        }
    }
    
    func warningViewModifier<Content: View>(_ content: Content) -> some View {
        ZStack {
            content
            if isWarningVisible {
                VStack {
                    Text("You will be logged out in \(countdown) seconds.")
                        .padding()
                        .background(Color.yellow)
                        .cornerRadius(8)
                        .transition(.opacity)
                }
                .zIndex(1)
                .animation(.easeInOut, value: isWarningVisible)
            }
        }
    }
}


class TimerManager: ObservableObject {
    
    static let shared = TimerManager()
    private var timer: Timer?

    func startTimer() {
        stopTimer()
        
        let timeLimit = Double(UserDefaultController().sessiontimeoutPerSec ?? "") ?? 300 // minimum 5 minutes inactivity
//        let timeLimit:Double = 15
        
        timer = Timer.scheduledTimer(withTimeInterval: timeLimit, repeats: false) { [weak self] _ in
            self?.stopTimer()
            SessionManager.shared.UsersLogOffAPI(success: true)

        }
    }

    func resetTimer() {
//        debugPrint("Restarting timer")
        startTimer()
    }

    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}
