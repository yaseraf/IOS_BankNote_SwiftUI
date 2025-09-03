//
//  LoginView.swift
//  QSC_SwiftUI
//
//  Created by FIT on 16/07/2025.
//

import SwiftUI

struct LoginContentView: View {
    @State var username:String
    @State var password:String
    @State var isRememberMe:Bool = false
    @State var isPasswordHidden:Bool = true
    
    var onSignInTap:((_ username: String, _ password: String, _ isRememberMe: Bool) -> Void)
    var onForgotNameTap:()->Void
    var onForgotPasswordTap:()->Void
    var onChangeLanguage:()->Void
    
    var body: some View {
        VStack {
            headerView
                .padding(.top, 20)
                .padding(.bottom, 32)
            
            titleView
                .padding(.bottom, 24)
            
            inputFieldsView
            
            Spacer()
            
            signInView
        }
    }
    
    private var headerView: some View {
        HStack(spacing: 25) {
            Image("ic_logo")
                .resizable()
                .scaledToFit()
            
            Spacer()
            
            HStack {
                Text("language".localized)
                    .font(.apply(size: 16))
                    .foregroundStyle(Color.colorTextPrimary)

                
                Image("ic_globe")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(Color.colorTextPrimary)
            }
            .padding(.horizontal, 12)
            .frame(height: 36)
            .background(RoundedRectangle(cornerRadius: 78).stroke(lineWidth: 1).fill(Color.colorTextPrimary))
            .onTapGesture {
                onChangeLanguage()
            }
            
        }
        .padding(.horizontal, 20)
    }
    
    private var titleView: some View {
        VStack(spacing: 8) {
            Text("hello_sign_in".localized)
                .font(.apply(.bold, size: 24))
                .foregroundStyle(Color.colorTextPrimary)

            HStack {
                Text("\("not_a_member_yet".localized)")
                    .font(.apply(size: 16))
                    .foregroundStyle(Color.gray)

                Text("sign_up".localized)
                    .font(.apply(size: 16))
                    .foregroundStyle(Color.colorPrimary)
                    .onTapGesture {
                        debugPrint("tapped")
                    }
            }
        }
    }
    
    private var inputFieldsView: some View {
        var forgetNameAttribute: AttributedString {
            var str = AttributedString("forget_name".localized)
            str.underlineStyle = .single
            return str
        }
        var forgetPasswordAttribute: AttributedString {
            var str = AttributedString("forget_password".localized)
            str.underlineStyle = .single
            return str
        }
        return VStack(alignment: .center, spacing: 16) {
            VStack(alignment: .leading) {
                Text("user_name".localized)
                    .font(.apply(.bold, size: 14))
                    .foregroundStyle(Color.colorTextPrimary)

                TextField("please_enter_your_name".localized, text: $username)
                    .font(.apply(size: 14))
                    .padding(.horizontal, 16)
                    .frame(height: 56)
                    .background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).fill(Color.colorBorder))
                    .padding(.bottom, 8)

                HStack {
                    Spacer()
                    Text("\(forgetNameAttribute)")
                        .font(.apply(size: 14))
                        .foregroundStyle(Color.colorPrimary)
                        .onTapGesture {
                            onForgotNameTap()
                        }
                }
            }
            
            VStack(alignment: .leading) {
                Text("password".localized)
                    .font(.apply(.bold, size: 14))
                    .foregroundStyle(Color.colorTextPrimary)

                HStack {
                    if isPasswordHidden {
                        SecureField("password".localized, text: $password)
                            .font(.apply(size: 14))
                    } else {
                        TextField("password".localized, text: $password)
                            .font(.apply(size: 14))
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
                .background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).fill(Color.colorBorder))
                .padding(.bottom, 8)
                
                HStack {
                    HStack(spacing: 8) {
                        Image(isRememberMe ? "ic_checkbox" : "ic_checkboxEmpty")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                        
                        Text("remember_me".localized)
                            .font(.apply(size: 12))
                            .foregroundStyle(.gray)
                    }
                    .onTapGesture {
                        isRememberMe.toggle()
                    }
                    
                    Spacer()
                    Text("\(forgetPasswordAttribute)")
                        .font(.apply(size: 14))
                        .foregroundStyle(Color.colorPrimary)
                        .onTapGesture {
                            onForgotPasswordTap()
                        }
                }
            }
        }
        .padding(.horizontal, 20)
    }
    
    private var signInView: some View {
        Button(action: {
            if !username.isEmpty && !password.isEmpty {
                onSignInTap(username, password, isRememberMe)
            }
        }, label: {
            Text("sign_in".localized)
                .font(.apply(.bold, size: 18))
                .foregroundStyle(.white)
                .frame(height: 48)
                .frame(maxWidth: .infinity)
                .foregroundStyle(.white)
                .background(RoundedRectangle(cornerRadius: 16).fill(Color.colorPrimary).opacity(username.isEmpty == false && password.isEmpty == false ? 1 : 0.5))
                .padding(.horizontal, 20)
        })
                
    }
}
