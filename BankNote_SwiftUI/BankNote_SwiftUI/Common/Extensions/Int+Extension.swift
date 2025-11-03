//
//  Int+Extension.swift
//  QSC
//
//  Created by FIT on 07/08/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation
extension Int{
    func secondsToHoursMinutesSeconds() -> (hours:Int, minutes:Int, seconds:Int) {
        return (self / 3600, (self % 3600) / 60, (self % 3600) % 60)
    }

    func secondsToHoursMinutesSecondsStrings()-> (hours:String, minutes:String, seconds:String) {
       let times =  self.secondsToHoursMinutesSeconds()
        let hoursValue = convertToString(value: times.hours)
        let minutesValue = convertToString(value: times.minutes)
        let secondsValue = convertToString(value: times.seconds)

        return (hoursValue,minutesValue,secondsValue)

        func convertToString(value:Int)->String{
            let valueString = "\(value)"
            if valueString.count == 1{
                return "0" + valueString
            }
            return valueString
        }
    }


    func convertToTowDigitString()->String{
        let valueString = "\(self)"
        if valueString.count == 1{
            return "0" + valueString
        }
        return valueString
    }
}
