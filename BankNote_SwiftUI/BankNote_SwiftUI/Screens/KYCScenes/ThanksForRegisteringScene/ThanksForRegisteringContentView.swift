//
//  ThanksForRegisteringContentView.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 16/09/2025.
//

import Foundation
import SwiftUI

struct ThanksForRegisteringContentView: View {
    var body: some View {
        VStack {
            Image("ic_bnCoin")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 200, maxHeight: 200)
                .shadow(color: .purple.opacity(0.5), radius: 10, x: 0, y: 5)
                .background {
                    VStack {
                        Spacer()
                        Image("ic_coinShadow")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 111, height: 7)
                            .padding(.bottom, 20)
                    }
                }
            
            Text("thanks_for_registering".localized)
                .font(.cairoFont(.semiBold, size: 18))
                .padding(.bottom, 20)
            
            Text("were_reviewing_your_info_now".localized)
                .font(.cairoFont(.semiBold, size: 12))
            Text("well_email_you_with_next_steps".localized)
                .font(.cairoFont(.semiBold, size: 12))


        }
    }
}

#Preview {
    ThanksForRegisteringContentView()
}
