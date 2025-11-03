//
//  HomeConfigViewModel.swift
//  mahfazati
//
//  Created by FIT on 16/08/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import SwiftUI
class HomeConfigViewModel:ObservableObject{
   @ObservedObject static var shared = HomeConfigViewModel()
    @Published var notificationCount:Int = 0

}
