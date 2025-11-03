//
//  CameraCoordinator.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 30/09/2025.
//

import Foundation
import AVFoundation
import SwiftUI

class CameraCoordinator: NSObject, ObservableObject {
    var captureSession: AVCaptureSession?
    var previewLayer: AVCaptureVideoPreviewLayer?
    var photoOutput: AVCapturePhotoOutput?
    @Published var capturedImage: UIImage?
    
    weak var hostView: UIView?
    
    override init() {
        super.init()
        setupCamera()
    }
    
    private func setupCamera() {
        self.captureSession = AVCaptureSession()
        guard let session = self.captureSession else { return }

        session.beginConfiguration()
        
        let position: AVCaptureDevice.Position = (UserDefaultController().cameraType == .front) ? .front : .back
        
        guard let camera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: position) else {
            print("Camera not available")
            return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: camera)
            if session.canAddInput(input) {
                session.addInput(input)
            }
        } catch {
            print("Error setting up camera input: \(error.localizedDescription)")
            return
        }
        
        // ✅ Photo Output
        let photoOutput = AVCapturePhotoOutput()
        if session.canAddOutput(photoOutput) {
            session.addOutput(photoOutput)
            self.photoOutput = photoOutput
        }
        
        // ✅ Preview layer
        let layer = AVCaptureVideoPreviewLayer(session: session)
        layer.videoGravity = .resizeAspectFill
        layer.connection?.videoOrientation = .portrait
        self.previewLayer = layer
        
        DispatchQueue.main.async {
            if let host = self.hostView {
                layer.frame = host.bounds
                host.layer.addSublayer(layer)
            }
        }
        
        session.commitConfiguration()
        
        // ✅ Request permission & start once
        AVCaptureDevice.requestAccess(for: .video) { granted in
            if granted {
                DispatchQueue.global(qos: .userInitiated).async {
                    session.startRunning()
                    print("Camera running \(session): \(session.isRunning)")
                }
            } else {
                print("Camera permission not granted")
            }
        }
    }

    
    func takePhoto() {
        guard let session = captureSession else { return }

        if !session.isRunning {
            print("⚠️ Session not running yet, retrying in 0.2s... \(session)")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.takePhoto()
            }
            return
        }


        let settings = AVCapturePhotoSettings()
        settings.flashMode = .off
        debugPrint("Photo output: \(photoOutput!)")
        photoOutput?.capturePhoto(with: settings, delegate: self)
    }

    
    func stopSession() {
        if let session = captureSession, session.isRunning {
            session.stopRunning()
        }
    }
    
    
    
    
}

extension CameraCoordinator: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput,
                     didFinishProcessingPhoto photo: AVCapturePhoto,
                     error: Error?) {
        debugPrint("Capture: \(error) \(photo) \(output)")
        guard let data = photo.fileDataRepresentation(), let image = UIImage(data: data) else {
                print("Failed to capture photo")
            return
        }

        print(" photo: \(data) \(image)")

        
        DispatchQueue.main.async {
            self.capturedImage = image   // ✅ Now SwiftUI can react
        }
    }
}


