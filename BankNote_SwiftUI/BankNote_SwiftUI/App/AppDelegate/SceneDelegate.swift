//
//  SceneDelegate.swift
//  QSC
//
//  Created by FIT on 22/07/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation
import UIKit

class UserInteractionWindow: UIWindow {
    var onUserInteraction: (() -> Void)?

    override func sendEvent(_ event: UIEvent) {
        super.sendEvent(event)

        if event.allTouches?.contains(where: { $0.phase == .began }) == true {
            onUserInteraction?()
        }
    }
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UserInteractionWindow?
    private static var appCoordinator: AppCoordinator?
    public static func getAppCoordinator() -> AppCoordinator? {
        return appCoordinator
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UserInteractionWindow(frame: windowScene.screen.bounds)
        window?.windowScene = windowScene
        window?.makeKeyAndVisible()
        window?.onUserInteraction = {
            TimerManager.shared.resetTimer()
        }

        SceneDelegate.appCoordinator = AppCoordinator(window: window!)
        SceneDelegate.appCoordinator?.start()
    }

    func sceneDidDisconnect(_ scene: UIScene) {

    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        if !Connection_Hub.shared.isConnected() {
            Connection_Hub.shared.connection?.start()
        }

    }

    func sceneWillResignActive(_ scene: UIScene) {

    }

    func sceneWillEnterForeground(_ scene: UIScene) {

    }

    func sceneDidEnterBackground(_ scene: UIScene) {

    }
}
