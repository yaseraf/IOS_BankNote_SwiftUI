//
//  AppDelegate.swift
//  QSC
//
//  Created by FIT on 22/07/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import SwiftUI
import UIKit
import IQKeyboardManagerSwift
import UserNotifications

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    static var shared: AppDelegate!
    @Inject private var userDefaultController: UserDefaultController?
    @Inject private var keyChainController: KeyChainController?
    var orientationLock = UIInterfaceOrientationMask.all

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        setup()
        registerForNotifications()
        userDefaultController?.clearTempData()
        keyChainController?.clearData()
        userDefaultController?.isAutoLogin = true
        application.registerForRemoteNotifications()
        
        UNUserNotificationCenter.current().delegate = self
        
        let memoryCapacity = 50 * 1024 * 1024 // 50 MB
        let diskCapacity = 100 * 1024 * 1024  // 100 MB
        let cache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: "webviewCache")
        URLCache.shared = cache

        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .returnCacheDataElseLoad

        return true
    }
    
    func registerForNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                print("Notification permission granted.")
            } else {
                print("Notification permission denied.")
            }
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
            print("Got notification title: ", response.notification.request.content.title)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        return [.badge, .banner, .list, .sound]
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let token = deviceToken.map { String(format: "%02.2hhx", $0)}.joined()
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let sceneConfig: UISceneConfiguration = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        sceneConfig.delegateClass = SceneDelegate.self
        return sceneConfig
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
//        print("Current orientation lock:", orientationLock)
        return self.orientationLock
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        userDefaultController?.clearTempData()
        keyChainController?.clearData()
    }

}
