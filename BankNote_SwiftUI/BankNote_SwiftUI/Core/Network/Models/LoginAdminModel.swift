//
//  LoginAdminModel.swift
//  mahfazati
//
//  Created by FIT on 18/03/2025.
//  Copyright © 2025 FIT. All rights reserved.
//

import Foundation

struct LoginAdminRequestModel: Codable {
    
}

struct LoginAdminResponseModel: Codable {
    let data: LoginAdminDataClass?
    let errorCode, errorMessage: String?

    enum CodingKeys: String, CodingKey {
        case data = "Data"
        case errorCode = "ErrorCode"
        case errorMessage = "ErrorMessage"
    }
}

struct LoginAdminDataClass: Codable {
    let accessToken, apiKey, bundleKey, encryptedAccessToken: String?
    let expireInSeconds: Int?
    let passwordResetCode, refreshToken: String?
    let refreshTokenExpireInSeconds: Int?
    let requiresTwoFactorVerification: Bool?
    let returnURL: String?
    let shouldResetPassword: Bool?
    let twoFactorAuthProviders: TwoFactorDataClass?
    let twoFactorRememberClientToken: String?
    let userID: Int?

    enum CodingKeys: String, CodingKey {
        case accessToken = "AccessToken"
        case apiKey = "ApiKey"
        case bundleKey = "BundleKey"
        case encryptedAccessToken = "EncryptedAccessToken"
        case expireInSeconds = "ExpireInSeconds"
        case passwordResetCode = "PasswordResetCode"
        case refreshToken = "RefreshToken"
        case refreshTokenExpireInSeconds = "RefreshTokenExpireInSeconds"
        case requiresTwoFactorVerification = "RequiresTwoFactorVerification"
        case returnURL = "ReturnUrl"
        case shouldResetPassword = "ShouldResetPassword"
        case twoFactorAuthProviders = "TwoFactorAuthProviders"
        case twoFactorRememberClientToken = "TwoFactorRememberClientToken"
        case userID = "UserId"
    }
}

struct TwoFactorDataClass: Codable {
    let accessToken, apiKey, bundleKey, encryptedAccessToken: String?
    let expireInSeconds: Int?
    let passwordResetCode, refreshToken: String?
    let refreshTokenExpireInSeconds: Int?
    let requiresTwoFactorVerification: Bool?
    let returnURL: String?
    let shouldResetPassword: Bool?
    let twoFactorAuthProviders: String?
    let twoFactorRememberClientToken: String?
    let userId: Int?
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "AccessToken"
        case apiKey = "ApiKey"
        case bundleKey = "BundleKey"
        case encryptedAccessToken = "EncryptedAccessToken"
        case expireInSeconds = "ExpireInSeconds"
        case passwordResetCode = "PasswordResetCode"
        case refreshToken = "RefreshToken"
        case refreshTokenExpireInSeconds = "RefreshTokenExpireInSeconds"
        case requiresTwoFactorVerification = "RequiresTwoFactorVerification"
        case returnURL = "ReturnUrl"
        case shouldResetPassword = "ShouldResetPassword"
        case twoFactorAuthProviders = "TwoFactorAuthProviders"
        case twoFactorRememberClientToken = "TwoFactorRememberClientToken"
        case userId = "UserId"
    }
}
