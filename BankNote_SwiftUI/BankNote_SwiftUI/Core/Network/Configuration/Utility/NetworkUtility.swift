//
//  NetworkUtility.swift
//  QSC
//
//  Created by FIT on 27/07/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation
struct NetworkUtility{
    enum HeaderType{
        case token
        case refreshToken
        case withoutToken
    }

    static func getHeader(_ type:HeaderType) ->  [String : String]{

        let keyChainController = KeyChainController.shared()
        var headerDic = [String : String]()
        headerDic["Accepts"] = "*/*"
        headerDic["Content-Type"] = "application/json"

        var appLanguage = "en_UK"
        if UserDefaultController.instance.isArabicLanguage{
            appLanguage = "ar_SA"
        }

        var local = "en"
        if UserDefaultController.instance.isArabicLanguage{
            local = "ar"
        }

        headerDic["Accept-Language"] = "\(appLanguage)"
        headerDic["locale"] = "\(local)"
        if type != .withoutToken{
            let token = keyChainController.signInToken ?? ""
            if !token.isEmpty{
                headerDic["Authorization"] = "Bearer \(token)"
            }
        }
        return headerDic
    }

//


    

    func hexDecodedData(string:String) -> Data {
        // Get the UTF8 characters of this string
        let chars = Array(string.utf8)

        // Keep the bytes in an UInt8 array and later convert it to Data
        var bytes = [UInt8]()
        bytes.reserveCapacity(string.count / 2)

        // It is a lot faster to use a lookup map instead of strtoul
        let map: [UInt8] = [
            0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, // 01234567
            0x08, 0x09, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, // 89:;<=>?
            0x00, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f, 0x00, // @ABCDEFG
            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00  // HIJKLMNO
        ]

        // Grab two characters at a time, map them and turn it into a byte
        for i in stride(from: 0, to: string.count, by: 2) {
            let index1 = Int(chars[i] & 0x1F ^ 0x10)
            let index2 = Int(chars[i + 1] & 0x1F ^ 0x10)
            bytes.append(map[index1] << 4 | map[index2])
        }

        return Data(bytes)
    }

}
