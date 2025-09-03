//
//  BaseContentView.swift
//  QSC
//
//  Created by FIT on 22/07/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import SwiftUI
import Combine

struct BaseContentView <Content: View>: View  {

    var withScroll:Bool = true
    var paddingValue:CGFloat = 0
    var paddingVerticalValue:CGFloat = 0
    var backgroundType: BackgroundType
    @State var isLandscape:Bool
    var onBack:(()->Void)?
    var onDissmiss:(()->Void)?
    let content:  Content
    @State private var contentSize: CGSize = .zero
    @State var canRunForegroundLogic = true
    @State private var lastActiveTime: Date = Date()
    @State var blurRadius: CGFloat = 0
    @State var isJailbroken:Bool = false

    @ObservedObject var networkMonitor = NetworkMonitor.shared
    
    init(withScroll: Bool  = true,paddingValue:CGFloat = 20,paddingVerticalValue:CGFloat = 16, backgroundType: BackgroundType =  .white, isLandscape:Bool = false, onBack: ( () -> Void)? = nil, onDissmiss: ( () -> Void)? = nil, @ViewBuilder  content:  ()-> Content) {
        self.withScroll = withScroll
        self.backgroundType = backgroundType
        self.paddingValue = paddingValue
        self.onBack = onBack
        self.onDissmiss = onDissmiss
        self.isLandscape = isLandscape
        self.content = content()
    }
    
    var body: some View {
        ZStack{
            switch backgroundType {
            case .gradient:
                gradientBgView
                    .ignoresSafeArea()
            case .white:
                Color.colorBG
                    .ignoresSafeArea()
            case .blackWithAlpha:
                Color.black.opacity(0.2)
                    .ignoresSafeArea()
            case .clear:
                Color.clear
            case .quaternary:
                Color.colorQuaternary
            case.colorBGSecondary:
                Color.colorBGSecondary

            case .gradientPreviewOrder:
                gradientPreviewOrderView.ignoresSafeArea()
            }

            if withScroll{
                GeometryReader{ geo in
                    ScrollView(.vertical){
                        HStack{
                            Spacer()
                                .frame(width: paddingValue)
                            
                            content
                                .frame(minHeight: geo.size.height)
                                .padding(.vertical,paddingVerticalValue)

                            Spacer()
                                .frame(width: paddingValue)
                        }
                    }
                }
                .allowsHitTesting(!isJailbroken)

            }else {
                HStack {
                    Spacer()
                        .frame(width: paddingValue)
                    
                    content
                        .padding(.vertical,paddingVerticalValue)

                    Spacer()
                        .frame(width: paddingValue)
                }
                .allowsHitTesting(!isJailbroken)
            }
            
            if isJailbroken {
                VStack {
                    Text("device_jailbroken".localized)
                        .padding(.vertical, 8)
                    
                    Button(action: {
                        isJailbroken = false
                        exit(0) // Not recommended by Apple, but possible
                    }, label: {
                        Text("ok".localized)
                            .padding(.bottom, 8)
                            .padding(.horizontal, 12)
                            .foregroundColor(.white)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.colorPrimary,lineWidth: 1)
                                    .background(RoundedRectangle(cornerRadius: 20)
                                        .fill(Color.colorPrimary))
                                        .padding(.bottom, 8)
                            )
                    })
                }
                .padding(.horizontal, 8)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.colorPrimary,lineWidth: 1)
                        .background(RoundedRectangle(cornerRadius: 20)
                            .fill(Color.colorBG))

                )
            }
            
       }
        .onChange(of: networkMonitor.isConnected) { isConnected in
            if isConnected {
                MessageViewController.instance.dismissNoInternetMessage(showConnectedMessage: true)
            } else {
                MessageViewController.instance.showNoInternetMessage()
            }
        }
        .onChange(of: UIScreen.main.isCaptured) { value in
            debugPrint("Capture? \(value)")
        }
        .blur(radius: blurRadius)
        .onAppear {
            TimerManager.shared.startTimer()
            
            if JailbreakDetector.isJailbroken() {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    isJailbroken = true
                }
            }
            
            NotificationCenter.default.addObserver(
                forName: UIApplication.didEnterBackgroundNotification,
                object: nil,
                queue: .main
            ) { _ in
//                debugPrint("App entered background")

                recordLastActiveTime()

            }
        

            NotificationCenter.default.addObserver(
                forName: UIApplication.willEnterForegroundNotification,
                object: nil,
                queue: .main
            ) { _ in
//                debugPrint("App will enter foreground")

                checkInactivity()

            }
            
            NotificationCenter.default.addObserver(
                forName: UIApplication.willResignActiveNotification,
                object: nil,
                queue: .main
            ) { _ in
//                debugPrint("App is inactive")
                withAnimation {
                    blurRadius = 15
                }

            }
            
            NotificationCenter.default.addObserver(
                forName: UIApplication.didBecomeActiveNotification,
                object: nil,
                queue: .main
            ) { _ in
//                debugPrint("App is active")
                withAnimation {
                    blurRadius = 0
                }

            }
            
            NotificationCenter.default.addObserver(
                forName: UIApplication.userDidTakeScreenshotNotification,
                object: nil,
                queue: .main
            ) { _ in
                debugPrint("Screenshot taken")
                withAnimation {
                    blurRadius = 0
                }

            }
        }
    }
    
    private func recordLastActiveTime() {
        lastActiveTime = Date()
        UserDefaultController().hasCheckedInactivity = false
    }

    private func checkInactivity() {
        if UserDefaultController().hasCheckedInactivity == true {return}
         
        UserDefaultController().hasCheckedInactivity = true
//        debugPrint("Checking inactivity...")
        let currentTime = Date()
        let inactivityDuration = currentTime.timeIntervalSince(lastActiveTime)
        let timeLimit = Double(UserDefaultController().sessiontimeoutPerSec ?? "") ?? 300 // minimum 5 minutes inactivity
        if inactivityDuration > timeLimit {
            print("User was inactive for more than \(UserDefaultController().sessiontimeoutPerSec ?? "") minutes")
            SessionManager.shared.UsersLogOffAPI(success: true)
        }
    }

    private var gradientBgView:some View {
        let imageName = AppUtility.shared.isDarkTheme ? "babground_gradiant_dark" : "babground_gradiant_light"
      return Image(imageName)
            .resizable()
    }

    private var gradientPreviewOrderView:some View {
        ZStack(alignment: .top){
            Color.colorBGSecondary.ignoresSafeArea()
            Image("background_orderPreview")
                .resizable()
                .frame(width: UIScreen.main.bounds.width)
                .frame(height:  220)
                .scaledToFill()

        } .ignoresSafeArea()
    }
}

#Preview {
    BaseContentView(
        withScroll: true, content: {
            Color.red
        }
    )
}
