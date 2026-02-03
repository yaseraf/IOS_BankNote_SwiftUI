/*
 See the License.txt file for this sample’s licensing information.
 */

import AVFoundation
import SwiftUI
import UIKit

struct CameraView: View {
    
    @Binding var captureLiveImage:Bool
    @Binding var liveCaptureCount:Int
    @Binding var savedImageOne: Image?
    @Binding var resetData:Bool
    @Binding var stepIndexBind:Int
    @Binding var isFrontBind:Bool
    @Binding var failedProcess:Bool
    
    @StateObject private var model = DataModel()

    private static let barHeightFactor = 0.10
    private let viewType:CameraPreviewType
    @State private var stepIndex = 0
    private var picCount = 3
    private var onFaceDetect:((Data?)->Void)?
    private var onComplete:((Data?,Data?,Data?, Bool)->Void)?
    private var onFrameUpdate:((CMSampleBuffer, AVCaptureDevice.Position)->Void)?
    @State var isFront = true
    
    @State var faceOneDetected = false
    @State var faceTwoDetected = false
    @State var faceThreeDetected = false
    @StateObject private var handler = CameraFrameHandler()

    init(captureLiveImage:Binding<Bool>, liveCaptureCount:Binding<Int>, savedImageOne:Binding<Image?>, resetData:Binding<Bool>, stepIndexBind:Binding<Int>, isFrontBind:Binding<Bool>, failedProcess:Binding<Bool>, viewType: CameraPreviewType, onFaceDetect:((Data?)->Void)?, onComplete:((Data?,Data?,Data?, Bool)->Void)?, onFrameUpdate:((CMSampleBuffer, AVCaptureDevice.Position)->Void)?) {
        self._captureLiveImage = captureLiveImage
        self._liveCaptureCount = liveCaptureCount
        self._savedImageOne = savedImageOne
        self._resetData = resetData
        self._stepIndexBind = stepIndexBind
        self._isFrontBind = isFrontBind
        self._failedProcess = failedProcess
        self.viewType = viewType
        self.onFaceDetect = onFaceDetect
        self.onComplete = onComplete
        self.onFrameUpdate = onFrameUpdate
    }

    var body: some View {
        ZStack {
            if UIDevice.current.userInterfaceIdiom == .phone {
                mobileView
            } else if UIDevice.current.userInterfaceIdiom == .pad {
                ipadView
            }
        }
        .onChange(of: stepIndexBind) { newValue in
            stepIndex = newValue
        }
        .onChange(of: isFrontBind) { newValue in
            isFront = newValue
//            model.imageOne = nil
//            model.imageTwo = nil
//            model.imageThree = nil
//            
//            model.imageDataOne = nil
//            model.imageDataTwo = nil
//            model.imageDataThree = nil
        }
        .onChange(of: failedProcess) { newValue in
            if stepIndex == 0 || stepIndex == 1 {
                model.imageOne = nil
                model.imageTwo = nil
                model.imageDataOne = nil
                model.imageDataTwo = nil
                isFrontBind = true
            } else if stepIndex == 2 {
                model.imageTwo = nil
            }
        }
        .onChange(of: resetData) { newValue in
            if stepIndex == 0 || stepIndex == 1 {
                model.imageOne = nil
                model.imageTwo = nil
                model.imageDataOne = nil
                model.imageDataTwo = nil
                isFrontBind = true
            } else if stepIndex == 2 {
                model.imageTwo = nil
            }
        }
        .onChange(of: captureLiveImage) { newValue in
            takeLivenessPicture()
            
        }
        
        .onChange(of: liveCaptureCount) { newValue in
            
        }
        .onAppear {
            if viewType == .selfieMode(liveness: true) {
                handler.setupCamera()
            }
            stepIndex = stepIndexBind
            if savedImageOne != nil
            {
                model.imageOne = savedImageOne
            }
        }
        .onDisappear {
            Task {
                model.camera.stop()
            }
        }
    }
    
