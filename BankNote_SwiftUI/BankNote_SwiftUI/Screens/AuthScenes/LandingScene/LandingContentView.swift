//
//  LandingView.swift
//  QSC_SwiftUI
//
//  Created by FIT on 20/07/2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var SdkIntegration = sdkIntegration() // Use @StateObject

    var body: some View {
        VStack(spacing: 20) {
            // Title
            Text("OCR & LIVENESS SDK")
                .font(.title)

            // Start Scan Button
            Button("Start Scan") {
//                SdkIntegration.startOCR() // Call startOCR directly
                SdkIntegration.startLiveness(transactionFrontId: "123456") // Call startOCR directly
            }
            .font(.title2)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)

            // Access Token Display
            if !SdkIntegration.accessToken.isEmpty {
                Text("Access Token: \(SdkIntegration.accessToken)") // Show access token
                    .font(.subheadline)
                    .padding()
                    .background(Color.green.opacity(0.2))
                    .cornerRadius(5)
            }

            // Error Message Display
            if !SdkIntegration.errorMessage.isEmpty {
                Text("Error: \(SdkIntegration.errorMessage)") // Show error message
                    .font(.subheadline)
                    .foregroundColor(.red)
                    .padding()
                    .background(Color.red.opacity(0.2))
                    .cornerRadius(5)
            }

            // OCR Result Message Display
            Text("OCR Result: \(SdkIntegration.ocrResultMessage)")
                .font(.subheadline)
                .padding()
                .background(Color.yellow.opacity(0.2))
                .cornerRadius(5)

            // Liveness Result Message Display
            Text("Liveness Result: \(SdkIntegration.livenessResultMessage)")
                .font(.subheadline)
                .padding()
                .background(Color.orange.opacity(0.2))
                .cornerRadius(5)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



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
    var onLoginTap:(_ email: String, _ password: String, _ isRememberMe: Bool)->Void
    var onSignUpTap:()->Void

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
//                ContentView()
                logoView
                
                fieldsView
                    .padding(.bottom, 24)
                    .opacity(0)

                
                loginButtonView
                    .padding(.bottom, 24)
                    .opacity(0)

                signupView
                
                Spacer()
            }
            .padding(.top, 24)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .ignoresSafeArea()
        .onAppear {
//            if UserDefaultController().appLanguage == "ar" {
//                selectedLanguage = .arabic
//            } else {
//                selectedLanguage = .english
//            }
        }
    }
    
    private var logoView: some View {
        VStack(spacing: 0) {
            Image("ic_logo")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 225, maxHeight: 225)
            
            Text("XNTRQ".localized)
                .textCase(.uppercase)
                .font(.cairoFont(.extraBold, size: 40))
                .foregroundStyle(.black)
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
            onLoginTap(username, password, isRememberMe)
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
                .foregroundStyle(.black)

            
            Button {
                onSignUpTap()
            } label: {
                Text(signUpAttribute)
                    .font(.interFont(.regular, size:  12))
                    .foregroundStyle(Color(hex: "#629AF9"))
            }


        }
    }
}

#Preview {
    LandingContentView(selectedLanguage: .english, username: "", password: "", isRememberMe: false, isPasswordHidden: false, onLanguageSelected: {
        
    }, onForgotPasswordTap: {
        
    }, onLoginTap: { email, password, isRememberMe in
        
    }, onSignUpTap: {
        
    })
}
