//
//  AESKeyManager.swift
//  QSC
//
//  Created by FIT on 29/05/2025.
//  Copyright © 2025 FIT. All rights reserved.
//

import Foundation
import CryptoKit

class AESKeyManager {
    static let shared = AESKeyManager()
    private let keychainKey = "com.cibc.mahfazty.aeskey"

    var symmetricKey: SymmetricKey {
        if let savedKeyData = loadKeyFromKeychain() {
            return SymmetricKey(data: savedKeyData)
        } else {
            let key = SymmetricKey(size: .bits256)
            saveKeyToKeychain(key)
            return key
        }
    }

    private func loadKeyFromKeychain() -> Data? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: keychainKey,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)

        guard status == errSecSuccess else {
            return nil
        }

        return result as? Data
    }

    private func saveKeyToKeychain(_ key: SymmetricKey) {
        let keyData = key.withUnsafeBytes { Data($0) }

        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: keychainKey,
            kSecValueData as String: keyData
        ]

        SecItemDelete(query as CFDictionary) // Avoid duplicates
        SecItemAdd(query as CFDictionary, nil)
    }
}