    private var mobileView: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            if viewType == .selfieMode(liveness: true) {
                GeometryReader { geometry in
                    if let image = handler.frameImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                        
                            .overlay(alignment: .top) {
                                Text(getTitle())
                                    .font(Font.apply(.semiBold,size: 17))
                                    .foregroundColor(.colorTextPrimaryTwo)
                                    .frame(width: geometry.size.width )
                                    .padding(.top,36)
                            }
                            .overlay(alignment: .center) {
                                centerShape(geometry:geometry)

                            }

                            .overlay(alignment: .bottom) {
                                if viewType != .selfieMode(liveness: true) {
                                    if stepIndex == 0 || stepIndex == 2{
                                        takePhotoView(geometry: geometry)
                                            .padding(.top,20)
                                    } else {
                                        bottomButtonView(geometry: geometry)
                                            .padding(.bottom,20)
                                        
                                    }
                                } else {
                                }
                            }
                            .overlay(alignment: .center)  {
                                Color.clear
                                    .frame(height: geometry.size.height * (1 - (Self.barHeightFactor * 2)))
                                    .accessibilityElement()
                                    .accessibilityLabel("View Finder")
                                    .accessibilityAddTraits([.isImage])
                            }
                    } else {
                        Text("Loading...")
                    }
                }
            } else {
                GeometryReader { geometry in
                    ViewfinderView(image:  $model.viewfinderImage, isLiveness: viewType == .selfieMode(liveness: true))


                        .overlay(alignment: .top) {
                            Text(getTitle())
                                .font(Font.apply(.semiBold,size: 17))
                                .foregroundColor(.colorTextPrimaryTwo)
                                .frame(width: geometry.size.width )
                                .padding(.top,36)
                        }
                        .overlay(alignment: .center) {
                            centerShape(geometry:geometry)

                        }

                        .overlay(alignment: .bottom) {
                            if viewType != .selfieMode(liveness: true) {
                                if stepIndex == 0 || stepIndex == 2{
                                    takePhotoView(geometry: geometry)
                                        .padding(.top,20)
                                } else {
                                    bottomButtonView(geometry: geometry)
                                        .padding(.bottom,20)
                                    
                                }
                            } else {
                                
    //                            if stepIndex == 3 {
    //                                bottomButtonView()
    //                                    .padding(.bottom,20)
    //                            }
                            }
                        }
                        .overlay(alignment: .center)  {
                            Color.clear
                                .frame(height: geometry.size.height * (1 - (Self.barHeightFactor * 2)))
                                .accessibilityElement()
                                .accessibilityLabel("View Finder")
                                .accessibilityAddTraits([.isImage])
                        }
                        .background(.clear)

                        .onAppear {
                            if viewType == .selfieMode(liveness: true) {
                                stepIndex = 0
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    takeLivenessPicturesAutomatically(geometry: geometry)
                                }
                            }
                        }
                    }
                    .task {
                        await model.camera.start()
                            
                        switch viewType {
                        case .selfieMode(let liveness):
                            model.camera.switchCaptureDevice()

                        default:
                            break
                        }
                    }
            }
            
        }
        .onReceive(handler.$frameImage.compactMap { $0 }) { frame in
            if let sampleBuffer = handler.sampleBuffer, let cameraPosition = handler.cameraPosition {
                onFrameUpdate?(sampleBuffer, cameraPosition)
            }
        }
    }
    
    private var ipadView: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            if viewType == .selfieMode(liveness: true) {
                GeometryReader { geometry in
                    if let image = handler.frameImage {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .clipped()
                            .overlay(alignment: .top) {
                                Text(getTitle())
                                    .font(Font.apply(.semiBold,size: 17))
                                    .foregroundColor(.colorTextPrimaryTwo)
                                    .frame(width: geometry.size.width )
                                    .padding(.top,36)
                            }
                            .overlay(alignment: .center) {
                                centerShape(geometry:geometry)

                            }

                            .overlay(alignment: .bottom) {
                                if viewType != .selfieMode(liveness: true) {
                                    if stepIndex == 0 || stepIndex == 2{
                                        takePhotoView(geometry: geometry)
                                            .padding(.top,20)
                                    } else {
                                        bottomButtonView(geometry: geometry)
                                            .padding(.bottom,20)
                                        
                                    }
                                } else {
                                    
        //                            if stepIndex == 3 {
        //                                bottomButtonView()
        //                                    .padding(.bottom,20)
        //                            }
                                }
                            }
                            .overlay(alignment: .center)  {
                                Color.clear
                                    .frame(height: geometry.size.height * (1 - (Self.barHeightFactor * 2)))
                                    .accessibilityElement()
                                    .accessibilityLabel("View Finder")
                                    .accessibilityAddTraits([.isImage])
                            }
                    } else {
                        Text("Loading...")
                    }
                }
//                .task {
//                    await model.camera.start()
//
//                    switch viewType {
//                    case .selfieMode(let liveness):
//                        model.camera.switchCaptureDevice()
//
//                    default:
//                        break
//                    }
//                }
            } else {
                GeometryReader { geometry in
                    ViewfinderView(image:  $model.viewfinderImage, isLiveness: viewType == .selfieMode(liveness: true))


                        .overlay(alignment: .top) {
                            Text(getTitle())
                                .font(Font.apply(.semiBold,size: 17))
                                .foregroundColor(.colorTextPrimaryTwo)
                                .frame(width: geometry.size.width )
                                .padding(.top,36)
                        }
                        .overlay(alignment: .center) {
                            centerShape(geometry:geometry)

                        }

                        .overlay(alignment: .bottom) {
                            if viewType != .selfieMode(liveness: true) {
                                if stepIndex == 0 || stepIndex == 2{
                                    takePhotoView(geometry: geometry)
                                        .padding(.top,20)
                                } else {
                                    bottomButtonView(geometry: geometry)
                                        .padding(.bottom,20)
                                    
                                }
                            } else {
                                
    //                            if stepIndex == 3 {
    //                                bottomButtonView()
    //                                    .padding(.bottom,20)
    //                            }
                            }
                        }
                        .overlay(alignment: .center)  {
                            Color.clear
                                .frame(height: geometry.size.height * (1 - (Self.barHeightFactor * 2)))
                                .accessibilityElement()
                                .accessibilityLabel("View Finder")
                                .accessibilityAddTraits([.isImage])
                        }
                        .background(.clear)

                        .onAppear {
                            if viewType == .selfieMode(liveness: true) {
                                stepIndex = 0
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    takeLivenessPicturesAutomatically(geometry: geometry)
                                }
                            }
                        }
                    }
                    .task {
                        await model.camera.start()
                            
                        switch viewType {
                        case .selfieMode(let liveness):
                            model.camera.switchCaptureDevice()

                        default:
                            break
                        }
                    }
            }
            
        }
        .onReceive(handler.$frameImage.compactMap { $0 }) { frame in
            if let sampleBuffer = handler.sampleBuffer, let cameraPosition = handler.cameraPosition {
                onFrameUpdate?(sampleBuffer, cameraPosition)
            }
        }    }
    
    private func takeLivenessPicture() {
        handler.capturePhoto()
        stepIndex += 1
        if  stepIndex >= 3 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                if let imageOne = handler.capturedImageData1 , let imageTwo = handler.capturedImageData2 , let imageThree = handler.capturedImageData3{
                    onComplete?(handler.capturedImageData1,handler.capturedImageData2, handler.capturedImageData3, false)
                    handler.stopCamera()
                }
            }
        }
    }
    
    private func takeLivenessPicturesAutomatically(geometry: GeometryProxy) {
        for i in 0..<picCount {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i+1) * 1.5) {
                
                model.camera.takePhoto()
 
                stepIndex += 1
//                stepIndex = stepIndexBind
                
                if stepIndex >= 3 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        if let imageOne = model.imageOne , let imageTwo = model.imageTwo , let imageThree = model.imageThree{
                            debugPrint("Completing liveness")
//                            SceneDelegate.getAppCoordinator()?.showMessage(type: .success, "Liveness completed")

                            onComplete?(model.imageDataOne,model.imageDataTwo, model.imageDataThree, false)
                        } else {
                            onComplete?(model.imageDataOne,model.imageDataTwo, model.imageDataThree, false)

//                            SceneDelegate.getAppCoordinator()?.showMessage(type: .failure, "Liveness did not complete, one of the images is invalid")

                        }
                    }
                }
            }
        }
    }

    private func centerShape(geometry:GeometryProxy) -> some View {

        return VStack(spacing:21){
            HStack{
                switch viewType {
                case .selfieMode:
                    ZStack{
                        if viewType != .selfieMode(liveness: true) {
                            getImage()?.resizable()
                                .aspectRatio(contentMode: .fill)
//                                .offset(x:0,y:16)
                                .mask(
                                    Circle()
                                        .frame(width: geometry.size.width / 1.4)
                                        .frame(height: geometry.size.width / 1.4)
                                )
                        }

                        Circle()
                            .stroke(Color.colorWhite,lineWidth: 4)
                            .frame(width: geometry.size.width / 1.4)
                            .frame(height: geometry.size.width / 1.4)
                        
                        
                        
                    }
                case .scanMode:
                    ZStack{

                        if UIDevice.current.userInterfaceIdiom == .phone {
                            getImage()?.resizable()
                                .aspectRatio(contentMode: .fill)
                                .offset(x: 80, y: 15)
                                .mask(
                                    RoundedRectangle(cornerRadius:  24)
                                        .frame(width: geometry.size.width - 10, height: geometry.size.height / 3.5)
                                        .padding(.bottom, 5)
                                        .offset(x: 2.5, y: 0)
                                )
                            
                            RoundedCorner(radius: 24)
//                                .stroke(Color.colorWhite,lineWidth: 4)
                                .stroke(Color.colorWhite,lineWidth: 0)
                                .frame(width: geometry.size.width - 10 )
                                .frame(height: geometry.size.height / 3.5)
    //                            .padding(.horizontal,16)
                                .background(
                                    Color.clear
                                )
                        } else if UIDevice.current.userInterfaceIdiom == .pad {
                            getImage()?.resizable()
                                .aspectRatio(contentMode: .fill)
                                .offset(y: 16)
                                .mask(
                                    RoundedRectangle(cornerRadius:  24)
                                        .frame(width: 642 ,height: 365)
                                )
                            
                            RoundedCorner(radius: 24)
//                                .stroke(Color.colorWhite,lineWidth: 4)
                                .stroke(Color.colorWhite,lineWidth: 0)
                                .frame(width: 642 ,height: 365)
    //                            .padding(.horizontal,16)
                                .background(
                                    Color.clear
                                )
                        }
                           

                        


                    }
                }
            }


            Text(getContent())
                .opacity(0)
                .font(Font.apply(size: 16))
                .foregroundColor(.colorTextSecondaryTwo)
        }


    }
    private func getImage() -> Image?{
        if stepIndex == 1{
            return model.imageOne
        } else if stepIndex == 2{
            return model.imageTwo
        } else if stepIndex == 3 {
            if viewType == .selfieMode(liveness: true) {
                return model.imageThree
            } else {
                return model.imageTwo
            }
        }
        return nil
    }

    private func getContent() ->String{
        var text:String = ""
        switch viewType {
        case .selfieMode(let liveness):
            if liveness{
                if stepIndex == 0{
                    text = "look_directly_into_the_camera".localized
                }else if  stepIndex == 1{
                    text = UserDefaultController().isHeadHorizontalMovement == true ? "look_left".localized : "look_down".localized
                }else if stepIndex == 2{
                    text = UserDefaultController().isHeadHorizontalMovement == true ? "look_right".localized : "look_up".localized
                }
            }else{
                if stepIndex == 0{
                    text = "look_directly_into_the_camera".localized
                }
            }

        case .scanMode(let userIdType):

            if stepIndex == 0  || stepIndex == 2{
                return  switch userIdType {
                case .nationalId: "align_the_national_id_to_the_area_above".localized
                case .passport:  "align_the_passport_to_the_area_above".localized
                case .none:  ""
                }
            }

        }
        return text
    }

    private func getTitle() ->String{
        var text:String = ""
        switch viewType {
        case .selfieMode(let liveness):
            text = (liveness ? "liveness_check" : "take_a_selfie").localized
        case .scanMode(let userIdType):

            if stepIndex == 0  || stepIndex == 1{
                return  switch userIdType {
//                case .nationalId: "scan_the_front_of_your_national_id".localized
                case .nationalId: "scan_the_front_of_your_national_id".localized
                case .passport:  "scan_the_front_of_your_passport".localized
                case .none:  ""
                }
            }else{
                return  switch userIdType {
                case .nationalId: "scan_the_back_of_your_national_id".localized
                case .passport:  "scan_the_back_of_your_passport".localized
                case .none:  ""
                }
            }

        }
        return text
    }


    private func takePhotoView(geometry: GeometryProxy) -> some View {
        HStack() {

            Spacer()

            Button {
                
                model.camera.takePhoto()
                stepIndex += 1
//                stepIndex  = stepIndexBind
 
            } label: {
                Label {
                    Text("Take Photo")
                } icon: {
                    ZStack {
                        Circle()
                            .strokeBorder(.white, lineWidth: 3)
                            .frame(width: 62, height: 62)
                        Circle()
                            .fill(.white)
                            .frame(width: 50, height: 50)
                    }
                }
            }


            Spacer()

        }
        .buttonStyle(.plain)
        .labelStyle(.iconOnly)
        .padding()
    }


    private func bottomButtonView(geometry: GeometryProxy) -> some View {
        HStack(){
            CustomButton(type: .custom(Color(hex: "#828282")), title: "retake".localized) {
                if model.imageTwo != nil {
                    model.imageTwo = nil
                    
                } else if model.imageOne != nil {
                    model.imageOne = nil
                    
                } else if model.imageThree != nil {
                    model.imageThree = nil
                }
                
                if viewType == .selfieMode(liveness: true){
                    model.imageOne = nil
                    model.imageTwo = nil
                    model.imageThree = nil
                    stepIndex = 0
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        takeLivenessPicturesAutomatically(geometry: geometry)
                    }

                } else {
                    stepIndex -= 1
                }

            }
            .cornerRadius(32)

            Spacer().frame(width: 8)

            CustomButton(type: .primary, title: "next".localized,onTap:  {
//                stepIndex += 1
                stepIndexBind = stepIndex
                
                switch viewType {
                case .selfieMode(let liveness):
                    if liveness {
                        
                        
                        if let imageOne = model.imageOne , let imageTwo = model.imageTwo , let imageThree = model.imageThree{
                            onComplete?(model.imageDataOne,model.imageDataTwo, model.imageDataThree, false)
                                
                        }
                    }else{
                        if let imageOne = model.imageOne  {
                            onComplete?(model.imageDataOne, nil, nil, false)
                        }
                    }
                case .scanMode(let userIDType):
                    savedImageOne = model.imageOne
                    onComplete?(model.imageDataOne,model.imageDataTwo, nil, isFrontBind)
//                    isFront = false
                    
//                    if isFront {
//                        model.imageOne = nil
//                        model.imageDataOne = nil
//                    } else {
//                        model.imageTwo = nil
//                        model.imageDataTwo = nil
//                    }
                }
            })
            .cornerRadius(32)
        }
        .frame(maxWidth: .infinity)

    }
    
    private func handleCapturedImage(_ capturedImage: UIImage, geometry: GeometryProxy) {
        if let croppedImage = model.cropImageToRoundedRectangle(capturedImage, in: geometry) {
            switch stepIndex {
            case 1:
                model.imageOne = Image(uiImage: croppedImage)
                model.imageDataOne = croppedImage.pngData()
            case 2:
                model.imageTwo = Image(uiImage: croppedImage)
                model.imageDataTwo = croppedImage.pngData()
            case 3:
                model.imageThree = Image(uiImage: croppedImage)
                model.imageDataThree = croppedImage.pngData()
            default:
                break
            }
        }
    }
}


