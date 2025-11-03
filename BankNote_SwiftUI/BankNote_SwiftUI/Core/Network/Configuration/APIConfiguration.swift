//
//  Configuration.swift
//  QSC
//
//  Created by FIT on 27/07/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation
public class APIConfiguration{
    public static let shared = APIConfiguration()
    private  var timeoutIntervalForRequest:Double

    public init(timeoutIntervalForRequest: Double = 30) {
        self.timeoutIntervalForRequest = timeoutIntervalForRequest
    }

    public  func getTimeoutForRequest()->TimeInterval{
        return timeoutIntervalForRequest
    }

    public  func setTimeoutForRequest(value: Double){
        self.timeoutIntervalForRequest = value
    }
}
