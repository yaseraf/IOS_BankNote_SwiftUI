//
//  BaseScene.swift
//  QSC
//
//  Created by FIT on 29/07/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import SwiftUI

struct BaseScene <Content:View> :View{
    private let contentView: Content
    var backgroundType: BackgroundType
    
    @EnvironmentObject var networkMonitor: NetworkMonitor

    private var showLoading:Binding<Bool> = .constant(false)
    init(backgroundType: BackgroundType = .white,@ViewBuilder contentView: () -> Content ,showLoading: Binding<Bool> = .constant(false)) {
        self.backgroundType = backgroundType
        self.showLoading = showLoading
        self.contentView = contentView()
        
    }

    var body: some View {
        ZStack(alignment: .top){
            
            switch backgroundType {
            case .gradient:
                gradientBgView.ignoresSafeArea()
            case .white:
                Color.colorBG.ignoresSafeArea()
            case .blackWithAlpha:
                Color.black.opacity(0.2).ignoresSafeArea()
            case .clear:
                Color.clear.ignoresSafeArea()
            case .quaternary:
                Color.colorQuaternary.ignoresSafeArea()
            case.colorBGSecondary:
                Color.colorBGSecondary.ignoresSafeArea()
            case .gradientPreviewOrder:
                gradientPreviewOrderView.ignoresSafeArea()
            }

            contentView
            
            if showLoading.wrappedValue{
                LoadingView()
            }
        }
    }

    private var gradientBgView:some View {
        if AppUtility.shared.isDarkTheme{
            LinearGradient(gradient: Gradient(colors: [Color.black.opacity(1)]),
                           startPoint: .topLeading,
                           endPoint: .bottom)

        }else{
            LinearGradient(gradient: Gradient(colors: [Color.red.opacity(0.2),
                                                       Color.cyan.opacity(0.2),
                                                       Color.blue.opacity(0.1),
                                                       Color.colorBGSecondary.opacity(0.5),
                                                       Color.colorBGSecondary.opacity(0.75),
                                                       Color.colorBGSecondary.opacity(1)]),
                           startPoint: .topLeading,
                           endPoint: .bottom)
        }
    }

    private var gradientPreviewOrderView:some View {
        Image("background_orderPreview")
            .resizable()
            .frame(width: UIScreen.main.bounds.width)
            .frame(height: UIScreen.main.bounds.height)
    }
}



#Preview {
    BaseScene(contentView: {
        Text("AA")
    }, showLoading: .constant(false))
}


