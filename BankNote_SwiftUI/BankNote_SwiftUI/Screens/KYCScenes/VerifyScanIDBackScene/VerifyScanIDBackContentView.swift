//
//  VerifyScanIDFrontContentView.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 15/09/2025.
//

import Foundation
import SwiftUI

struct VerifyScanIDBackContentView: View {
    
    @State var stepNumber:Int = 2
    
    @State private var username = "John Dohh"
    @State private var password = "password123"
    @State private var confirmPassword = "password123"

    var isUsernameValid: Bool {
        // A simple validation rule
        return username.count > 3
    }

    var isPasswordValid: Bool {
        // A simple validation rule
        return password.count > 7
    }

    var doPasswordsMatch: Bool {
        return password == confirmPassword && password.count > 0
    }

    
    var onNextTap:()->Void
    var onRetakeTap:()->Void
    
    var body: some View {
        VStack {
            logoView
            
            segmentsView
            
            contentView
                        
            Spacer()
            
            bottomView
                        
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
                if stepNumber > index {
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
        VStack(spacing: 0) {
            Text("confirm_data".localized)
                .font(.cairoFont(.semiBold, size: 18))
            
            fieldsView
                .padding(.vertical, 7)
            
        }
    }
    
    private var fieldsView: some View {
        VStack(spacing: 8) {
            InputField(
                title: "gender",
                text: $username,
                isValid: isUsernameValid
            )

            InputField(
                title: "job_title",
                text: $password,
                isValid: isPasswordValid
            )

            InputField(
                title: "religion",
                text: $confirmPassword,
                isValid: doPasswordsMatch
            )
            
            InputField(
                title: "marital_status",
                text: $confirmPassword,
                isValid: doPasswordsMatch
            )            
        }
    }

    private var bottomView: some View {
        HStack {
            Button {
                onRetakeTap()
            } label: {
                Text("retake".localized)
                    .font(.cairoFont(.semiBold, size: 14))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(RoundedRectangle(cornerRadius: 99).fill(Color(hex: "#828282")))
            }
            
            Button {
                onNextTap()
            } label: {
                Text("next".localized)
                    .font(.cairoFont(.semiBold, size: 14))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(RoundedRectangle(cornerRadius: 99).fill(Color(hex: "#9C4EF7")))
            }


        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 18)
    }

}

#Preview {
    VerifyScanIDFrontContentView(stepNumber: .constant(3), onNextTap: {
        
    }, onRetakeTap: {
        
    })
}
