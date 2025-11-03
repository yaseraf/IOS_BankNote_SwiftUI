//
//  AESHelper.swift
//  QSC
//
//  Created by FIT on 29/05/2025.
//  Copyright © 2025 FIT. All rights reserved.
//

import Foundation
import CryptoKit

struct AESHelper {
    static var key: SymmetricKey {
        return AESKeyManager.shared.symmetricKey
    }

    static func encrypt<T: Codable>(_ value: T) throws -> Data {
        let data = try JSONEncoder().encode(value)
        let sealedBox = try AES.GCM.seal(data, using: key)
        return sealedBox.combined!
    }

    static func decrypt<T: Codable>(_ data: Data) throws -> T {
        let sealedBox = try AES.GCM.SealedBox(combined: data)
        let decryptedData = try AES.GCM.open(sealedBox, using: key)
        return try JSONDecoder().decode(T.self, from: decryptedData)
    }
}

