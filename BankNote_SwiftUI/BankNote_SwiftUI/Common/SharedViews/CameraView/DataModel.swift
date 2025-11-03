/*
See the License.txt file for this sample’s licensing information.
*/

import AVFoundation
import SwiftUI
import os.log

final class DataModel: ObservableObject {
    let camera = Camera()

    @Published var viewfinderImage: Image?
    @Published var imageOne: Image?
    @Published var imageTwo: Image?
    @Published var imageThree: Image?

    @Published var imageDataOne: Data?
    @Published var imageDataTwo: Data?
    @Published var imageDataThree: Data?

    var isPhotosLoaded = false
    
    init() {
        Task {
            await handleCameraPreviews()
        }
        
        Task {
            await handleCameraPhotos()
        }
    }
    
    

    func handleCameraPreviews() async {
        let imageStream = camera.previewStream
            .map { $0.image }

        for await image in imageStream {
            Task { @MainActor in
                viewfinderImage = image
            }
        }
    }
    
    func handleCameraPhotos() async {
        let unpackedPhotoStream = camera.photoStream
            .compactMap { self.unpackPhoto($0) }
        
        for await photoData in unpackedPhotoStream {
            Task { @MainActor in
                if imageOne == nil {
                    imageOne = photoData.thumbnailImage
                    imageDataOne = photoData.imageData
                }else if imageTwo == nil {
                    imageTwo = photoData.thumbnailImage
                    imageDataTwo = photoData.imageData

                }else if imageThree == nil {
                    imageThree = photoData.thumbnailImage
                    imageDataThree = photoData.imageData
                }
            }
            savePhoto(imageData: photoData.imageData)
        }
    }

    
   //    func handleCameraPhotos(_ capturedImage: UIImage, geometry: GeometryProxy) async {
   //        if let croppedImage = cropImageToRoundedRectangle(capturedImage, in: geometry) {
   //            let unpackedPhotoStream = camera.photoStream
   //                .compactMap { self.unpackPhoto($0) }
   //
   //            for await photoData in unpackedPhotoStream {
   //                Task { @MainActor in
   //                    if imageOne == nil {
   //                        imageOne = Image(uiImage: croppedImage)
   //                        imageDataOne = croppedImage.pngData()
   //                    }else if imageTwo == nil {
   //                        imageTwo = Image(uiImage: croppedImage)
   //                        imageDataTwo = croppedImage.pngData()
   //
   //                    }else if imageThree == nil {
   //                        imageThree = Image(uiImage: croppedImage)
   //                        imageDataThree = croppedImage.pngData()
   //                    }
   //                }
   //                savePhoto(imageData: photoData.imageData)
   //            }
   //        }
   //    }
    
    private func unpackPhoto(_ photo: AVCapturePhoto) -> PhotoData? {
        guard let imageData = photo.fileDataRepresentation() else { return nil }

        guard let previewCGImage = photo.previewCGImageRepresentation(),
           let metadataOrientation = photo.metadata[String(kCGImagePropertyOrientation)] as? UInt32,
              let cgImageOrientation = CGImagePropertyOrientation(rawValue: metadataOrientation) else { return nil }
        let imageOrientation:Image.Orientation
        if camera.isUsingFrontCaptureDevice {
            imageOrientation = Image.Orientation(.leftMirrored)
        }else{
            imageOrientation = Image.Orientation(cgImageOrientation)
        }
        let thumbnailImage = Image(decorative: previewCGImage, scale: 1, orientation: imageOrientation)
        
        let photoDimensions = photo.resolvedSettings.photoDimensions
        let imageSize = (width: Int(photoDimensions.width), height: Int(photoDimensions.height))
        let previewDimensions = photo.resolvedSettings.previewDimensions
        let thumbnailSize = (width: Int(previewDimensions.width), height: Int(previewDimensions.height))
        
        return PhotoData(thumbnailImage: thumbnailImage, thumbnailSize: thumbnailSize, imageData: imageData, imageSize: imageSize)
    }
    
    func savePhoto(imageData: Data) {
        Task {
            do {
//                try await photoCollection.addImage(imageData)
                logger.debug("Added image data to photo collection.")
            } catch let error {
                logger.error("Failed to add image to photo collection: \(error.localizedDescription)")
            }
        }
    }
    

}

fileprivate struct PhotoData {
    var thumbnailImage: Image
    var thumbnailSize: (width: Int, height: Int)
    var imageData: Data
    var imageSize: (width: Int, height: Int)
}

fileprivate extension CIImage {
    var image: Image? {
        let ciContext = CIContext()
        guard let cgImage = ciContext.createCGImage(self, from: self.extent) else { return nil }
        return Image(decorative: cgImage, scale: 1, orientation: .up)
    }
}

fileprivate extension Image.Orientation {

    init(_ cgImageOrientation: CGImagePropertyOrientation) {
        switch cgImageOrientation {
        case .up: self = .up
        case .upMirrored: self = .upMirrored
        case .down: self = .down
        case .downMirrored: self = .downMirrored
        case .left: self = .left
        case .leftMirrored: self = .leftMirrored
        case .right: self = .right
        case .rightMirrored: self = .rightMirrored
        }
    }
}

fileprivate let logger = Logger(subsystem: "com.apple.swiftplaygroundscontent.capturingphotos", category: "DataModel")
