//
//  OrientationObserver.swift
//  QSC
//
//  Created by FIT on 28/04/2025.
//  Copyright © 2025 FIT. All rights reserved.
//

import SwiftUI
import Combine

class OrientationObserver: ObservableObject {
    @Published var isLandscape: Bool = UIDevice.current.orientation.isLandscape
    @Published var orientation: UIDeviceOrientation = UIDevice.current.orientation

    private var cancellable: AnyCancellable?

    init() {
        self.isLandscape = UIDevice.current.orientation.isLandscape
        
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()

        // Initial orientation check
        let orientation = UIDevice.current.orientation
        if orientation.isValidInterfaceOrientation {
            self.isLandscape = orientation.isLandscape
        } else {
            self.isLandscape = UIScreen.main.bounds.width > UIScreen.main.bounds.height
        }
        
        // Listen to orientation changes
        cancellable = NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)
            .sink { _ in
                let orientation = UIDevice.current.orientation
                if orientation.isValidInterfaceOrientation {
                    self.isLandscape = orientation.isLandscape
                } else {
                    self.isLandscape = UIScreen.main.bounds.width > UIScreen.main.bounds.height
                }
            }
    }
}
