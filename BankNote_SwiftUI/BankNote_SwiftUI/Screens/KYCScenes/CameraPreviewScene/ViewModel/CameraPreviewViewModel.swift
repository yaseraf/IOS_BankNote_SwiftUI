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
        let compressedString = await resizeImageData(imageData: image, targetSize: CGSize(width: 480, height: 360))

        imageFront = compressedString
        
        stepIndexBind += 1
        isFrontBind = false
    }
    
    func getFrontBackValifyAPI(success: Bool, image: Data) async {

        getFrontBackValifyAPIResult = .onLoading(show: true)
                
        let compressedString = await resizeImageData(imageData: image, targetSize: CGSize(width: 480, height: 360))
        
        imageBack = compressedString

        let requestModel = GetFrontBackValifiyRequestModel(IdBackBase64: imageBack, IdFrontBase64: imageFront, reqID: KeyChainController().valifyRequestId)
        
        //MARK: Template
//        let requestModel = GetFrontBackValifiyRequestModel(IdBackBase64: ImagesTemplates.init().backImageTemplate, IdFrontBase64: ImagesTemplates.init().frontImageTemplate, reqID: KeyChainController().valifyRequestId)
        

        
        Task.init {
            await valifyUseCase.GetFrontBackValify(requestModel: requestModel) {[weak self] result in
                self?.getFrontBackValifyAPIResult = .onLoading(show: false)
                switch result {
                case .success(let success):
                    debugPrint("GetFrontBackValify success")
                    
                    if success.IsSuccessful == true {
                        
                        self?.getFrontBackValifyAPIResult = .onSuccess(response: success)
                        self?.getFrontBackValifyResponse = success
                        KeyChainController().valifyTransactionId = success.TransactionId
                        self?.coordinator.openLivenessCheckScene()
                        self?.stepIndexBind += 1
                        

                    } else {
                        self?.getFrontBackValifyAPIResult = .onFailure(error: .custom(error: success.ErrorMsg ?? ""))
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
    
    func resizeImageDataForLiveness(imageData: Data, targetSize: CGSize) async -> String? {
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


