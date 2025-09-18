//
//  TopActivitiesDelegate.swift
//  QSC_SwiftUI
//
//  Created by FIT on 27/08/2025.
//

import Foundation

protocol TopActivitiesDelegate {
    func onTopGainerReceived(data: [TopActivitiesUIModel])
    func onTopLoserReceived(data: [TopActivitiesUIModel])
    func onMostActiveReceived(data: [TopActivitiesUIModel])
}

//extension TopActivitiesDelegate {
//    func onTopGainerReceived(data: [TopActivitiesUIModel]) {}
//    func onTopLoserReceived(data: [TopActivitiesUIModel]) {}
//    func onMostActiveReceived(data: [TopActivitiesUIModel]) {}
//}
