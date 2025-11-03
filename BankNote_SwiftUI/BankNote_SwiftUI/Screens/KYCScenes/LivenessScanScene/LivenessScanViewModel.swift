//
//  LivenessScanViewModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 16/09/2025.
//

import Foundation
//import VIDVLiveness
import UIKit

//class LivenessScanViewModel: ObservableObject, VIDVLivenessDelegate {
class LivenessScanViewModel: ObservableObject {
        
    private let coordinator: AuthCoordinatorProtocol
    
//    var vidvLivenessBuilder = VIDVLivenessBuilder()
    
    private let bundleKey = "fd1ee6cfb93643669377c57112187fe1"
    private let baseUrl = "https://www.valifystage.com/api/"
    private let accessToken = "344553443"

    
    init(coordinator: AuthCoordinatorProtocol) {
        self.coordinator = coordinator
        
//        vidvLivensssInit()
    }
}

// MARK: Routing
extension LivenessScanViewModel {
    func openQuestioneerScene() {
        coordinator.openQuestioneerScene()
    }
}

extension LivenessScanViewModel {
    func vidvLivensssInit() {
//        vidvLivenessBuilder = vidvLivenessBuilder
//            .setBundleKey(bundleKey)
//            .setBaseURL(baseUrl)
//            .setAccessToken(accessToken)
//
//        startLiveness(from: SceneDelegate.getAppCoordinator()?.topViewController() ?? UIViewController())
    }
    
    func startLiveness(from viewController: UIViewController) {
//        vidvLivenessBuilder.start(vc: viewController, livenessDelegate: self)
    }
}

// MARK: Delegates
extension LivenessScanViewModel {
//    func onLivenessResult(_ VIDVLivenessResponse: VIDVLiveness.VIDVLivenessResponse) {
//        switch VIDVLivenessResponse {
//        case .success(let data):
//            // data of type VIDVLivenessResult
//            debugPrint("VidVLiveness success")
//            debugPrint(data)
//        case .builderError(let code, let message):
//            // builder error code & error message
//            debugPrint("VidVLiveness builderError")
//            debugPrint(code)
//        case .serviceFailure(let data, let code, let message):
//            // service faluire error code & error message & data of type VIDVLivenessResult
//            debugPrint("VidVLiveness serviceFailure")
//            debugPrint(data as Any)
//        case .userExited(let data, let step):
//            // last step in the SDK & data of type VIDVLivenessResult
//            debugPrint("VidVLiveness userExit")
//            debugPrint(data as Any)
//        case .capturedActions(capturedActions: let capturedActions):
//            // capturedActions of type capturedActions
//            debugPrint("VidVLiveness capturedImages")
//            debugPrint(capturedActions)
//        @unknown default:
//            debugPrint("VidVLiveness unknown")
//        }
//    }
}
