//
//  KeyChainController.swift
//  QSC
//
//  Created by FIT on 22/07/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation

class KeyChainController {
    private static var  instance: KeyChainController?
    public static func shared() -> KeyChainController {
        if instance == nil{
        instance = KeyChainController()
        }
        return instance!
    }
    enum CachingKey: String {
        case signInToken
        case accessToken
        case verifyPhoneOtpAccessToken
        case refreshToken
        case userUIModel
        case listOfUsers
        case savedUserPhoneNo
        case savedUserEmail
        case savedUserPassword
        case phoneNumberOtpRequestId
        case emailOtpRequestId
        case verifyPhoneOtpRequestId
        case transactionId
        case stepCreateAccessToken
        case loginVlensAccessToken
        case userPin
        case username
        case resetPasswordCookies
        case phoneNumberEntered
        case Password
        case email
        case mobileNo
        case webCode
        case brokerID
        case UCODE
        case compInit
        case userType
        case mainClientID
        case clientID
        case accountID
        case compId
        case loginCookieName
        case loginCookieValue
        case authToken
     }

    @CachingKeyChainCodable<String>(.refreshToken) var refreshToken
    @CachingKeyChainCodable<String>(.signInToken) var signInToken
    @CachingKeyChainCodable<String>(.accessToken) var accessToken
    @CachingKeyChainCodable<String>(.verifyPhoneOtpAccessToken) var verifyPhoneOtpAccessToken
    @CachingKeyChainCodable<String>(.savedUserPhoneNo) var savedUserPhoneNo
    @CachingKeyChainCodable<String>(.savedUserEmail) var savedUserEmail
    @CachingKeyChainCodable<String>(.savedUserPassword) var savedUserPassword
    @CachingKeyChainCodable<String>(.phoneNumberOtpRequestId) var phoneNumberOtpRequestId
    @CachingKeyChainCodable<String>(.emailOtpRequestId) var emailOtpRequestId
    @CachingKeyChainCodable<String>(.verifyPhoneOtpRequestId) var verifyPhoneOtpRequestId
    @CachingKeyChainCodable<String>(.transactionId) var transactionId
    @CachingKeyChainCodable<String>(.stepCreateAccessToken) var stepCreateAccessToken
    @CachingKeyChainCodable<String>(.loginVlensAccessToken) var loginVlensAccessToken
    @CachingKeyChainCodable<String>(.userPin) var userPin
    @CachingKeyChainCodable<String>(.username) var username
    @CachingKeyChainCodable<String>(.resetPasswordCookies) var resetPasswordCookies
    @CachingKeyChainCodable<String>(.phoneNumberEntered) var phoneNumberEntered
    @CachingKeyChainCodable<String>(.Password) var password
    @CachingKeyChainCodable<String>(.email) var email
    @CachingKeyChainCodable<String>(.mobileNo) var mobileNo
    @CachingKeyChainCodable<String>(.webCode) var webCode
    @CachingKeyChainCodable<String>(.brokerID) var brokerID
    @CachingKeyChainCodable<String>(.UCODE) var UCODE
    @CachingKeyChainCodable<String>(.compInit) var compInit
    @CachingKeyChainCodable<String>(.userType) var userType
    @CachingKeyChainCodable<String>(.mainClientID) var mainClientID
    @CachingKeyChainCodable<String>(.clientID) var clientID
    @CachingKeyChainCodable<String>(.accountID) var accountID
    @CachingKeyChainCodable<String>(.compId) var compId
    @CachingKeyChainCodable<String>(.loginCookieName) var loginCookieName
    @CachingKeyChainCodable<String>(.loginCookieValue) var loginCookieValue
    @CachingKeyChainCodable<String>(.authToken) var authToken

    func clearData() {
        refreshToken = nil
        accessToken = nil
        verifyPhoneOtpAccessToken = nil
        signInToken = nil 
        loginVlensAccessToken = nil
        userPin = nil
        resetPasswordCookies = nil
        loginCookieName = nil
        loginCookieValue = nil
        authToken = nil
        
    }
}

@propertyWrapper
struct CachingKeyChainCodable<T: Codable> {
    let key: KeyChainController.CachingKey
    
    init(_ key: KeyChainController.CachingKey) {
        self.key = key
    }

