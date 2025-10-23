//
//  CameraPreviewDelegate.swift
//  mahfazati
//
//  Created by FIT on 06/04/2025.
//  Copyright © 2025 Mohammed Mathkour. All rights reserved.
//

import Foundation

protocol CameraPreviewDelegate {
    func onRetake(isFrontScan:Bool)
    func onProceed()
}
