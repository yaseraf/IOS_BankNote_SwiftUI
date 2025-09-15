//
//  LoginInformationContentView.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 15/09/2025.
//

import Foundation
import SwiftUI

struct LoginInformationContentView: View {
    
    var stepNumber:Binding<Int>
    
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

    
    var onContinueTap:()->Void
    
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
            Text("login_information".localized)
                .font(.cairoFont(.semiBold, size: 18))
            
            Text("you_will_use_these_details_to_login_to_your_account".localized)
                .font(.cairoFont(.light ,size: 12))
            
            
            fieldsView
            
//            HStack(spacing: 8) {
//                Button(action: {
//
//                }, label: {
//                    HStack {
//                        Text("nationality".localized)
//                            .font(.cairoFont(.semiBold, size: 12))
//                        
//                        Spacer()
//                        
//                        Image("ic_downArrow")
//                            .renderingMode(.template)
//                            .resizable()
//                            .scaledToFit()
//                            .foregroundStyle(Color(hex: "#9C4EF7"))
//                            .frame(width: 15, height: 15)
//                    }
//                    .foregroundStyle(Color(hex: "#1C1C1C"))
//                    .padding(.horizontal, 16)
//                    .frame(height: 56)
//                    .background(RoundedRectangle(cornerRadius: 8).fill(Color(hex: "#DDDDDD")).shadow(color: .black, radius: 0.3, x: 0, y: 1))
//                    .padding(.bottom, 24)
//                })
//            }
//            .padding(.horizontal, 18)
        }
    }
    
    private var fieldsView: some View {
        VStack(spacing: 20) {
            InputField(
                title: "user_name",
                text: $username,
                isValid: isUsernameValid
            )

            InputField(
                title: "password",
                text: $password,
                isSecure: true,
                isValid: isPasswordValid
            )

            InputField(
                title: "confirm_password",
                text: $confirmPassword,
                isSecure: true,
                isValid: doPasswordsMatch
            )
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

}

struct InputField: View {
    var title: String
    @Binding var text: String
    var isSecure: Bool = false
    var isValid: Bool? = nil // nil for default, true for valid, false for invalid
    @State private var isVisible: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .center) {
                VStack(alignment: .leading, spacing: 0) {
                    Text(title.localized)
                        .font(.cairoFont(.light, size: 12))
                    if isSecure && !isVisible {
                        SecureField("", text: $text)
                            .font(.cairoFont(.semiBold, size: 12))
                    } else {
                        TextField("", text: $text)
                            .font(.cairoFont(.semiBold, size: 12))
                    }
                }


                if isSecure {
                    Button(action: {
                        isVisible.toggle()
                    }) {
                        Image(isVisible ? "ic_eyeVisible" : "ic_eyeInvisible")
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(Color(hex: "#828282"))
                            .frame(width: 24, height: 24)
                    }
                }
            }
        }
        .padding(.vertical, 5.5)
        .padding(.horizontal, 12)
        .background(RoundedRectangle(cornerRadius: 8).fill(Color(hex: "#DDDDDD")).shadow(color: .black, radius: 0.3, x: 0, y: 1))
        .padding(.horizontal, 18)

    }

    private var borderColor: Color {
        if let valid = isValid {
            return valid ? .green : .red
        }
        return .clear
    }
}


#Preview {
    LoginInformationContentView(stepNumber: .constant(2), onContinueTap: {
        
    })
}
