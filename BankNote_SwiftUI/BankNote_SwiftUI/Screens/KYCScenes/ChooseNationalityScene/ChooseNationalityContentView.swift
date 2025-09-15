//
//  ChooseNationalityContentView.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 15/09/2025.
//

import Foundation
import SwiftUI

struct ChooseNationalityContentView: View {
    
    var stepNumber:Binding<Int>
    
    var onContinueTap:()->Void
    
    var body: some View {
        VStack {
            logoView
            
            segmentsView
            
            contentView
            
            Spacer()
            
            bottomView
            
            termsAndServiceView
            
        }
    }
    
    private var logoView: some View {
        VStack(spacing: 0) {
            Image("ic_logo")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 225, maxHeight: 225)
            
            Text("bank_note".localized)
                .textCase(.uppercase)
                .font(.cairoFont(.extraBold, size: 40))
        }
    }
    
    private var segmentsView: some View {
        HStack(spacing: 4) {
            ForEach(0...6, id: \.self) { index in
                if stepNumber.wrappedValue > index {
                    LinearGradient( gradient: Gradient(colors: [Color(hex: "#FC814B"), Color(hex: "#9C4EF7"), Color(hex: "#629AF9")]), startPoint: .leading, endPoint: .trailing)
                    
                        .cornerRadius(12)
                } else {
                    RoundedRectangle(cornerRadius: 12).fill(Color(hex: "#DDDDDD"))
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 6)
        .padding(.horizontal, 18)
    }
    
    private var contentView: some View {
        VStack {
            Text("please_choose_your_nationality".localized)
                .font(.cairoFont(.semiBold, size: 18))
            
            Text("well_use_this_information_to_verify_your_identity".localized)
                .font(.cairoFont(.light ,size: 12))
            
            HStack(spacing: 8) {
                Button(action: {

                }, label: {
                    HStack {
                        Text("nationality".localized)
                            .font(.cairoFont(.semiBold, size: 12))
                        
                        Spacer()
                        
                        Image("ic_downArrow")
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(Color(hex: "#9C4EF7"))
                            .frame(width: 15, height: 15)
                    }
                    .foregroundStyle(Color(hex: "#1C1C1C"))
                    .padding(.horizontal, 16)
                    .frame(height: 56)
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color(hex: "#DDDDDD")).shadow(color: .black, radius: 0.3, x: 0, y: 1))
                    .padding(.bottom, 24)
                })
            }
            .padding(.horizontal, 18)
        }
    }

    private var bottomView: some View {
        return VStack {
            Button {
                onContinueTap()
            } label: {
                Text("continue".localized)
                    .font(.cairoFont(.semiBold, size: 18))
                    .foregroundStyle(.white)
                    .frame(minWidth: 357, minHeight: 51)
                    .background(RoundedRectangle(cornerRadius: 99).fill(Color.colorPrimary))
            }
            
            Spacer().frame(height: 24)
        }
    }

    private var termsAndServiceView: some View {
        VStack {
            Text("by_clicking_continue_you_agree_to\nour_privacy_policy_and_terms_and_service")
                .font(.cairoFont(.regular, size: 12))
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    ChooseNationalityContentView(stepNumber: .constant(1), onContinueTap: {
        
    })
}
