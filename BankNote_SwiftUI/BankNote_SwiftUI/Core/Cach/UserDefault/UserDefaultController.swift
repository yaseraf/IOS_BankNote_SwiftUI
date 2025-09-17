//
//  UserDefaultController.swift
//  QSC
//
//  Created by FIT on 22/07/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation
import UIKit
import Combine

enum CachingKey: String {

    // MARK: Bools
    
    case isLoggedIn
    case isDarkMode
    case isArabicLanguage
    case isUserInactive
    case isAutoLogin
    case isFirstLogin
    case isHeadHorizontalMovement
    case canRestartScreen
    case hasCheckedInactivity
    case priceAlertOption
    case signalRConnected
    case isBiometricEnabled
    
    // MARK: Strings
    
    case appLanguage
    case currentDeviceLanguage
    case sessiontimeoutPerSec
    case username
    case lastColorScheme
    case marketStatusCode
    case nameFullNameE
    case nameFullNameA
    case profileID
    case marketStatusTitle
    case selectedSymbol
    case selectedSymbolType
    case iconPath
    case BackgroundWatchList
    case currentDate
    case yesterdayDate
    
    // MARK: Other
    
    case appTheme
    case selectedUserAccount

}

class UserDefaultController: ObservableObject {
    static var instance: UserDefaultController = UserDefaultController()
    
    // MARK: Bools
    
    @CachingCodable<Bool>(.isDarkMode) var isDarkMode
    @CachingCodable<Bool>(.isLoggedIn) var isLoggedIn
    @CachingCodable<Bool>(.isUserInactive) var isUserInactive
    @CachingCodable<Bool>(.isAutoLogin) var isAutoLogin
    @CachingCodable<Bool>(.canRestartScreen) var canRestartScreen
    @CachingCodable<Bool>(.hasCheckedInactivity) var hasCheckedInactivity
    @CachingCodable<Bool>(.isFirstLogin) var isFirstLogin
    @CachingCodable<Bool>(.isHeadHorizontalMovement) var isHeadHorizontalMovement
    @CachingCodable<Bool>(.priceAlertOption) var priceAlertOption
    @CachingCodable<Bool>(.signalRConnected) var signalRConnected
    @CachingCodable<Bool>(.isBiometricEnabled) var isBiometricEnabled

    // MARK: Strings

    @CachingCodable<String>(.appLanguage) var appLanguage
    @CachingCodable<String>(.currentDeviceLanguage) var currentDeviceLanguage
    @CachingCodable<String>(.username) var username
    @CachingCodable<String>(.lastColorScheme) var lastColorScheme
    @CachingCodable<String>(.marketStatusCode) var marketStatusCode
    @CachingCodable<String>(.nameFullNameA) var nameFullNameA
    @CachingCodable<String>(.nameFullNameE) var nameFullNameE
    @CachingCodable<String>(.profileID) var profileID
    @CachingCodable<String>(.marketStatusTitle) var marketStatusTitle
    @CachingCodable<String>(.selectedSymbol) var selectedSymbol
    @CachingCodable<String>(.selectedSymbolType) var selectedSymbolType
    @CachingCodable<String>(.iconPath) var iconPath
    @CachingCodable<String>(.BackgroundWatchList) var BackgroundWatchList
    @CachingCodable<String>(.sessiontimeoutPerSec) var sessiontimeoutPerSec
    @CachingCodable<String>(.currentDate) var currentDate
    @CachingCodable<String>(.yesterdayDate) var yesterdayDate

    // MARK: Others

    @CachingCodable<GetUserAccountsUIModel>(.selectedUserAccount) var selectedUserAccount
    @CachingCodable<ThemeType>(.appTheme) var appTheme
        
    var isArabicLanguage: Bool {
        get {
            return appLanguage == LanguageType.arabic.rawValue
        }
    }
    
    func clearTempData(){
        profileID = nil
        signalRConnected = nil
        marketStatusTitle = nil
        selectedSymbol = nil
        selectedSymbolType = nil
    }
}


@propertyWrapper struct CachingCodable<T: Codable> {
    let key: CachingKey
    let storege: UserDefaults
    init(_ key: CachingKey, storege: UserDefaults = .userDefaultApp) {
        self.key = key
        self.storege = storege
    }
    
    var wrappedValue: T? {
        get{
            do {
                if let data = storege.value(forKey: key.rawValue) as? Data{
                    let value = try JSONDecoder().decode(T.self, from: data)
                    return value
                }
            }catch{
//                debugPrint( "UserDefaultController get value error:\(error)")
                
            }
            return nil
        }
        set{
            do {
                
                let encoder = JSONEncoder()
                let data = try encoder.encode(newValue)
                storege.set(data, forKey: key.rawValue)
            }
            catch{
                debugPrint( "UserDefaultController set value error:\(error)")
            }
        }
    }
}

extension UserDefaults {
    static var userDefaultApp: UserDefaults {
        let userDefault = UserDefaults.standard
        userDefault.addSuite(named: AppUtility.bundleIdentifier)
        return userDefault
    }
}
