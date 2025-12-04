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

class LivenessCheckViewModel: NSObject, ObservableObject, VIDVLivenessDelegate {
        
    private let coordinator: AuthCoordinatorProtocol
    private let valifyUseCase: ValifyUseCaseProtocol

    @Published var getValifyDataAPIResult:APIResultType<GetValifyDataUIModel>?

    var vidvLivenessBuilder = VIDVLivenessBuilder()
    @Published var livenessResultMessage: String = "" // Publish Liveness result message

    private let username = "fitmena__49191_integration_bundle"
    private let password = "51US2Myzx1LTJa9a"
    private let clientId = "tiqGRE2zLDqhUEYx31JGwRCDREiURauVTPXHhBbT"
    private let clientSecret = "MTdrVkVSzjgw8LQHGUlG6dz6L7AJpZF4Y9FWJl1fj7hbUaP9V8aDmmHjD6LXTAgChxZ2J7cKCq3iJXGOJNu1lRg8wTfIyogDtyuyvmQGBmrz4q208s7z2i8XSQyAcAa3"
    private let bundleKey = "fd1ee6cfb93643669377c57112187fe1"
    private let baseURL = "https://www.valifystage.com"
    @Published var accessToken: String = "" // Publish access token to UI
    @Published var errorMessage: String = "" // Publish error message to UI

    @Published var startLivenessAPIResult:APIResultType<VerifyLivenessUIModel>?

    init(coordinator: AuthCoordinatorProtocol, valifyUseCase: ValifyUseCaseProtocol) {
        self.coordinator = coordinator
        self.valifyUseCase = valifyUseCase
        
//        vidvLivensssInit()
    }
    
}

// MARK: Routing
extension LivenessCheckViewModel {
    func openQuestioneerScene() {
        coordinator.openQuestioneerScene()
    }
    
    func getValifyData() {
        
        let requestModel = GetValifyDataRequestModel(reqID: KeyChainController().valifyRequestId ?? "")
                
        getValifyDataAPIResult = .onLoading(show: true)
        
        Task.init {
            await valifyUseCase.GetValifyData(requestModel: requestModel) {[weak self] result in
                self?.getValifyDataAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):

                    KeyChainController().valifyTransactionId = success.resData?.transactionId
                    debugPrint("get valify success")
                    
                case .failure(let failure):
                    self?.getValifyDataAPIResult = .onFailure(error: failure)
                    debugPrint("get valify failed: \(failure)")
                }
            }
        }
    }

}

// MARK: Functions
extension LivenessCheckViewModel {
    
}

// MARK: Delegates
extension LivenessCheckViewModel {
    func onLivenessResult(_ result: VIDVLiveness.VIDVLivenessResponse) {
        switch result {
        case .success(let data):
            //This is excecuted when the ocr is completed successfully
            // data of type VIDVOCRResult
            livenessResultMessage = "Liveness Success!"
            debugPrint("VidVLiveness success, data: \(data)")
            coordinator.openLoginInformationScene()
//            startAuth()

        case .builderError(let code, let message):
            // builder error code & error message
            livenessResultMessage = "Liveness Error! Code: \(code), Message: \(message)"
            debugPrint("VidVLiveness builderError, code: \(code), message: \(message)")

        case .serviceFailure(let code, let message, let data):
            // service faluire error code & error message & data of type VIDVOCRResult
            livenessResultMessage = "Service Error! Code: \(code), Message: \(message)"
            debugPrint("VidVLiveness serviceFailure, data: \(data), code: \(code), message: \(message)")

        case .userExited(let data, let step):
            // last step in the SDK & data of type VIDVOCRResult
            livenessResultMessage = "User exited at step \(step)"
            debugPrint("VidVLiveness userExit, data: \(data), step: \(step)")

        case .capturedActions(let capturedActions):
            // capturedImageData of type CapturedImageData
            livenessResultMessage = "Liveness Image Captured"
            debugPrint("VidVLiveness capturedImages, actions: \(capturedActions)")

        }
    }}

