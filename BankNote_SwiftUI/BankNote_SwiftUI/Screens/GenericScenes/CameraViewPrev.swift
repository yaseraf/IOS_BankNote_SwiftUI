//
//  CameraView.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 30/09/2025.
//

import Foundation
import SwiftUI

struct CameraViewPrev: UIViewRepresentable {
    @ObservedObject var coordinator: CameraCoordinator
    
    init(coordinator: CameraCoordinator = CameraCoordinator()) {
        self._coordinator = ObservedObject(initialValue: coordinator)
    }
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
            view.backgroundColor = .clear
            coordinator.hostView = view   // ✅ keep a reference to attach preview later
            return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        if let previewLayer = coordinator.previewLayer {
            previewLayer.frame = uiView.bounds   // ✅ Keep resizing with SwiftUI layout
        }
    }

//    func makeCoordinator() -> CameraCoordinator {
//        CameraCoordinator()
//    }
}

