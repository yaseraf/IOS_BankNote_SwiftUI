//
//  LivenessScanContentView.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 16/09/2025.
//

import SwiftUI
import AVFoundation

struct LivenessScanContentView: View {
    @State private var livenessProgress: Double = 0.0 // Simulating progress
    @StateObject private var cameraCoordinator = CameraView.CameraCoordinator()

    var onNextTap:()->Void
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all) // Dark background

            VStack(spacing: 40) {
                Text("Liveness Check")
                    .font(.cairoFont(.bold, size: 24)) // Assuming you have cairoFont defined
                    .foregroundColor(.white)
                    .padding(.top, 40)

                // The Liveness Check Circle with Camera Placeholder
                ZStack {
                    // The camera view is the first (bottom) layer
                    CameraView(coordinator: cameraCoordinator)
                        .frame(maxWidth: 350, maxHeight: 350)
                        .clipShape(Circle()) // This clips the camera feed into a circle
                        .overlay(
                            Circle() // This adds the outer white circle border
                                .stroke(Color.white.opacity(0.3), lineWidth: 1)
                        )
                    
//                     The progress view is the second (top) layer
                    LivenessProgressView(progress: livenessProgress)
                }

                Spacer()

                // Buttons
                HStack(spacing: 20) {
                    Button(action: {
                        // Retake action
                        livenessProgress = 0.0 // Reset progress for retake
                    }) {
                        Text("retake".localized)
                            .font(.cairoFont(.bold, size: 18))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(.systemGray))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }

                    Button(action: {
                        cameraCoordinator.stopSession()
                        onNextTap()
                    }) {
                        Text("next".localized)
                            .font(.cairoFont(.bold, size: 18))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(hex: "#9C4EF7")) // Assuming you have hex color defined
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
            }
        }
        .onAppear {
            // Simulate progress for demonstration
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                if livenessProgress < 1.0 {
                    livenessProgress += 0.01
                } else {
                    timer.invalidate()
                }
            }
        }
    }
}


struct CameraView: UIViewRepresentable {
    @ObservedObject var coordinator: CameraCoordinator

        init(coordinator: CameraCoordinator = CameraCoordinator()) {
            self._coordinator = ObservedObject(initialValue: coordinator)
        }
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
            view.backgroundColor = .clear
            context.coordinator.hostView = view   // ✅ keep a reference to attach preview later
            return view
        }

    func updateUIView(_ uiView: UIView, context: Context) {
            if let previewLayer = context.coordinator.previewLayer {
                previewLayer.frame = uiView.bounds   // ✅ Keep resizing with SwiftUI layout
            }
        }

    func makeCoordinator() -> CameraCoordinator {
        CameraCoordinator()
    }

    class CameraCoordinator: NSObject, ObservableObject {
        var captureSession: AVCaptureSession?
        var previewLayer: AVCaptureVideoPreviewLayer?

        override init() {
            super.init()
            setupCamera()
        }
        
        weak var hostView: UIView?

        private func setupCamera() {
            captureSession = AVCaptureSession()
            guard let captureSession = captureSession else { return }

            // Configure for front camera
            guard let frontCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) else {
                print("Front camera not available")
                return
            }

            do {
                let input = try AVCaptureDeviceInput(device: frontCamera)
                if captureSession.canAddInput(input) {
                    captureSession.addInput(input)
                }

                let layer = AVCaptureVideoPreviewLayer(session: captureSession)
                        layer.videoGravity = .resizeAspectFill
                        layer.connection?.videoOrientation = .portrait
                        self.previewLayer = layer

                DispatchQueue.main.async {   // ✅ must add layer on main thread
                            if let host = self.hostView {
                                layer.frame = host.bounds
                                host.layer.addSublayer(layer)
                            }
                        }

                // Start the session on a background thread
                AVCaptureDevice.requestAccess(for: .video) { granted in
                    if granted {
                        DispatchQueue.global(qos: .userInitiated).async {
                            self.captureSession?.startRunning()
                        }
                    } else {
                        print("Camera permission not granted")
                    }
                }
            } catch {
                print("Error setting up camera input: \(error.localizedDescription)")
            }
        }
        
        func stopSession() {
            if let session = captureSession, session.isRunning {
                session.stopRunning()
            }
        }
    }
}


struct LivenessProgressView: View {
    let totalSegments: Int = 60 // Number of dashes around the circle
    var progress: Double = 0.5 // Progress from 0.0 to 1.0

    var body: some View {
        ZStack {
            // Background Circle (the gray area)
            Circle()
                .fill(.clear)
                .frame(maxWidth: 350, maxHeight: 350)

            // The individual segments/dashes
            ForEach(0..<totalSegments, id: \.self) { index in
                Rectangle()
                    .frame(width: 4, height: 12) // Size of each dash
                    .cornerRadius(2)
                    .foregroundColor(colorForSegment(index))
                    .offset(y: -175) // Half the circle's diameter to place it on the edge
                    .rotationEffect(.degrees(Double(index) / Double(totalSegments) * 360))
            }
        }
    }

    private func colorForSegment(_ index: Int) -> Color {
        let greenThreshold = Int(progress * Double(totalSegments))
        return index < greenThreshold ? .green : .white
    }
}

#Preview {
    LivenessScanContentView(onNextTap: {
        
    })
}
