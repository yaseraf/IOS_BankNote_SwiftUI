//
//  CameraPreviewViewModel.swift
//  mahfazati
//
//  Created by FIT on 09/08/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import AVFoundation
import SwiftUI
//import MLImage
//import MLKit

class CameraPreviewViewModel:ObservableObject{
    private let coordinator: AuthCoordinatorProtocol
    private let kycUseCase: KYCUseCaseProtocol
    private let valifyUseCase: ValifyUseCaseProtocol
    
    @Published var viewType: CameraPreviewType
    @Published var verifyIDFrontVlensAPIResult:APIResultType<VerifyIDFrontVlensUIModel>?
    @Published var VerifyIDBackAPIResult:APIResultType<VerifyIDBackUIModel>?
    @Published var getFrontBackValifyAPIResult:APIResultType<GetFrontBackValifiyUIModel>?
    @Published var verifyLivenessAPIResult:APIResultType<VerifyLivenessUIModel>?
    @Published var verifyIDFrontVlensResponse: VerifyIDFrontVlensUIModel?
    @Published var VerifyIDBackResponse: VerifyIDBackUIModel?
    @Published var getFrontBackValifyResponse: GetFrontBackValifiyUIModel?
    @Published var verifyLivenessResponse: VerifyLivenessUIModel?
    
    @Published var savedImageOne: Image?
    @Published var stepIndexBind: Int = 0
    @Published var isFrontBind: Bool = true
    @Published var failedProcess: Bool = false
    @Published var resetData: Bool = false
    
    @Published var captureLiveImage: Bool = false
    @Published var liveCaptureCount: Int = 0
    
    @Published var imageFront: String?
    @Published var imageBack: String?
    
    init(coordinator: AuthCoordinatorProtocol, kycUseCase: KYCUseCaseProtocol, valifyUseCase: ValifyUseCaseProtocol, viewType: CameraPreviewType, savedImageOne: Image?, stepIndexBind: Int, isFrontBind: Bool) {
        self.coordinator = coordinator
        self.kycUseCase = kycUseCase
        self.valifyUseCase = valifyUseCase
        
        self.viewType = viewType
        self.savedImageOne = savedImageOne
        self.stepIndexBind = stepIndexBind
        self.isFrontBind = isFrontBind
    }
    
    func VerifyIDFrontVlensAPI(success: Bool, image: Data) async {
//        KeyChainController().transactionId = success.transactionID
        
        let compressedString = await resizeImageData(imageData: image, targetSize: CGSize(width: 480, height: 360))

        imageFront = compressedString
        
        stepIndexBind += 1
        isFrontBind = false

        

//        verifyIDFrontVlensAPIResult = .onLoading(show: true)
//
//        let compressedString = await resizeImageData(imageData: image, targetSize: CGSize(width: 480, height: 360))
//
//        let requestModel = VerifyIDFrontVlensRequestModel(Image: compressedString, transaction_id: "", accessToken: KeyChainController().stepCreateAccessToken, Request_Id: KeyChainController().verifyPhoneOtpRequestId)
//
//        //MARK: Template
////        let requestModel = VerifyIDFrontVlensRequestModel(Image: ImagesTemplates.init().frontImageTemplate, transaction_id: "", accessToken: KeyChainController().stepCreateAccessToken, Request_Id: KeyChainController().verifyPhoneOtpRequestId)
//
//
//        Task.init {
//            await kycUseCase.VerifyIDFrontVlens(requestModel: requestModel) {[weak self] result in
//                self?.verifyIDFrontVlensAPIResult = .onLoading(show: false)
//                switch result {
//                case .success(let success):
//                    debugPrint("verify id front vlens success")
//
//                    if success.services?.validations?.validationErrors?.first?.errors?.first?.message == nil || success.services?.validations?.validationErrors?.first?.errors?.first?.message == "" {
//                        if success.errorMessage?.isEmpty == true || success.errorMessage == "null" || success.errorMessage == nil {
//
//                        } else {
////                            SceneDelegate.getAppCoordinator()?.showMessage(type: .failure, "\(success.errorMessage ?? "")")
////                            self?.stepIndexBind -= 1
////                            self?.isFrontBind = true
////                            self?.failedProcess.toggle()
//                        }
//
//                        self?.verifyIDFrontVlensAPIResult = .onSuccess(response: success)
//                        self?.verifyIDFrontVlensResponse = success
//                        KeyChainController().transactionId = success.transactionID
//                        self?.stepIndexBind += 1
//                        self?.isFrontBind = false
//                        self?.openVerifyIDConfirmationScene(savedImageOne: self?.savedImageOne, isFrontID: true, address: success.data?.idFrontData?.address ?? "", name: success.data?.idFrontData?.name ?? "", dateOfBirth: success.data?.idFrontData?.dateOfBirth ?? "", idNumber: success.data?.idFrontData?.idNumber ?? "", idKey: success.data?.idFrontData?.idKey ?? "", gender: "", jobTitle: "", religion: "", maritalStatus: "")
//                    } else {
//                        self?.verifyIDFrontVlensAPIResult = .onFailure(error: .custom(error: success.services?.validations?.validationErrors?.first?.errors?.first?.message ?? ""))
////                        SceneDelegate.getAppCoordinator()?.showMessage(type: .success, "\(success.ErrorMessage)")
//                        self?.stepIndexBind -= 1
//                        self?.isFrontBind = true
//                        self?.failedProcess.toggle()
//
//                    }
//
//
//                case .failure(let failure):
//                        debugPrint("verify id front vlens failed")
//                        self?.verifyIDFrontVlensAPIResult = .onFailure(error: failure)
//                    self?.stepIndexBind -= 1
//                    self?.isFrontBind = true
//                    self?.failedProcess.toggle()
//
//                }
//            }
//        }
    }
    
