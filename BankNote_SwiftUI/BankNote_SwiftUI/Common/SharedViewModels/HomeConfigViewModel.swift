//
//  HomeConfigViewModel.swift
//  mahfazati
//
//  Created by Mohammmed on 16/08/2024.
//  Copyright © 2024 Mohammed Mathkour. All rights reserved.
//

import SwiftUI
class HomeConfigViewModel:ObservableObject{
   @ObservedObject static var shared = HomeConfigViewModel()
    @Published var notificationCount:Int = 0

}
