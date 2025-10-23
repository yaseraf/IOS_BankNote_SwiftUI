//
//  AppUtility.swift
//  QSC
//
//  Created by FIT on 22/07/2024.
//  Copyright © 2024 FIT. All rights reserved.
//
import Foundation
import SwiftUI

class AppUtility {
    static  let shared: AppUtility = .init()
    @Inject private var userDefaultController: UserDefaultController?
    @Inject private var keyChainController: KeyChainController?
    
    
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
        AppDelegate.shared.orientationLock = orientation
    }

    static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation:UIInterfaceOrientation) {
        self.lockOrientation(orientation)

        UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
        UINavigationController.attemptRotationToDeviceOrientation()
    }
    
    var isUserSignIn: Bool{
        let isUserSignIn = !( KeyChainController.shared().signInToken?.isEmpty ?? true)
        return isUserSignIn
    }

//    func currentUserModel() -> UserUIModel{
//        return   keyChainController?.userUIModel ??  UserUIModel.temp()
//
//    }

   var isRTL: Bool {
        return userDefaultController?.isArabicLanguage ?? false
    } 

    var isDarkTheme: Bool {
        get {
            return switch AppUtility.shared.currentAppTheme {
                case .light:
                    false
                case .dark:
                    true
                case .system:
//                true
                UserDefaultController().isDarkMode ?? true
            }
        }
    }

    var currentAppTheme: ThemeType {
        return userDefaultController?.appTheme ?? .light
    }

    var languageLocal: Locale{
        return Locale(identifier: isRTL ? "ar_SA" : "en_US")
    }

    var englishLocal: Locale{
        return Locale(identifier: "en_US")
    }

    var arabicLocal: Locale{
        return Locale(identifier: "ar_SA")
    }
    
    var dividerHorizontalExtension: CGFloat {
        return -4
    }
    
    func updateAppLanguage(language: LanguageType) {
        //        OS
        let defaults = UserDefaults.standard
        defaults.set([language.rawValue], forKey: AppConstants.appleLanguages)
        userDefaultController?.appLanguage = language.rawValue //!!
        userDefaultController?.currentDeviceLanguage = language.rawValue
        //        appLanguage
        debugPrint ("language arabic ? \(AppUtility.shared.isRTL)")
        let semantic: UISemanticContentAttribute = AppUtility.shared.isRTL  ?  .forceRightToLeft : .forceLeftToRight
       
        UIView.appearance().semanticContentAttribute = semantic
        UIPageControl.appearance().semanticContentAttribute = semantic
        UIControl.appearance().semanticContentAttribute = semantic
        UINavigationBar.appearance().semanticContentAttribute = semantic
        UITextField.appearance().semanticContentAttribute = semantic
        UILabel.appearance().semanticContentAttribute = semantic
        UITextView.appearance().semanticContentAttribute = semantic
        UIImageView.appearance().semanticContentAttribute = semantic
        UINavigationController().view.semanticContentAttribute = semantic
        UITableView.appearance().semanticContentAttribute = semantic
        UINavigationController().navigationBar.semanticContentAttribute = semantic
        UITabBarController().view.semanticContentAttribute  = semantic
        UISwitch.appearance().semanticContentAttribute = semantic
        //            UITextField.appearance().setLabelTextAlignment(Alignment: .right)
        //            UITextView.appearance().setLabelTextAlignment(Alignment: .right)
        UISegmentedControl.appearance().semanticContentAttribute = semantic
        UIButton.appearance().semanticContentAttribute = semantic
        UIStackView.appearance().semanticContentAttribute = semantic
        
        

        
        
    }
    
    func loadCompanies() -> [GetCompaniesLookupsUIModel] {
        return UserData.shared.savedCompaniesEntity.map { GetCompaniesLookupsUIModel(entity: $0) }
    }


    func applyDeviceLanguageIfNeeded() {
        if let appLanguage = Locale.preferredLanguages.first {

            if userDefaultController?.currentDeviceLanguage !=  appLanguage{
                if appLanguage.contains(LanguageType.arabic.rawValue) {
                    userDefaultController?.currentDeviceLanguage = LanguageType.arabic.rawValue
                }else{
                    userDefaultController?.currentDeviceLanguage = LanguageType.english.rawValue
                }
            }

        }

        let currentDeviceLanguage = userDefaultController?.currentDeviceLanguage ?? LanguageType.english.rawValue
        let newLanguage = LanguageType(rawValue: currentDeviceLanguage) ?? LanguageType.english

        updateAppLanguage(language: newLanguage)
        
    }
    
    func formatThousandSeparator(number: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 3 // Remove decimal places
        formatter.locale = Locale(identifier: "en_US") // or "en_US_POSIX" for strict formatting

        // Format the double and add a thousand separator
        if let formattedString = formatter.string(from: NSNumber(value: number)) {
            return formattedString // Output: "1,234,568"
        } else {
            return "-"
        }
    }
    
    func formatThousandSeparatorNoDecimal(number: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0  // show decimals only if present
        formatter.maximumFractionDigits = 16 // optional: large enough to show all
        formatter.locale = Locale(identifier: "en_US") // or "en_US_POSIX" for strict formatting

        // Format the double and add a thousand separator
        if let formattedString = formatter.string(from: NSNumber(value: number)) {
            return formattedString // Output: "1,234,568"
        } else {
            return "-"
        }
    }
    
    func convertDateString(_ dateString: String, inputFormat: String, outputFormat: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = inputFormat
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")

        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = outputFormat
        outputFormatter.locale = Locale(identifier: "en_US_POSIX")

        if let date = inputFormatter.date(from: dateString) {
            return outputFormatter.string(from: date)
        } else {
            return dateString
        }
    }
    
    func convertStringToDate(_ input: String, with format: String) -> Date? {
        let formatter = DateFormatter()
            formatter.dateFormat = format
            formatter.locale = Locale(identifier: "en_US_POSIX")
            return formatter.date(from: input)
    }

    func animateScene() {
     //   israa
        let option: UIView.AnimationOptions =  AppUtility.shared.isRTL ? .transitionFlipFromRight : .transitionFlipFromLeft
        //        guard let window = Route.getWindow() else { return  }
        guard let window = SceneDelegate.getAppCoordinator()?.getWindow() else{return}
        UIView.transition(with: window, duration: 0.5, options: option, animations: {

            let oldState: Bool = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            window.makeKeyAndVisible()
            UIView.setAnimationsEnabled(oldState)
        }, completion: { (_: Bool) in
        })

    }

     func generateQRCode(from string: String) async -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)

        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)

            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }

        return nil
    }
}

