//
//  NotificationsModel.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 08/03/2026.
//

import Foundation

struct GetAllPushNotificationsByUserRequestModel {
    
}

struct GetAllPushNotificationsByUserResponseModel: Codable {
    let date, descA, descE, id: String?
        let isdelete, isorder, isPush, isRead: String?
        let mobileType, registrationsID, symbol, titleA: String?
        let titleE, totalValue, type, url: String?
        let user, webcode: String?

        enum CodingKeys: String, CodingKey {
            case date = "Date"
            case descA = "DescA"
            case descE = "DescE"
            case id = "ID"
            case isdelete = "ISDELETE"
            case isorder = "ISORDER"
            case isPush = "ISPush"
            case isRead = "IsRead"
            case mobileType = "MobileType"
            case registrationsID = "RegistrationsID"
            case symbol = "Symbol"
            case titleA = "Title_A"
            case titleE = "Title_E"
            case totalValue = "TotalValue"
            case type = "Type"
            case url = "URL"
            case user = "User"
            case webcode
        }
}


struct NotificationUIModel: Codable{
    var date, descA, descE, id: String?
    var isdelete, isorder, isPush, isRead: String?
    var mobileType, registrationsID, symbol, titleA: String?
    var titleE, totalValue, type, url: String?
    var user, webcode: String?
}

extension NotificationUIModel {
    static func mapToUIModel(_ model:GetAllPushNotificationsByUserResponseModel)->Self {
        return NotificationUIModel(date: model.date, descA: model.descA, descE: model.descE, id: model.id, isdelete: model.isdelete, isorder: model.isorder, isPush: model.isPush, isRead: model.isRead, mobileType: model.mobileType, registrationsID: model.registrationsID, symbol: model.symbol, titleA: model.titleA, titleE: model.titleE, totalValue: model.totalValue, type: model.type, url: model.url, user: model.user, webcode: model.webcode)
    }
    
    static func initializer() -> Self {
        return NotificationUIModel()
    }
}

struct AlertUIModel{
    var id:String = UUID().uuidString
    var title:String
    var body:String
    var since:String
    var isRead:Bool
}