    var wrappedValue: T? {
        get {
            let query = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrAccount as String: key.rawValue,
                kSecReturnData as String: kCFBooleanTrue!,
                kSecMatchLimit as String: kSecMatchLimitOne
            ] as [String: Any]

            var dataTypeRef: AnyObject? = nil

            if SecItemCopyMatching(query as CFDictionary, &dataTypeRef) == noErr,
               let encryptedData = dataTypeRef as? Data {
                do {
                    return try AESHelper.decrypt(encryptedData)
                } catch {
                    print("Decryption failed for \(key.rawValue): \(error)")
                    return nil
                }
            }

            return nil
        }

        set {
            guard let value = newValue else {
                let query = [
                    kSecClass as String: kSecClassGenericPassword,
                    kSecAttrAccount as String: key.rawValue
                ] as [String: Any]
                SecItemDelete(query as CFDictionary)
                return
            }

            do {
                let encryptedData = try AESHelper.encrypt(value)
                let query = [
                    kSecClass as String: kSecClassGenericPassword,
                    kSecAttrAccount as String: key.rawValue,
                    kSecValueData as String: encryptedData
                ] as [String: Any]

                SecItemDelete(query as CFDictionary)
                SecItemAdd(query as CFDictionary, nil)
            } catch {
                print("Encryption failed for \(key.rawValue): \(error)")
            }
        }
    }
}

func debugPrintKeychainValue<T: Codable>(for key: KeyChainController.CachingKey, as type: T.Type) {
    let query = [
        kSecClass as String: kSecClassGenericPassword,
        kSecAttrAccount as String: key.rawValue,
        kSecReturnData as String: kCFBooleanTrue!,
        kSecMatchLimit as String: kSecMatchLimitOne
    ] as [String: Any]

    var dataTypeRef: AnyObject? = nil
    let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

    guard status == errSecSuccess, let encryptedData = dataTypeRef as? Data else {
        print("❌ No data found for key: \(key.rawValue)")
        return
    }

    print("🔐 Raw AES-encrypted value (base64):", encryptedData.base64EncodedString())

    do {
        let decryptedValue = try AESHelper.decrypt(encryptedData) as T
        print("✅ Decrypted value:", decryptedValue)
    } catch {
        print("❌ Failed to decrypt value for key: \(key.rawValue). Error: \(error)")
    }
}


//@propertyWrapper struct CachingKeyChainCodable<T: Codable> {
//    let key: KeyChainController.CachingKey
//    init(_ key: KeyChainController.CachingKey) {
//        self.key = key
//    }
//
//    var wrappedValue: T?{
//        get{
//            let query = [
//                kSecClass as String: kSecClassGenericPassword,
//                kSecAttrAccount as String: key.rawValue,
//                kSecReturnData as String: kCFBooleanTrue!,
//                kSecMatchLimit as String: kSecMatchLimitOne,
//                
//            ] as [String: Any]
//            
//            var dataTypeRef: AnyObject? = nil
//
//            if  SecItemCopyMatching(query as CFDictionary, &dataTypeRef)  == noErr {
//                guard let data =   dataTypeRef as? Data else{return nil}
//                guard  let value = try? JSONDecoder().decode(T.self, from: data) else{
////                    print("keychain get \(key.rawValue)  is nil")
//
//                    return nil
//                }
//               return value
//
//            } else {
//
//                return nil
//            }
//
//        }
//        set{
//
//                let encoder = JSONEncoder()
//                guard let data = try? encoder.encode(newValue) else{
////                    print("keychain set failed to convert \(key.rawValue) to data")
//
//                    return}
//                // Set attributes
//                let query = [
//                    kSecClass as String: kSecClassGenericPassword,
//                    kSecAttrAccount as String: key.rawValue,
//                    kSecValueData as String: data,
////                    kSecAttrAccessible as String: kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly
//                
//                ] as [String: Any]
//
//                SecItemDelete(query as CFDictionary)
//
////                let status = SecItemAdd(query as CFDictionary, nil)
//
//                // Add data
//                if SecItemAdd(query as CFDictionary, nil) == noErr {
////                    print("keychain set \(key.rawValue)  saved successfully")
//
//                } else {
////                    print("keychain set \(key.rawValue)  Something went wrong trying to save")
//                }
//
//        }
//
//    }
//
//}


