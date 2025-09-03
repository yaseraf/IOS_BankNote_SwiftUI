//
//  VerifyOtpPopupContentView.swift
//  QSC_SwiftUI
//
//  Created by FIT on 22/07/2025.
//

import SwiftUI

struct VerifyOtpPopupContentView: View {
    enum FocusPin {
        case pinOne
        case pinTwo
        case pinThree
        case pinFour
    }
    
    @FocusState var selectedPin:FocusPin?
    @State var pinOne:String = ""
    @State var pinTwo:String = ""
    @State var pinThree:String = ""
    @State var pinFour:String = ""
    
    var onDismiss:() -> Void
    var onForgotPinTap:()->Void
    var onVerify:(_ tokenId: String) -> Void
    

    var body: some View {
        VStack(spacing: 0) {
  
            headerView
 
            Spacer().frame(height: 20)

            pinsView
            
            Spacer().frame(height: 20)
            
            forgetOtpView
            
            Spacer().frame(height: 20)
            
            verifyButton
            
            Spacer()

        }
        .padding(.bottom,AppUtility.bottomNotch)
        .padding(.top,16)
        .background(Color.colorBG)
        .cornerRadius(24, corners: [.topLeft, .topRight])
        .onAppear {
            selectedPin = .pinOne
        }
    }
    
    private var headerView: some View {
        VStack {
            RoundedRectangle(cornerRadius: 100)
                .frame(height: 4)
                .padding(.horizontal, 165)
                .padding(.bottom, 8)
                .foregroundStyle(Color.colorBorder)
            
            HStack {
                Circle()
                    .frame(width: 40, height: 40)
                    .opacity(0)
                
                Spacer()
                
                Text("otp".localized)
                    .font(.apply(.medium, size: 16))
                    .foregroundColor(Color.colorTextPrimary)

                    
                Spacer()
                
                Circle()
                    .stroke(lineWidth: 1)
                    .foregroundStyle(Color.colorBorder)
                    .frame(width: 40, height: 40)
                    .overlay(
                        Image("ic_close")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 24)
                    )
                    .onTapGesture {
                        onDismiss()
                    }
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 36)
            
            Text("please_enter_otp".localized)
                .font(.apply(.regular, size: 16))
        }
    }
    
    private var pinsView: some View {
        HStack(spacing: 20) {
            RoundedRectangle(cornerRadius: 16)
                .stroke(lineWidth: 1)
                .foregroundStyle(Color.colorBorder)
                .frame(height: 56)
                .overlay {
                    TextField("-", text: $pinOne)
                        .modifier(OtpModifer(pin: $pinOne))
                        .onChange(of: pinOne) { newValue in
                            if newValue.count == 1 {
                                selectedPin = .pinTwo
                            }
                        }
                        .focused($selectedPin, equals: .pinOne)
                        .textContentType(.oneTimeCode)
                }
            RoundedRectangle(cornerRadius: 16)
                .stroke(lineWidth: 1)
                .foregroundStyle(Color.colorBorder)
                .frame(height: 56)
                .overlay {
                    TextField("-", text: $pinTwo)
                        .modifier(OtpModifer(pin: $pinTwo))
                        .onChange(of: pinTwo) { newValue in
                            if newValue.isEmpty {
                                selectedPin = .pinOne
                            } else if newValue.count == 1 {
                                selectedPin = .pinThree
                            }

                        }
                        .focused($selectedPin, equals: .pinTwo)
                        .textContentType(.oneTimeCode)
                }
            RoundedRectangle(cornerRadius: 16)
                .stroke(lineWidth: 1)
                .foregroundStyle(Color.colorBorder)
                .frame(height: 56)
                .overlay {
                    TextField("-", text: $pinThree)
                        .modifier(OtpModifer(pin: $pinThree))
                        .onChange(of: pinThree) { newValue in
                            if newValue.isEmpty {
                                selectedPin = .pinTwo
                            } else if newValue.count == 1 {
                                selectedPin = .pinFour
                            }

                        }
                        .focused($selectedPin, equals: .pinThree)
                        .textContentType(.oneTimeCode)
                }
            RoundedRectangle(cornerRadius: 16)
                .stroke(lineWidth: 1)
                .foregroundStyle(Color.colorBorder)
                .frame(height: 56)
                .overlay {
                    TextField("-", text: $pinFour)
                        .modifier(OtpModifer(pin: $pinFour))
                        .onChange(of: pinFour) { newValue in
                            if newValue.isEmpty {
                                selectedPin = .pinThree
                            } else {
                                selectedPin = nil // dismiss focus at last digit
                            }


                        }
                        .focused($selectedPin, equals: .pinFour)
                        .textContentType(.oneTimeCode)
                }
        }
        .padding(.horizontal, 66)
    }
    
    private var forgetOtpView: some View {
        Text("forgot_otp".localized)
            .font(.apply(size: 14))
            .foregroundStyle(Color.colorPrimary)
            .onTapGesture {
                onForgotPinTap()
            }
    }
    
    private var verifyButton: some View {
        Button(action: {
            onVerify(pinOne+pinTwo+pinThree+pinFour)
        }, label: {
                Text("verify".localized)
                    .font(.apply(.medium, size: 16))
                    .foregroundStyle(Color.white)
                    .frame(maxHeight: 48)
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 16).fill(Color.colorPrimary))
                    .padding(.horizontal, 24)
            }
        )
    }
}
