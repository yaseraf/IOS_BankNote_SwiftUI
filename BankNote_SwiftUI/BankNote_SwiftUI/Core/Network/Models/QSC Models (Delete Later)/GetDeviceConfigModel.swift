//
//  GetDeviceConfigModel.swift
//  QSC_SwiftUI
//
//  Created by FIT on 19/08/2025.
//

import Foundation

struct GetDeviceConfigsRequestModel {
    
}

struct GetDeviceConfigsResponseModel: Codable {
        let accountOpeningURL, appStoreURL, emiratesIDCode, enableSmartOrder: String?
        let flagIcons, forceUpgrade, forgotPasswordMethod, iconPath: String?
        let lastWorkingDay, maintenanceMsgAr, maintenanceMsgEn, omanAccAfx: String?
        let omanAccBfx, passportCode, playStoreURL, sessiontimeoutPerSec, smsTokenAddress: String?
        let termsAndConditions, termsAndConditionsAR, termsAndConditionsDate, updateInfoLink: String?
        let updateInfoLinkAR, upgradeMsgAr, upgradeMsgEn, videoTutorialLinkAR: String?
        let videoTutorialLinkEN, backEndVersionNo, showMaintenance, uploadAllowedEXT: String?
        let uploadMaxSize: String?
        let BackgroundWatchList: String?

        enum CodingKeys: String, CodingKey {
            case accountOpeningURL = "AccountOpeningURL"
            case appStoreURL = "AppStoreUrl"
            case emiratesIDCode = "EmiratesIDCode"
            case enableSmartOrder = "EnableSmartOrder"
            case flagIcons = "FlagIcons"
            case forceUpgrade = "ForceUpgrade"
            case forgotPasswordMethod = "ForgotPasswordMethod"
            case iconPath = "IconPath"
            case lastWorkingDay = "LastWorkingDay"
            case maintenanceMsgAr = "MaintenanceMsgAr"
            case maintenanceMsgEn = "MaintenanceMsgEn"
            case omanAccAfx = "OmanAccAfx"
            case omanAccBfx = "OmanAccBfx"
            case passportCode = "PassportCode"
            case playStoreURL = "PlayStoreUrl"
            case sessiontimeoutPerSec = "SessiontimeoutPerSec"
            case smsTokenAddress = "SmsTokenAddress"
            case termsAndConditions = "TermsAndConditions"
            case termsAndConditionsAR = "TermsAndConditionsAR"
            case termsAndConditionsDate = "TermsAndConditionsDate"
            case updateInfoLink = "UpdateInfoLink"
            case updateInfoLinkAR = "UpdateInfoLinkAR"
            case upgradeMsgAr = "UpgradeMsgAr"
            case upgradeMsgEn = "UpgradeMsgEn"
            case videoTutorialLinkAR = "VideoTutorialLinkAR"
            case videoTutorialLinkEN = "VideoTutorialLinkEN"
            case backEndVersionNo, showMaintenance
            case uploadAllowedEXT = "uploadAllowedExt"
            case uploadMaxSize
            case BackgroundWatchList = "BackgroundWatchList"
        }
}

struct GetDeviceConfigsUIModel {
    let accountOpeningURL, appStoreURL, emiratesIDCode, enableSmartOrder: String?
    let flagIcons, forceUpgrade, forgotPasswordMethod, iconPath: String?
    let lastWorkingDay, maintenanceMsgAr, maintenanceMsgEn, omanAccAfx: String?
    let omanAccBfx, passportCode, playStoreURL, sessiontimeoutPerSec, smsTokenAddress: String?
    let termsAndConditions, termsAndConditionsAR, termsAndConditionsDate, updateInfoLink: String?
    let updateInfoLinkAR, upgradeMsgAr, upgradeMsgEn, videoTutorialLinkAR: String?
    let videoTutorialLinkEN, backEndVersionNo, showMaintenance, uploadAllowedEXT: String?
    let uploadMaxSize: String?
    let BackgroundWatchList: String?
    
    static func mapToUIModel(_ model:GetDeviceConfigsResponseModel)->Self {
        return  GetDeviceConfigsUIModel(accountOpeningURL: model.accountOpeningURL ?? "", appStoreURL: model.appStoreURL ?? "", emiratesIDCode: model.emiratesIDCode ?? "", enableSmartOrder: model.enableSmartOrder ?? "", flagIcons: model.flagIcons ?? "", forceUpgrade: model.forceUpgrade ?? "", forgotPasswordMethod: model.forgotPasswordMethod ?? "", iconPath: model.iconPath ?? "", lastWorkingDay: model.lastWorkingDay ?? "", maintenanceMsgAr: model.maintenanceMsgAr ?? "", maintenanceMsgEn: model.maintenanceMsgEn ?? "", omanAccAfx: model.omanAccAfx ?? "", omanAccBfx: model.omanAccBfx ?? "", passportCode: model.passportCode ?? "", playStoreURL: model.playStoreURL ?? "", sessiontimeoutPerSec: model.sessiontimeoutPerSec ?? "", smsTokenAddress: model.smsTokenAddress ?? "", termsAndConditions: model.termsAndConditions ?? "", termsAndConditionsAR: model.termsAndConditionsAR ?? "", termsAndConditionsDate: model.termsAndConditionsDate ?? "", updateInfoLink: model.updateInfoLink ?? "", updateInfoLinkAR: model.updateInfoLinkAR ?? "", upgradeMsgAr: model.upgradeMsgAr ?? "", upgradeMsgEn: model.upgradeMsgEn ?? "", videoTutorialLinkAR: model.videoTutorialLinkAR ?? "", videoTutorialLinkEN: model.videoTutorialLinkEN ?? "", backEndVersionNo: model.backEndVersionNo ?? "", showMaintenance: model.showMaintenance ?? "", uploadAllowedEXT: model.uploadAllowedEXT ?? "", uploadMaxSize: model.uploadMaxSize ?? "", BackgroundWatchList: model.BackgroundWatchList ?? "")
    }

    static func initializer() -> Self {
        return GetDeviceConfigsUIModel(accountOpeningURL: "", appStoreURL: "", emiratesIDCode: "", enableSmartOrder: "", flagIcons: "", forceUpgrade: "", forgotPasswordMethod: "", iconPath: "", lastWorkingDay: "", maintenanceMsgAr: "", maintenanceMsgEn: "", omanAccAfx: "", omanAccBfx: "", passportCode: "", playStoreURL: "", sessiontimeoutPerSec: "", smsTokenAddress: "", termsAndConditions: "", termsAndConditionsAR: "", termsAndConditionsDate: "", updateInfoLink: "", updateInfoLinkAR: "", upgradeMsgAr: "", upgradeMsgEn: "", videoTutorialLinkAR: "", videoTutorialLinkEN: "", backEndVersionNo: "", showMaintenance: "", uploadAllowedEXT: "", uploadMaxSize: "", BackgroundWatchList: "")
    }
}
