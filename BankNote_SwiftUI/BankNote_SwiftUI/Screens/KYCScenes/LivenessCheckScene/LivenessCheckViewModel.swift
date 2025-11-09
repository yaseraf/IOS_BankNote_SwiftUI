//
//  LivenessCheckViewModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 16/09/2025.
//

import Foundation
import VIDVLiveness
import UIKit
import SwiftUI



class LivenessCheckViewModel: ObservableObject, VIDVLivenessDelegate {
        
    private let coordinator: AuthCoordinatorProtocol
    
    var vidvLivenessBuilder = VIDVLivenessBuilder()
    
    private let username = "fitmena__49191_integration_bundle"
    private let password = "51US2Myzx1LTJa9a"
    private let clientId = "tiqGRE2zLDqhUEYx31JGwRCDREiURauVTPXHhBbT"
    private let clientSecret = "MTdrVkVSzjgw8LQHGUlG6dz6L7AJpZF4Y9FWJl1fj7hbUaP9V8aDmmHjD6LXTAgChxZ2J7cKCq3iJXGOJNu1lRg8wTfIyogDtyuyvmQGBmrz4q208s7z2i8XSQyAcAa3"
    private let bundleKey = "fd1ee6cfb93643669377c57112187fe1"
    private let baseURL = "https://www.valifystage.com"
    @Published var accessToken: String = "" // Publish access token to UI
    @Published var errorMessage: String = "" // Publish error message to UI

    @Published var startLivenessAPIResult:APIResultType<VerifyLivenessUIModel>?

    init(coordinator: AuthCoordinatorProtocol) {
        self.coordinator = coordinator
        
//        vidvLivensssInit()
    }
    
}

// MARK: Routing
extension LivenessCheckViewModel {
    func openQuestioneerScene() {
        coordinator.openQuestioneerScene()
    }
}

// MARK: Functions
extension LivenessCheckViewModel {
}

// MARK: Delegates
extension LivenessCheckViewModel {
    func onLivenessResult(_ VIDVLivenessResponse: VIDVLiveness.VIDVLivenessResponse) {
        switch VIDVLivenessResponse {
        case .success(let data):
            // data of type VIDVLivenessResult
            debugPrint("VidVLiveness success, data: \(data)")
        case .builderError(let code, let message):
            // builder error code & error message
            debugPrint("VidVLiveness builderError, code: \(code), message: \(message)")
        case .serviceFailure(let data, let code, let message):
            // service faluire error code & error message & data of type VIDVLivenessResult
            debugPrint("VidVLiveness serviceFailure, data: \(data), code: \(code), message: \(message)")
        case .userExited(let data, let step):
            // last step in the SDK & data of type VIDVLivenessResult
            debugPrint("VidVLiveness userExit, data: \(data), step: \(step)")
        case .capturedActions(capturedActions: let capturedActions):
            // capturedActions of type capturedActions
            debugPrint("VidVLiveness capturedImages, actions: \(capturedActions)")
        @unknown default:
            debugPrint("VidVLiveness unknown")
        }
    }
}
