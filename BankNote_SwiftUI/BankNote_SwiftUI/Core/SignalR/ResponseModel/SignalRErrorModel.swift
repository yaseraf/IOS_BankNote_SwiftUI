//
//  SignalRErrorModel.swift
//  QSC
//
//  Created by FIT on 01/08/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation
struct SignalRErrorResponseModel:Decodable{
    var message:String?
    var source:SignalRErrorType?
}

enum SignalRErrorType:String,Decodable{
    case timeoutException = "TimeoutException"

}
