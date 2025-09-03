//
//  OTPTimerViewModel.swift
//  mahfazati
//
//  Created by Mohammmed on 12/08/2024.
//  Copyright © 2024 Mohammed Mathkour. All rights reserved.
//

import Foundation
class OTPTimerViewModel: ObservableObject {
    @Published var timerObserve: (Int, String)? = (-1,"")

    private weak var timer: Timer?
    private var canResendOtpAfterInSeconds: Int  = 0
    private let maxTimeInSecond: Int

    init(maxTimeInSecond: Int  = 3 * 60) {
        self.maxTimeInSecond = maxTimeInSecond
    }

    func initTimer() {
//        canResendOtpAfterInSeconds = maxTimeInSecond
    }

    func startTimer(resentOtpTimer: Double = 70) {
        endTimerIfNeed()
        var seconds = resentOtpTimer
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {[weak self] (_) in
            seconds -= 1
            if seconds == 0 {
                self?.endTimerIfNeed()
            }
            self?.handleTimerValue(second: Int(seconds))
        }
    }

     func handleTimerValue(second: Int) {
        let time =  second.secondsToHoursMinutesSecondsStrings()
//        let value =  time.minutes + ":"  +  time.seconds
        let value =  time.seconds
        timerObserve = (second, value)
    }

    func endTimerIfNeed() {
        if timer != nil {
            timer?.invalidate()
        }
    }
}
