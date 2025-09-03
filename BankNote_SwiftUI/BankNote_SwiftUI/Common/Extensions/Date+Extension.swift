//
//  Date+Extension.swift
//  QSC
//
//  Created by FIT on 01/08/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation
extension Date{
    enum DateShapeType:String{
        case MMMdd_yyyy = "MMM dd, yyyy"
        case MMMdd_yyyy_at_WithTime = "MMM dd, yyyy at HH:mm:a"
        case yyMMddWithTime = "yy/MM/dd HH:mm:ss.SSSS"
        case ddMMMyyyyyHHmm = "dd MMM yyyy, HH:mm"
        case yyyyMMdd = "yyyy/MM/dd"
        case ddMMyyyy = "dd/MM/yyyy"
        case ddMMyyyyHHmmss = "ddMMyyyyHHmmss"
        case HHMMSS = "HH:MM:SS"

    }

    func toString(dateFormat format: DateShapeType) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        dateFormatter.locale = Locale(identifier: "en")
        return dateFormatter.string(from: self)
    }

    func byAdding(items: [Calendar.Component:Int]) -> Date {
        let calendar = Calendar.current
        var date = self
        for (key, value) in items {
            if let newDate =  calendar.date(byAdding: key, value: value, to: date){
                date = newDate
            }
        }
        return date
    }


   

    func formattedDateAndTimeWithTodayAndYesterday() -> String {
        let date = self
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en")

        // Check if the date is today
        if calendar.isDateInToday(date) {
            dateFormatter.dateFormat = "h:mm a"
            return "\("today".localized), \(dateFormatter.string(from: date))"
        }
        // Check if the date is yesterday
        else if calendar.isDateInYesterday(date) {
            dateFormatter.dateFormat = "h:mm a"
            return "\("yesterday".localized), \(dateFormatter.string(from: date))"
        }
        // Otherwise, return the date in the format "yyyy/MM/dd, h:mm a"
        else {
            dateFormatter.dateFormat = "yyyy/MM/dd, h:mm a"
            return dateFormatter.string(from: date)
        }
    }
    func formattedDateAndTimeWithTodayAndYesterdayOnlyDay() -> String {
        let date = self
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en")

        // Check if the date is today
        if calendar.isDateInToday(date) {
          
            return "\("today".localized)"
        }
        // Check if the date is yesterday
        else if calendar.isDateInYesterday(date) {
           
            return "\("yesterday".localized)"
        }
        // Otherwise, return the date in the format "yyyy/MM/dd, h:mm a"
        else {
            dateFormatter.dateFormat = "dd/MM/yyyy"
            return dateFormatter.string(from: date)
        }
    }
}