extension AppUtility {
    public static var  bundleIdentifier: String {
        get{
            return Bundle.main.bundleIdentifier ?? "com.QSC.QSC"
        }
    }

    public static var  deviceUUID: String {
        get{
            return UIDevice.current.identifierForVendor?.uuidString ?? ""
        }
    }

    public static var  deviceModel: String {
        get{
            return [UIDevice.current.model, UIDevice.current.systemVersion].compactMap({$0}).joined(separator: ",")
        }
    }

    public static var  deviceName: String {
        get{
            return [UIDevice.current.model, UIDevice.current.systemVersion].compactMap({$0}).joined(separator: ",")
        }
    }

    public static var tabBarHeight: CGFloat {
        get {
            var height: CGFloat = 0
            if hasTopNotch {
                height = 34
            }
            return 59 + height
        }
    }
    public static var  hasTopNotch: Bool {
        get{
            return SceneDelegate.getAppCoordinator()?.getWindow().safeAreaInsets.top ?? 0 > 20
        }
    }

    public static var  bottomNotch: CGFloat {
        get{
            return SceneDelegate.getAppCoordinator()?.getWindow().safeAreaInsets.bottom ?? 0
        }
    }
    
    func getAddress(for network: Network) -> String? {
 
        var address: String?
        
        // Get list of all interfaces on the local machine:
        var ifaddr: UnsafeMutablePointer<ifaddrs>?
        guard getifaddrs(&ifaddr) == 0 else { return nil }
        guard let firstAddr = ifaddr else { return nil }
        
        // For each interface ...
        for ifptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
            let interface = ifptr.pointee
            
            // Check for IPv4 or IPv6 interface:
            let addrFamily = interface.ifa_addr.pointee.sa_family
            if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                
                // Check interface name:
                let name = String(cString: interface.ifa_name)
                if name == network.rawValue {
                    // Convert interface address to a human readable string:
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    getnameinfo(interface.ifa_addr, socklen_t(interface.ifa_addr.pointee.sa_len),
                                &hostname, socklen_t(hostname.count),
                                nil, socklen_t(0), NI_NUMERICHOST)
                    address = String(cString: hostname)
                }
            }
        }
        freeifaddrs(ifaddr)
        
        return address
    }
}
