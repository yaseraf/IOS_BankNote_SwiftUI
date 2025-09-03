//
//  ChangePasswordContentView.swift
//  QSC_SwiftUI
//
//  Created by FIT on 23/07/2025.
//

import Foundation
import SwiftUI 

struct ChangePasswordContentView: View {
    
    @State var newPassword = ""
    @State var confirmNewPassword = ""
    
    @State var isNewPasswordHidden = false
    @State var isConfirmNewPasswordHidden = false
    
    @State var isConfirmPasswordMatching = true
    
    var onBack:()->Void
    var onConfirmChangePassword:()->Void = { }
    
    var body: some View {
        VStack {
            
            Spacer().frame(height: 20)
            
            headerView
            
            Spacer().frame(height: 20)

            inputFieldsView
            
            Spacer()
            
            confirmButtonView
            
            Spacer().frame(height: 20)
        }
    }
    
    private var headerView: some View {
        HStack {
            Circle()
                .frame(width: 40, height: 40)
                .foregroundColor(Color(hex: "#EDEEF6"))
                .overlay {
                    Image("ic_back")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .scaleEffect(AppUtility.shared.isRTL ? -1 : 1)
                }
                .onTapGesture {
                    onBack()
                }
            
            Spacer()
            
            Text("change_password".localized)
                .font(.apply(.medium, size: 16))
                .foregroundStyle(Color.colorTextPrimary)
            
            Spacer()
            
            Circle()
                .frame(width: 40, height: 40)
                .opacity(0)
            
        }
    }
    
    private var inputFieldsView: some View {
        VStack(alignment: .leading) {
            Text("new_password".localized)
                .font(.apply(.bold, size: 14))
                .foregroundStyle(Color.colorTextPrimary)
            
            HStack {
                if isNewPasswordHidden {
                    SecureField("new_password".localized, text: $newPassword)
                        .font(.apply(size: 14))
                } else {
                    TextField("new_password".localized, text: $newPassword)
                        .font(.apply(size: 14))
                }
                
                Image(isNewPasswordHidden ? "ic_eyeInvisible" : "ic_eyeVisible")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .onTapGesture {
                        isNewPasswordHidden.toggle()
                    }
                
            }
            .padding(.horizontal, 16)
            .frame(height: 56)
            .background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).fill(Color.colorBorder))
            .padding(.bottom, 8)
            
            Text("confirm_new_password".localized)
                .font(.apply(.bold, size: 14))
                .foregroundStyle(Color.colorTextPrimary)
            
            HStack {
                if isConfirmNewPasswordHidden {
                    SecureField("confirm_new_password".localized, text: $confirmNewPassword)
                        .font(.apply(size: 14))
                        .onChange(of: confirmNewPassword) { newVal in
                            if confirmNewPassword == newPassword {
                                isConfirmPasswordMatching = true
                            } else {
                                isConfirmPasswordMatching = false
                            }
                        }
                } else {
                    TextField("confirm_new_password".localized, text: $confirmNewPassword)
                        .font(.apply(size: 14))
                        .onChange(of: confirmNewPassword) { newVal in
                            if confirmNewPassword == newPassword {
                                isConfirmPasswordMatching = true
                            } else {
                                isConfirmPasswordMatching = false
                            }
                        }
                }
                
                Image(isConfirmNewPasswordHidden ? "ic_eyeInvisible" : "ic_eyeVisible")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .onTapGesture {
                        isConfirmNewPasswordHidden.toggle()
                    }
                
            }
            .padding(.horizontal, 16)
            .frame(height: 56)
            .background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).fill(isConfirmPasswordMatching ? Color.colorBorder : Color.colorAlert))
            .padding(.bottom, 8)
            
            if !isConfirmPasswordMatching {
                HStack {
                    Image("ic_alert")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 16, height: 16)
                    
                    Text("Confirm password is not matching")
                        .font(.apply(size: 14))
                        .foregroundStyle(Color.colorAlert)
                }
//                .padding(.horizontal, 16)

            }
        }
    }
    
    private var confirmButtonView: some View {
        Text("change_password".localized)
            .font(.apply(.bold, size: 18))
            .foregroundStyle(.white)
            .frame(height: 48)
            .frame(maxWidth: .infinity)
            .foregroundStyle(.white)
            .background(RoundedRectangle(cornerRadius: 16).fill(Color.colorPrimary).opacity(newPassword.isEmpty == false && confirmNewPassword.isEmpty == false ? 1 : 0.5))
            .padding(.horizontal, 20)
            .onTapGesture {
                onConfirmChangePassword()
            }
        
    }
}

