//
//  HeaderView.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 10/09/2025.
//

import Foundation
import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack {
            VStack(spacing: 0) {
                Image("ic_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                
                Text("XNTRQ".localized)
                    .textCase(.uppercase)
                    .font(.cairoFont(.extraBold, size: 14))
            }
            
            Spacer()
            
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
        .padding(.horizontal, 18)
    }
}

#Preview {
    GrabberView()
}
