//
//  LandingView.swift
//  QSC_SwiftUI
//
//  Created by FIT on 20/07/2025.
//

import SwiftUI

struct LandingContentView: View {

    enum languages {
        case arabic
        case english
    }
    
    @State var selectedLanguage: languages = .english
    
    @State var username: String = ""
    @State var password:String = ""
    @State var isRememberMe:Bool = false
    @State var isPasswordHidden:Bool = true
    
    var onLanguageSelected: (() -> Void)
    var onForgotPasswordTap:()->Void
    var onLoginTap:()->Void

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                logoView
                
                fieldsView
                    .padding(.bottom, 24)

                
                loginButtonView
                    .padding(.bottom, 24)
                
                signupView
                
                Spacer()
            }
            .padding(.top, 24)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .ignoresSafeArea()
        .onAppear {
            if UserDefaultController().appLanguage == "ar" {
                selectedLanguage = .arabic
            } else {
                selectedLanguage = .english
            }
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
                .padding(.bottom, 60)
        }
    }
    
    private var fieldsView: some View {
        var forgetPasswordAttribute: AttributedString {
            var str = AttributedString("\("forgot_password".localized)?")
            str.underlineStyle = .single
            return str
        }
        return VStack {
            VStack(alignment: .leading) {
                TextField("enter_your_user_name".localized, text: $username)
                    .font(.cairoFont(.semiBold, size: 12))
                    .foregroundStyle(Color(hex: "#1C1C1C"))
                    .padding(.horizontal, 16)
                    .frame(height: 56)
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color(hex: "#DDDDDD")).shadow(color: .black, radius: 0.3, x: 0, y: 1))
                    .padding(.bottom, 8)

            }
            
            VStack(alignment: .leading) {
                HStack {
                    if isPasswordHidden {
                        SecureField("password".localized, text: $password)
                            .font(.cairoFont(.semiBold, size: 12))
                            .foregroundStyle(Color(hex: "#1C1C1C"))

                    } else {
                        TextField("password".localized, text: $password)
                            .font(.cairoFont(.semiBold, size: 12))
                            .foregroundStyle(Color(hex: "#1C1C1C"))

                    }
                    
                    Image(isPasswordHidden ? "ic_eyeInvisible" : "ic_eyeVisible")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .onTapGesture {
                            isPasswordHidden.toggle()
                        }
                        
                }
                .padding(.horizontal, 16)
                .frame(height: 56)
                .background(RoundedRectangle(cornerRadius: 8).fill(Color(hex: "#DDDDDD")).shadow(color: .black, radius: 0.3, x: 0, y: 1))
                .padding(.bottom, 8)
                
                HStack {
                    
                    Spacer()
                    
                    Text("\(forgetPasswordAttribute)")
                        .font(.cairoFont(.semiBold, size: 12))
                        .foregroundStyle(Color.colorPrimary)
                        .onTapGesture {
                            onForgotPasswordTap()
                        }
                }
            }

        }
        .padding(.horizontal, 17.5)

    }
    
    private var loginButtonView: some View {
        Button {
            onLoginTap()
        } label: {
            Text("login".localized)
                .font(.cairoFont(.semiBold, size: 14))
                .foregroundStyle(.white)
                .frame(minWidth: 169, minHeight: 51)
                .background(RoundedRectangle(cornerRadius: 99).fill(Color.colorPrimary))
        }

    }
    
    private var signupView: some View {
        var signUpAttribute: AttributedString {
            var str = AttributedString("sign_up".localized)
            str.underlineStyle = .single
            return str
        }

        return HStack {
            Text("\("you_dont_have_an_account".localized)?")
                .font(.cairoFont(.semiBold, size:  12))
            
            
            Text(signUpAttribute)
                .font(.interFont(.regular, size:  12))
                .foregroundStyle(Color(hex: "#629AF9"))

        }
    }
}

#Preview {
    LandingContentView(selectedLanguage: .english, username: "", password: "", isRememberMe: false, isPasswordHidden: false, onLanguageSelected: {
        
    }, onForgotPasswordTap: {
        
    }, onLoginTap: {
        
    })
}
