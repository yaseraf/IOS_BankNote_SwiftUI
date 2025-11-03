//
//  ScanIDFrontScene.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 15/09/2025.
//

import Foundation
import SwiftUI
import Combine

struct ScanIDFrontScene: BaseSceneType {
    @ObservedObject var viewModel: CameraPreviewViewModel
    @State var anyCancellable = Set<AnyCancellable>()

    @State var viewTypeAction:BaseSceneViewType  = DefaultBaseSceneViewType()
    var body: some View {
        BaseScene(backgroundType: .colorBGSecondary,contentView: {
            
//                ScanIDFrontContentView(onRetakeTap: {
//
//                }, onNextTap: {
//                    viewModel.openVerifyScanIDFrontScene()
//                })
            
            CameraView(captureLiveImage: $viewModel.captureLiveImage, liveCaptureCount: $viewModel.liveCaptureCount, savedImageOne: $viewModel.savedImageOne, resetData: $viewModel.resetData, stepIndexBind: $viewModel.stepIndexBind, isFrontBind: $viewModel.isFrontBind, failedProcess: $viewModel.failedProcess, viewType: viewModel.viewType, onFaceDetect: { newImage in

            }) { imageData1, imageData2, imageData3, isFrontImage in
                if viewModel.viewType == .selfieMode(liveness: true) {
                    Task {
                        await viewModel.VerifyLivenessAPI(success: true, image1: imageData1 ?? Data(), image2: imageData2 ?? Data(), image3: imageData3 ?? Data())
                    }
                } else if viewModel.viewType == .selfieMode(liveness: false) {
                    viewModel.handleImageData(imageDataOne: imageData1, ImageDataTwo: imageData2)
                } else {
                    if imageData1 != nil  && isFrontImage {
                        Task {
                            await viewModel.VerifyIDFrontVlensAPI(success: true, image: imageData1 ?? Data())
                        }
                    } else if imageData2 != nil && !isFrontImage{
                        Task {
//                            await viewModel.VerifyIDBackAPI(success: true, image: imageData2 ?? Data())
                           await viewModel.getFrontBackValifyAPI(success: true, image: imageData2 ?? Data())
                        }
                    }
                }
            } onFrameUpdate: { newSampleBuffer, newCameraPosition in
//                viewModel.detectFace(sampleBuffer: newSampleBuffer, cameraPosition: newCameraPosition)
            }
        }, showLoading: .constant(viewTypeAction.showLoading))
        .onAppear {
            AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
        }
        .onViewDidLoad(){
            verifyIDFrontVlensAPI()
            verifyIDBackAPI()
            verifyLivenessAPI()
        }
        .onDisappear {
            AppUtility.lockOrientation(.all, andRotateTo: .portrait)
        }

    }

    private func verifyIDFrontVlensAPI() {
        viewModel.$verifyIDFrontVlensAPIResult.receive(on: DispatchQueue.main).sink { result  in
            switch result{
            case .onFailure(let error):
                SceneDelegate.getAppCoordinator()?.showMessage(type: .failure,error.text)
            case.onLoading(let show):
                viewTypeAction.showLoading = show
            case.onSuccess(_):
                debugPrint("Loading..")
                

            case .none:
                break
            }

        }.store(in: &anyCancellable)
    }
    
    private func verifyIDBackAPI() {
        viewModel.$VerifyIDBackAPIResult.receive(on: DispatchQueue.main).sink { result  in
            switch result{
            case .onFailure(let error):
                SceneDelegate.getAppCoordinator()?.showMessage(type: .failure,error.text)
            case.onLoading(let show):
                viewTypeAction.showLoading = show
            case.onSuccess(_):
                debugPrint("Loading..")
                

            case .none:
                break
            }

        }.store(in: &anyCancellable)
    }
    
    private func verifyLivenessAPI() {
        viewModel.$verifyLivenessAPIResult.receive(on: DispatchQueue.main).sink { result  in
            switch result{
            case .onFailure(let error):
                debugPrint("Errored")
//                SceneDelegate.getAppCoordinator()?.showMessage(type: .failure,error.text)
            case.onLoading(let show):
                viewTypeAction.showLoading = show
            case.onSuccess(_):
                debugPrint("Loading..")
                

            case .none:
                break
            }

        }.store(in: &anyCancellable)
    }

}
