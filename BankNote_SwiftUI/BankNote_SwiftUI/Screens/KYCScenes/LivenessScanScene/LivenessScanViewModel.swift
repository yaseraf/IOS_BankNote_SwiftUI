//
//  LivenessScanViewModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 16/09/2025.
//

import Foundation
import VIDVLiveness
import UIKit

class LivenessScanViewModel: ObservableObject, VIDVLivenessDelegate {
        
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

    
    init(coordinator: AuthCoordinatorProtocol) {
        self.coordinator = coordinator
        
        vidvLivensssInit()
    }
}

// MARK: Routing
extension LivenessScanViewModel {
    func openQuestioneerScene() {
        coordinator.openQuestioneerScene()
    }
}

// MARK: Functions
extension LivenessScanViewModel {
    func generateAccessToken(completion: @escaping (String?, Error?) -> Void) {
        let urlString = "\(baseURL)/api/o/token/"
        guard let url = URL(string: urlString) else {
            completion(nil, NSError(domain: "Invalid URL", code: -1, userInfo: nil))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        // Form URL-encoded request body
        let bodyComponents = [
            "username": username,
            "password": password,
            "client_id": clientId,
            "client_secret": clientSecret,
            "grant_type": "password"
        ]
            .map { "\($0)=\($1)" }
            .joined(separator: "&")
        
        request.httpBody = bodyComponents.data(using: .utf8)
        
        // Execute network request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(nil, error)
                    return
                }
                
                guard let data = data else {
                    completion(nil, NSError(domain: "No data", code: -1, userInfo: nil))
                    return
                }
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                       let token = json["access_token"] as? String {
                        completion(token, nil)
                    } else {
                        completion(nil, NSError(domain: "Token Error", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid token response"]))
                    }
                } catch {
                    completion(nil, error)
                }
            }
        }
        task.resume()
    }

    func vidvLivensssInit() {
        vidvLivenessBuilder = vidvLivenessBuilder
            .setBundleKey(bundleKey)
            .setBaseURL(baseURL)
            .setAccessToken(accessToken)

        startLiveness(from: SceneDelegate.getAppCoordinator()?.topViewController() ?? UIViewController())
    }
    
    func startLiveness(from viewController: UIViewController) {
        vidvLivenessBuilder.start(vc: viewController, livenessDelegate: self)
    }
}

// MARK: Delegates
extension LivenessScanViewModel {
    func onLivenessResult(_ VIDVLivenessResponse: VIDVLiveness.VIDVLivenessResponse) {
        switch VIDVLivenessResponse {
        case .success(let data):
            // data of type VIDVLivenessResult
            debugPrint("VidVLiveness success")
            debugPrint(data)
        case .builderError(let code, let message):
            // builder error code & error message
            debugPrint("VidVLiveness builderError")
            debugPrint(code)
        case .serviceFailure(let data, let code, let message):
            // service faluire error code & error message & data of type VIDVLivenessResult
            debugPrint("VidVLiveness serviceFailure")
            debugPrint(data as Any)
        case .userExited(let data, let step):
            // last step in the SDK & data of type VIDVLivenessResult
            debugPrint("VidVLiveness userExit")
            debugPrint(data as Any)
        case .capturedActions(capturedActions: let capturedActions):
            // capturedActions of type capturedActions
            debugPrint("VidVLiveness capturedImages")
            debugPrint(capturedActions)
        @unknown default:
            debugPrint("VidVLiveness unknown")
        }
    }
}