    func getFrontBackValifyAPI(success: Bool, image: Data) async {

        getFrontBackValifyAPIResult = .onLoading(show: true)
                
        let compressedString = await resizeImageData(imageData: image, targetSize: CGSize(width: 480, height: 360))
        
        imageBack = compressedString

//        let requestModel = VerifyIDBackRequestModel(Image: compressedString, Request_Id: KeyChainController().verifyPhoneOtpRequestId, accessToken: KeyChainController().stepCreateAccessToken, transaction_id: KeyChainController().transactionId)
        
        let requestModel = GetFrontBackValifiyRequestModel(IdBackBase64: ImagesTemplates.init().backImageTemplate, IdFrontBase64: ImagesTemplates.init().frontImageTemplate, reqID: "14691")
//        let requestModel = GetFrontBackValifiyRequestModel(IdBackBase64: imageBack, IdFrontBase64: imageFront, reqID: "14691")
//        let requestModel = GetFrontBackValifiyRequestModel(IdBackBase64: "", IdFrontBase64: "", reqID: "14691")
        
        //MARK: Template
//        let requestModel = VerifyIDBackRequestModel(Image: ImagesTemplates.init().backImageTemplate, Request_Id: KeyChainController().verifyPhoneOtpRequestId, accessToken: KeyChainController().stepCreateAccessToken, transaction_id: KeyChainController().transactionId)
        

        
        Task.init {
            await valifyUseCase.GetFrontBackValify(requestModel: requestModel) {[weak self] result in
                self?.getFrontBackValifyAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    debugPrint("GetFrontBackValify success")
                    
                    if success.IsSuccessful == true {
                        
                        self?.getFrontBackValifyAPIResult = .onSuccess(response: success)
                        self?.getFrontBackValifyResponse = success
//                        self?.coordinator.openTakeSelfieScene(livenessCheck: true)
                        self?.coordinator.openLivenessCheckScene()
//                        self?.openVerifyIDConfirmationScene(savedImageOne: self?.savedImageOne, isFrontID: false, address: "", name: "", dateOfBirth: "", idNumber: "", idKey: "", gender: success.data?.idBackData?.gender ?? "", jobTitle: success.data?.idBackData?.jobTitle ?? "", religion: success.data?.idBackData?.religion ?? "", maritalStatus: success.data?.idBackData?.maritalStatus ?? "")
//                        self?.nextScene()
                        self?.stepIndexBind += 1
                        

                    } else {
                        self?.getFrontBackValifyAPIResult = .onFailure(error: .custom(error: success.ErrorMsg ?? ""))
//                        SceneDelegate.getAppCoordinator()?.showMessage(type: .success, "\(success.ErrorMessage)")
                        self?.stepIndexBind -= 1
                        self?.failedProcess.toggle()

                    }
                    
                case .failure(let failure):
                        debugPrint("GetFrontBackValify failed")
                        self?.getFrontBackValifyAPIResult = .onFailure(error: failure)
                    self?.stepIndexBind -= 1
                    self?.failedProcess.toggle()

                }
            }
        }
    }
    
    func VerifyIDBackAPI(success: Bool, image: Data) async {

        VerifyIDBackAPIResult = .onLoading(show: true)
                
        let compressedString = await resizeImageData(imageData: image, targetSize: CGSize(width: 480, height: 360))

        let requestModel = VerifyIDBackRequestModel(Image: compressedString, Request_Id: KeyChainController().verifyPhoneOtpRequestId, accessToken: KeyChainController().stepCreateAccessToken, transaction_id: KeyChainController().transactionId)
        
        //MARK: Template
//        let requestModel = VerifyIDBackRequestModel(Image: ImagesTemplates.init().backImageTemplate, Request_Id: KeyChainController().verifyPhoneOtpRequestId, accessToken: KeyChainController().stepCreateAccessToken, transaction_id: KeyChainController().transactionId)
        
        Task.init {
            await kycUseCase.VerifyIDBack(requestModel: requestModel) {[weak self] result in
                self?.VerifyIDBackAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    debugPrint("verify id back success")
                    
                    if success.services?.validations?.validationErrors?.first?.errors?.first?.message == nil || success.services?.validations?.validationErrors?.first?.errors?.first?.message == "" {
                        if success.errorMessage?.isEmpty == true || success.errorMessage == "null" || success.errorMessage == nil {
                            
                        } else {
//                            SceneDelegate.getAppCoordinator()?.showMessage(type: .failure, "\(success.errorMessage ?? "")")
//                            self?.stepIndexBind -= 1
//                            self?.failedProcess.toggle()
                        }
                        
                        self?.VerifyIDBackAPIResult = .onSuccess(response: success)
                        self?.VerifyIDBackResponse = success
                        self?.openVerifyIDConfirmationScene(savedImageOne: self?.savedImageOne, isFrontID: false, address: "", name: "", dateOfBirth: "", idNumber: "", idKey: "", gender: success.data?.idBackData?.gender ?? "", jobTitle: success.data?.idBackData?.jobTitle ?? "", religion: success.data?.idBackData?.religion ?? "", maritalStatus: success.data?.idBackData?.maritalStatus ?? "")
//                        self?.nextScene()
                        self?.stepIndexBind += 1
                        

                    } else {
                        self?.VerifyIDBackAPIResult = .onFailure(error: .custom(error: success.services?.validations?.validationErrors?.first?.errors?.first?.message ?? ""))
//                        SceneDelegate.getAppCoordinator()?.showMessage(type: .success, "\(success.ErrorMessage)")
                        self?.stepIndexBind -= 1
                        self?.failedProcess.toggle()

                    }
                    
                case .failure(let failure):
                        debugPrint("verify id back failed")
                        self?.VerifyIDBackAPIResult = .onFailure(error: failure)
                    self?.stepIndexBind -= 1
                    self?.failedProcess.toggle()

                }
            }
        }
    }

    func VerifyLivenessAPI(success: Bool, image1: Data, image2: Data, image3: Data) async {

        verifyLivenessAPIResult = .onLoading(show: true)

        let compressedString1 = await resizeImageDataForLiveness(imageData: image1, targetSize: CGSize(width: 500, height: 500))
        let compressedString2 = await resizeImageDataForLiveness(imageData: image2, targetSize: CGSize(width: 500, height: 500))
        let compressedString3 = await resizeImageDataForLiveness(imageData: image3, targetSize: CGSize(width: 500, height: 500))

        
        let requestModel = VerifyLivenessRequestModel(
            Face1: compressedString1,
            Face2: compressedString2,
            Face3: compressedString3,
            Request_Id: KeyChainController().verifyPhoneOtpRequestId,
            accessToken: KeyChainController().stepCreateAccessToken,
            transaction_id: KeyChainController().transactionId)
        
        //MARK: Template
//        let requestModel = VerifyLivenessRequestModel(
//            Face1: ImagesTemplates.init().livenessFace1Template,
//            Face2: ImagesTemplates.init().livenessFace2Template,
//            Face3: ImagesTemplates.init().livenessFace3Template,
//            Request_Id: KeyChainController().verifyPhoneOtpRequestId,
//            accessToken: KeyChainController().stepCreateAccessToken,
//            transaction_id: KeyChainController().transactionId)
        


        Task.init {
            await kycUseCase.VerifyLiveness(requestModel: requestModel) {[weak self] result in
                self?.verifyLivenessAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    debugPrint("verify liveness success")
                    
//                    SceneDelegate.getAppCoordinator()?.showMessage(type: .success, "Liveness data: \(success)")

                    if success.Services?.validations?.validationErrors?.first?.errors?.first?.message == nil || success.Services?.validations?.validationErrors?.first?.errors?.first?.message == "" {
                        if success.ErrorMessage?.isEmpty == true || success.ErrorMessage == "null" || success.ErrorMessage == nil {
                            
                        } else {
//                            self?.verifyLivenessAPIResult = .onFailure(error: .custom(error: success.ErrorMessage ?? ""))
//                            self?.openTakeSelfieScene(liveness: true)
//                            SceneDelegate.getAppCoordinator()?.showMessage(type: .failure, "\(success.ErrorMessage ?? "")")
                        }
                        
                        self?.verifyLivenessAPIResult = .onSuccess(response: success)
                        self?.verifyLivenessResponse = success
                        self?.stepIndexBind += 1
                        self?.nextScene()
                    } else {
                        self?.verifyLivenessAPIResult = .onFailure(error: .custom(error: success.ErrorMessage ?? ""))
                        self?.openTakeSelfieScene(liveness: true)
                        SceneDelegate.getAppCoordinator()?.showMessage(type: .failure, "\(success.Services?.validations?.validationErrors?.first?.errors?.first?.message ?? "")")


                    }
                    
                case .failure(let failure):
                        debugPrint("verify liveness failed")
                        self?.verifyLivenessAPIResult = .onFailure(error: failure)
//                    SceneDelegate.getAppCoordinator()?.showMessage(type: .success, "Liveness failure: \(failure)")

                    self?.openTakeSelfieScene(liveness: true)
               
                }
            }
        }
    }
    
    func imageOrientation( deviceOrientation: UIDeviceOrientation, cameraPosition: AVCaptureDevice.Position) -> UIImage.Orientation {
      switch deviceOrientation {
          case .portrait:
            return cameraPosition == .front ? .leftMirrored : .right
          case .landscapeLeft:
            return cameraPosition == .front ? .downMirrored : .up
          case .portraitUpsideDown:
            return cameraPosition == .front ? .rightMirrored : .left
          case .landscapeRight:
            return cameraPosition == .front ? .upMirrored : .down
          case .faceDown, .faceUp, .unknown:
            return .up
          @unknown default:
            return .up
      }
    }
    
