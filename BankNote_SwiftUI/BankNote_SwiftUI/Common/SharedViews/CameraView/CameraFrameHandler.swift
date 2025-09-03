//
//  CameraFrameHandler.swift
//  QSC
//
//  Created by FIT on 08/04/2025.
//  Copyright © 2025 FIT. All rights reserved.
//

import AVFoundation
import SwiftUI
//import MLImage
//import MLKit

class CameraFrameHandler: NSObject, ObservableObject, AVCaptureVideoDataOutputSampleBufferDelegate {
    @Published var frameImage: UIImage?
    @Published var sampleBuffer: CMSampleBuffer?
    @Published var cameraPosition: AVCaptureDevice.Position?
    
    @Published var capturedImageData1: Data?
    @Published var capturedImageData2: Data?
    @Published var capturedImageData3: Data?

    private var captureCounter = 0

    private let session = AVCaptureSession()
    private let queue = DispatchQueue(label: "CameraFrameQueue")

    override init() {
        super.init()
        setupCamera()
    }

    func setupCamera() {
        guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front),
              let input = try? AVCaptureDeviceInput(device: device)
        else { return }

        session.beginConfiguration()
        session.sessionPreset = .high
        

        if session.canAddInput(input) {
            session.addInput(input)
        }

        let output = AVCaptureVideoDataOutput()
        output.setSampleBufferDelegate(self, queue: queue)

        if session.canAddOutput(output) {
            session.addOutput(output)
        }

        session.commitConfiguration()
        session.startRunning()
    }
    
    func stopCamera() {
        session.stopRunning()
    }

    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) else { return}
        
        var ciImage = CIImage(cvPixelBuffer: pixelBuffer)
//        let oriented = ciImage.oriented(forExifOrientation: 6) // Rotate 90° CW
//        let mirrored = oriented.oriented(.upMirrored) // 👈 Optional: flip horizontally
        
        // Force portrait orientation (6 = 90° CW for iOS front camera)
        let oriented = ciImage.oriented(forExifOrientation: 6)
        let mirrored = oriented.oriented(.upMirrored)


        // 🔁 Rotate the image 90° clockwise
        let rotated = ciImage.oriented(forExifOrientation: 6) // 6 = 90° CW

        let context = CIContext()
        if let cgImage = context.createCGImage(mirrored, from: rotated.extent) {
            DispatchQueue.main.async {
                self.frameImage = UIImage(cgImage: cgImage)
                self.sampleBuffer = sampleBuffer
                self.cameraPosition = device.position
            }
        }
    }
    
    func capturePhoto() {
        guard let buffer = sampleBuffer,
              let pixelBuffer = CMSampleBufferGetImageBuffer(buffer) else { return }

        let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
        let oriented = ciImage.oriented(forExifOrientation: 6) // 90° CW
        let mirrored = oriented.oriented(.upMirrored) // optional: front camera

        let context = CIContext()
        if let cgImage = context.createCGImage(mirrored, from: mirrored.extent) {
            let image = UIImage(cgImage: cgImage)

            // Convert UIImage to JPEG data
            if let imageData = image.jpegData(compressionQuality: 0.8) {
                DispatchQueue.main.async {
                    switch self.captureCounter {
                    case 0:
                        self.capturedImageData1 = imageData
                    case 1:
                        self.capturedImageData2 = imageData
                    case 2:
                        self.capturedImageData3 = imageData
                    default:
                        break
                    }
                    self.captureCounter += 1
                }
            }
        }
    }

      
}
