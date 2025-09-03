//
//  HubUtility.swift
//  QSC
//
//  Created by FIT on 30/07/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation
import UIKit
class HubUtility{
    static let shared:HubUtility = .init()
   // Test Change
    var hubConnectionStatus:HubConnectionStatus = .none

    func decodeToModel<T:Decodable>(from any: Any?,type:T.Type) -> T? {
        guard let jsonData = convertToJsonData(any: any) else{
//            debugPrint("decodeToModel to convert any to data \n \(any)")
            return nil
        }

      
        do {
            let exchangeArray = try JSONDecoder().decode(type, from: jsonData)
            return exchangeArray
        } catch {
//            debugPrint("decodeToModel Error converting [Any]? to \(type): \(error) \n \(any)")
            return nil
        }
    }


    private func convertToJsonData(any: Any?) -> Data? {
        guard let any = any else { return nil }
        guard let jsonString = any as? String else{
           let jsonData = try? JSONSerialization.data(withJSONObject: any, options: .fragmentsAllowed)
            return jsonData
        }
        let jsonData =  Data(jsonString.utf8)
        return jsonData


    }

}