//    func detectFace(sampleBuffer: CMSampleBuffer, cameraPosition: AVCaptureDevice.Position) {
//        if self.viewType != .selfieMode(liveness: true) {return} // Terminate if screen is not in liveness step
//
//        let visionImage = VisionImage(buffer: sampleBuffer)
//        visionImage.orientation = imageOrientation(deviceOrientation: UIDevice.current.orientation, cameraPosition: cameraPosition)
//
//        let options = FaceDetectorOptions()
//        options.performanceMode = .accurate
//        options.landmarkMode = .all
//        options.classificationMode = .all
//
//        let faceDetector = FaceDetector.faceDetector(options: options)
//
//        weak var weakSelf = self
//        faceDetector.process(visionImage) { faces, error in
//          guard let strongSelf = weakSelf else {
//              debugPrint("Self is nil!")
//            return
//          }
//          guard error == nil, let faces = faces, !faces.isEmpty else {
//            // ...
//              debugPrint("No faces detected")
//            return
//          }
////            debugPrint("Detected face: \(faces.count)")
//
//
//
//            for face in faces {
//                let frame = face.frame
//                if face.hasHeadEulerAngleX {
//                    let rotX = face.headEulerAngleX  // Head is rotated to the uptoward rotX degrees
//                    debugPrint("Face X rotation: \(rotX)")
//
//                    if rotX >= -10 && rotX <= 10 {
//                        // Head straight
//                        if self.liveCaptureCount == 0 {
//                            self.captureLiveImage.toggle()
//                            self.liveCaptureCount += 1
//                            if UserDefaultController().isHeadHorizontalMovement == nil {
//                                UserDefaultController().isHeadHorizontalMovement = true
//                            } else {
//                                UserDefaultController().isHeadHorizontalMovement?.toggle()
//                            }
//                            debugPrint("Forward Face Captured X rotation: \(rotX)")
//
//                        }
//                    }
//
//                    if UserDefaultController().isHeadHorizontalMovement == false {
//
//
//                        if rotX <= -15 {
//                            // Head up
//                            if self.liveCaptureCount == 1 {
//                                self.captureLiveImage.toggle()
//                                self.liveCaptureCount += 1
//                                debugPrint("Captured X rotation: \(rotX)")
//                            }
//
//                        } else if rotX >= 15 {
//                            // Head down
//                            if self.liveCaptureCount == 2 {
//                                self.captureLiveImage.toggle()
//                                self.liveCaptureCount += 1
//                                debugPrint("Captured X rotation: \(rotX)")
//                            }
//                        }
//                    }
//                }
//                if face.hasHeadEulerAngleY {
//                    let rotY = face.headEulerAngleY  // Head is rotated to the right rotY degrees
//                    debugPrint("Face Y rotation: \(rotY)")
//
//                    if UserDefaultController().isHeadHorizontalMovement == true{
//                        if rotY <= -15 {
//                            // Head right
//                            if self.liveCaptureCount == 1 {
//                                self.captureLiveImage.toggle()
//                                self.liveCaptureCount += 1
//                                debugPrint("Captured Y rotation: \(rotY)")
//                            }
//
//                        } else if rotY >= 15 {
//                            // Head left
//                            if self.liveCaptureCount == 2 {
//                                self.captureLiveImage.toggle()
//                                self.liveCaptureCount += 1
//                                debugPrint("Captured Y rotation: \(rotY)")
//                            }
//                        }
//                    }
//                }
//                if face.hasHeadEulerAngleZ {
//                    let rotZ = face.headEulerAngleZ  // Head is tilted sideways rotZ degrees
////                    debugPrint("Face Z rotation: \(rotZ)")
//                }
//            }
//        }
//
//    }
    
    func resizeImageDataForFaceDetector(imageData: Data?, targetSize: CGSize) async -> UIImage? {
        
        // Convert Data to UIImage
        guard let image = UIImage(data: imageData ?? Data()) else { return nil }

        // Get the original image size
        let originalSize = image.size
        
        // Ensure the original height is large enough for cropping
        guard originalSize.height > 100 else {
            print("Image height too small for cropping.")
            return nil
        }
        
        let scaleFactor = min(targetSize.width / image.size.width, targetSize.height / image.size.height)
//        let scaledSize = CGSize(width: image.size.width * scaleFactor, height: image.size.height * scaleFactor)
        let scaledSize = targetSize
        guard let resizedImage = image.resized(to: scaledSize) else { return nil }
        
        return resizedImage
        }

    
    func resizeImageDataForLiveness(imageData: Data, targetSize: CGSize) async -> String? {
//            // Convert Data to UIImage
//            guard let image = UIImage(data: imageData) else { return nil }
//
//            // Calculate the scaling factor to get the target width
//            let scale = targetWidth / image.size.width
//            let targetHeight = image.size.height * scale
//
//            // Resize the image using UIGraphicsImageRenderer
//            let resizedImage = UIGraphicsImageRenderer(size: CGSize(width: targetWidth, height: targetHeight)).image { _ in
//                image.draw(in: CGRect(origin: .zero, size: CGSize(width: targetWidth, height: targetHeight)))
//            }
//
//            // Compress the resized image (change 0.8 to adjust compression quality)
//            guard let compressedData = resizedImage.jpegData(compressionQuality: 0.8) else { return nil }
//
//            // Convert to Base64 string
//            return compressedData.base64EncodedString()
        
        
        // Convert Data to UIImage
        guard let image = UIImage(data: imageData) else { return nil }

        // Get the original image size
        let originalSize = image.size
        
        // Ensure the original height is large enough for cropping
        guard originalSize.height > 100 else {
            print("Image height too small for cropping.")
            return nil
        }
        
        let scaleFactor = min(targetSize.width / image.size.width, targetSize.height / image.size.height)
        let scaledSize = CGSize(width: image.size.width * scaleFactor, height: image.size.height * scaleFactor)
        
        guard let resizedImage = image.resized(to: scaledSize) else { return nil }
        
        // Downscale the cropped image to fit the target dimensions proportionally
        
        // Compress and encode as Base64
        guard let compressedData = resizedImage.jpegData(compressionQuality: 0.8) else { return nil }
        return compressedData.base64EncodedString()
        }
    
    // ID Size: width: 375.0 height: 176.8
    
    func resizeImageData(imageData: Data, targetSize: CGSize) async -> String? {
        // Convert Data to UIImage
        guard let image = UIImage(data: imageData) else { return nil }

        // Get the original image size
        let originalSize = image.size
        
        // Ensure the original height is large enough for cropping
        guard originalSize.height > 100 else {
            print("Image height too small for cropping.")
            return nil
        }
        
        let scaleFactor = min(targetSize.width / image.size.width, targetSize.height / image.size.height)
        let scaledSize = CGSize(width: image.size.width * scaleFactor, height: image.size.height * scaleFactor)
        
        guard let resizedImage = image.resized(to: scaledSize) else { return nil }
        
        // Calculate cropping rectangle
        let cropRect = CGRect(
            x: 0, // No cropping on the sides
            y: 300, // Crop
            width: scaledSize.width + 300,
            height: scaledSize.height + 100
        )
        
        // Crop the image
        guard let croppedCGImage = resizedImage.cgImage?.cropping(to: cropRect) else { return nil }
        let croppedImage = UIImage(cgImage: croppedCGImage)
        
        // Downscale the cropped image to fit the target dimensions proportionally
        
        // Compress and encode as Base64
        guard let compressedData = croppedImage.jpegData(compressionQuality: 0.8) else { return nil }
        return compressedData.base64EncodedString()
    }

    
    func encodeImageToBase64Async(imageData: Data, completion: @escaping (String?) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            let base64String = imageData.base64EncodedString()
            
            DispatchQueue.main.async {
                completion(base64String)  // Calls the completion handler with the Base64 result
            }
        }
    }
    
     func handleImageData(imageDataOne:Data?,ImageDataTwo:Data?)
    {
        nextScene()
    }

    private func nextScene() {
        switch viewType {
        case .selfieMode(let liveness):
            if liveness{
                openQuestionnaireRegisterScene()
            }else{
                openTakeSelfieScene(liveness: true)
            }
        case .scanMode:
            openTakeSelfieScene(liveness: true)
        }
    }
}

