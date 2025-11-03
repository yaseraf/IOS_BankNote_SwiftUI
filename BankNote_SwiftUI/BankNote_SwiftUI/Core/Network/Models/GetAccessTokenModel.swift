//
//  GetAccessTokenModel.swift
//  mahfazati
//
//  Created by FIT on 09/11/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation

struct GetAccessTokenRequestModel: Codable {
    var Client_ID: String?
    var Client_Secret : String?
    var Reference_No: String?
    
    
}

struct GetAccessTokenResponseModel: Codable {
    var Error_code: String?
    var resData: AccessTokenResData?
}

struct AccessTokenResData: Codable {
    var access_token: String?
    var expires_in: Double?
}