extension DataModel {
    func cropImageToRoundedRectangle(_ image: UIImage, in geometry: GeometryProxy) -> UIImage? {
        let viewWidth = geometry.size.width
        let viewHeight = geometry.size.height

        // Define the rectangle in image coordinates
        let rectWidth = viewWidth
        let rectHeight = viewHeight / 4.15
        let rectX = (image.size.width - rectWidth) / 2
//        let rectX = image.size.width
        let rectY = (image.size.height - rectHeight) / 2

        let croppingRect = CGRect(x: rectX, y: rectY, width: rectWidth, height: rectHeight)

        // Crop the image
        guard let cgImage = image.cgImage?.cropping(to: croppingRect) else { return nil }

        // Convert cropped CGImage to UIImage
        let croppedImage = UIImage(cgImage: cgImage)

        // Apply rounded corners
        return applyRoundedCorners(to: croppedImage, cornerRadius: 24)
    }

    private func applyRoundedCorners(to image: UIImage, cornerRadius: CGFloat) -> UIImage? {
        let rect = CGRect(origin: .zero, size: image.size)
        UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
        let context = UIGraphicsGetCurrentContext()
        context?.addPath(UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).cgPath)
        context?.clip()
        image.draw(in: rect)
        let roundedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return roundedImage
    }
}