extension CameraPreviewViewModel{
    private func openTakeSelfieScene(liveness:Bool) {
        coordinator.openTakeSelfieScene(livenessCheck: liveness)
    }

    private func openQuestionnaireRegisterScene(){
//        coordinator.openQuestionnaireRegisterScene()

    }
    
    private func openVerifyIDConfirmationScene(savedImageOne:Image?, isFrontID:Bool, address:String, name:String, dateOfBirth:String, idNumber:String, idKey:String, gender:String, jobTitle:String, religion:String, maritalStatus:String) {
        coordinator.openVerifyIDConfirmation(delegate: self, savedImageOne: savedImageOne, isFrontID: isFrontID, address: address, name: name, dateOfBirth: dateOfBirth, idNumber: idNumber, idKey: idKey, gender: gender, jobTitle: jobTitle, religion: religion, maritalStatus: maritalStatus)
    }

}

extension CameraPreviewViewModel: CameraPreviewDelegate {
    func onRetake(isFrontScan:Bool) {
//        self.stepIndexBind -= 2
//        self.resetData.toggle()
//        isFrontBind = isFrontScan
        
        // To solve the ID back retake error, reset from the beginning:
        self.stepIndexBind = 0
        self.isFrontBind = true
        self.resetData.toggle()
        self.failedProcess.toggle()
        self.savedImageOne = nil
    }
    
    func onProceed() {
        self.stepIndexBind += 1
    }
    
    
}

extension UIImage {
    func normalized() -> UIImage? {
        guard let cgImage = self.cgImage else { return nil }
        if self.imageOrientation == .up {
            return self
        }
        
        let renderer = UIGraphicsImageRenderer(size: self.size)
        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: self.size))
        }
    }
}

extension UIImage {
    func resized(to targetSize: CGSize) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: targetSize))
        }
    }
}


