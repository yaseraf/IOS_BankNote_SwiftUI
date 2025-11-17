//
//  LivenessCheckViewModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 16/09/2025.
//

import Foundation
import VIDVLiveness
//import VIDVAuth
import UIKit
import Combine
import SwiftUI

extension UIViewController {
    /// Finds the top-most visible UIViewController
    static func topMostViewController(base: UIViewController? = nil) -> UIViewController? {
        let base = base ?? UIApplication.shared.connectedScenes
            .compactMap { ($0 as? UIWindowScene)?.keyWindow }
            .first?.rootViewController
        
        if let hosting = base as? UIHostingController<AnyView> {
            return hosting
        }
        
        if let nav = base as? UINavigationController {
//            return topMostViewController(base: nav.visibleViewController)
            return nav.visibleViewController
        }
        
        if let tab = base as? UITabBarController {
            return topMostViewController(base: tab.selectedViewController)
        }
        
        if let presented = base?.presentedViewController {
            return topMostViewController(base: presented)
        }
        
        return nil
    }
}



//class sdkIntegration: UIViewController, ObservableObject, VIDVLivenessDelegate, VIDVAuthDelegate{
class sdkIntegration: UIViewController, ObservableObject, VIDVLivenessDelegate {
    
    // Ensure it conforms to ObservableObject
    @Published var ocrResultMessage: String = "" // Publish OCR result message
    @Published var livenessResultMessage: String = "" // Publish Liveness result message

    
    // SDK Builder instance
    private var vidvLivenessBuilder =  VIDVLivenessBuilder()
//    private var vidvAuthBuilder = VIDVAuthBuilder()

    // Store credentials( The credentials are out in app interface for testing purposes it's recommended to put in your app backend for better security)
    private let username = "fitmena__49191_integration_bundle"
    private let password = "51US2Myzx1LTJa9a"
    private let clientId = "tiqGRE2zLDqhUEYx31JGwRCDREiURauVTPXHhBbT"
    private let clientSecret = "MTdrVkVSzjgw8LQHGUlG6dz6L7AJpZF4Y9FWJl1fj7hbUaP9V8aDmmHjD6LXTAgChxZ2J7cKCq3iJXGOJNu1lRg8wTfIyogDtyuyvmQGBmrz4q208s7z2i8XSQyAcAa3"
    private let bundleKey = "fd1ee6cfb93643669377c57112187fe1"
    private let baseURL = "https://www.valifystage.com"
    
    @Published var accessToken: String = "" // Publish access token to UI
    @Published var errorMessage: String = "" // Publish error message to UI
    
    // Generate access token from API to connect to the SDK
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
    
    //start liveness process
    func startLiveness(transactionFrontId : String){
        generateAccessToken { [weak self] token, error in
            guard let self = self else { return }
            
            if let vc = UIViewController.topMostViewController() {
                print("Top VC: \(vc)")
                print("Has window: \(vc.view.window != nil)")
            }

            
            if let token = token {
                self.accessToken = token // Update published access token
                self.errorMessage = "" // Clear any previous error message
                
                self.vidvLivenessBuilder = self.vidvLivenessBuilder
                    .setBundleKey(self.bundleKey)
                    .setBaseURL(self.baseURL)
                    .setAccessToken(accessToken)
                    .setHeaders(["X-Valify-reference-userid":KeyChainController().valifyRequestId ?? ""]) // !!
                    .setCollectUserInfo(true) // !!
                    .setNumberOfInstructions(3) // !!
                    .withoutSmile()
                    .withoutCloseEyes()
                    .withoutVoiceOver()
                
                // Face Match
                
//                    .setFrontTransactionID(transactionFrontId)
//                if let rootVC = UIApplication.shared.windows.first?.rootViewController {
                if let rootVC = UIViewController.topMostViewController() {
                        self.vidvLivenessBuilder.start(vc: rootVC, livenessDelegate:self)
                        print("Liveness started") // Log to confirm the method was called
                    } else {
                        print("Error: No root view controller found.")
                    }
            } else if let error = error {
                self.accessToken = "" // Clear access token on error
                self.errorMessage = error.localizedDescription // Update error message
                print("Failed to generate access token: \(error.localizedDescription)")
            }
        }
    }
    
//    func startAuth() {
//        // Registration Flow
//        self.vidvAuthBuilder = self.vidvAuthBuilder
//            .setBaseURL(self.baseURL)
//            .setBundleKey(self.bundleKey)
////            .setSessionID(<#T##sessionID: String##String#>)
////            .setOtpSessionId("OTP session ID")
//            .setFlow(.registration)
//
//        
//        self.vidvAuthBuilder.start(with: self, and: self)
//
//    }
//    
//    func startLogin() {
//        // Login Flow
//        self.vidvAuthBuilder = self.vidvAuthBuilder
//            .setBaseURL(self.baseURL)
//            .setBundleKey(self.bundleKey)
//        //            .setSessionID(<#T##sessionID: String##String#>)
////            .setOtpSessionId("OTP session ID")
//            .setFlow(.login(phoneNumber: "+1234567890"))
//    }
        
    //Handling Liveness results
    func onLivenessResult(_ result: VIDVLiveness.VIDVLivenessResponse) {
        switch result {
        case .success(let data):
            //This is excecuted when the ocr is completed successfully
            // data of type VIDVOCRResult
            livenessResultMessage = "Liveness Success!"
            debugPrint("VidVLiveness success, data: \(data)")
            SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getAuthCoordinator(startViewType: .register).openLoginInformationScene()
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
    }
    
//    func didFinisAuthSDK(with response: VIDVAuth.VIDVAuthResponse) {
//        switch response {
//        case .success(let data):
//            // Handle success
//            debugPrint("Success! Session ID: \(data.sessionID)")
//            startLogin()
//        case .serviceFailure(let code, let message, let data):
//            // Handle service failure
//            debugPrint("Service Failure: [\(code)] \(message) – Data: \(String(describing: data))")
//        case .exit(let step, let data):
//            // Handle user exit
//            debugPrint("User exited at step \(step). Data: \(String(describing: data))")
//            
//        case .builderError(code: let code, message: let message):
//            // Handle builder error
//            debugPrint("Builder error, code: \(code), message: \(message)")
//        }
//    }

}
