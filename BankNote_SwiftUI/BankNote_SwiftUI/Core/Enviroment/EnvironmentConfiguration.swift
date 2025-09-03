//
//  EnvironmentConfiguration.swift
//  QSC
//
//  Created by FIT on 27/07/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation

class NetworkConfiguration{
    private(set) var basePath:String
    private var signalRDomain:String
    static let api:String = "api/"
    static let version:String = "v2/"
    
    // SignalR
    private let mobileServices:String = "MobileServices/"
    private let sr:String = "sr/"
    private let signalr:String = "signalr/"
    private let hubs: String = "hubs"

    
   var signalRBasePath:String{
        get{
             signalRDomain + sr +  signalr + hubs
        }
    }

    static var langaugeCode:String {
        get{
            AppUtility.shared.isRTL ? "ar_sa/" : "en_uk/"
        }
    }

    init(basePath: String,signalRDomain:String) {
        self.basePath = basePath
        self.signalRDomain = signalRDomain
    }

    static let development:NetworkConfiguration = .init(
//      basePath: "http://develop.fitoman.com:8090/MobileServices/", signalRDomain: "http://develop.fitoman.com:8090/"
        basePath: "https://mobile.qatar-securities.com/MobileServiceNew/", signalRDomain: "https://mobile.qatar-securities.com/MobileServiceNew/"
    )

    static let preProduction:NetworkConfiguration = .init(
//        basePath: "http://develop.fitoman.com:8090/MobileServices/", signalRDomain: "http://develop.fitoman.com:8090/"
        basePath: "https://mobile.qatar-securities.com/MobileServiceNew/", signalRDomain: "https://mobile.qatar-securities.com/MobileServiceNew/"
    )

    static let production:NetworkConfiguration = .init(
//        basePath: "http://develop.fitoman.com:8090/MobileServices/", signalRDomain: "http://develop.fitoman.com:8090/"
        basePath: "https://mobile.qatar-securities.com/MobileServiceNew/", signalRDomain: "https://mobile.qatar-securities.com/MobileServiceNew/"
    )
}
