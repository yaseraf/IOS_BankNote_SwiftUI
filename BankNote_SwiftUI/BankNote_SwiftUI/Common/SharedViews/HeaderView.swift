//
//  HeaderView.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 10/09/2025.
//

import Foundation
import SwiftUI

struct HeaderView: View {
    
    @StateObject private var userDefaultController = UserDefaultController.instance

    var body: some View {
        HStack {
            VStack(spacing: 0) {
                Image(AppUtility.shared.APP_LOGO)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                
                Text(AppUtility.shared.APP_NAME)
                    .foregroundStyle(Color(hex: AppUtility.shared.APP_MAIN_COLOR))
                    .font(.cairoFont(.extraBold, size: 14))
            }
            
            Spacer()
            
            Image("ic_globe")
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
//                .foregroundStyle(userDefaultController.marketStatusCode == "0003" ? Color.colorPositive : Color.colorNegative)
                .foregroundStyle(userDefaultController.isSignalRConnected ?? false ? Color.colorPositive : Color.colorNegative)
                .frame(width: 30, height: 30)

            Button {
                SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.openNotificationsScreen()
            } label: {
                Circle()
                    .fill(.white)
                    .frame(width: 40, height: 40)
                    .overlay(
                        Image("ic_notification")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                    )
            }

            
        }
        .padding(.horizontal, 18)
    }
}

#Preview {
    GrabberView()
}
