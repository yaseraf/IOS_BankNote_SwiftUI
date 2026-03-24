//
//  VerifyOtpPopupContentView.swift
//  QSC_SwiftUI
//
//  Created by FIT on 22/07/2025.
//

import SwiftUI

struct ConfirmOtpPopupContentView: View {
    enum FocusPin {
        case pinOne
        case pinTwo
        case pinThree
        case pinFour
        case pinFive
        case pinSix
    }
    
    var timerObserve:Binding<(Int, String)?>

    @FocusState var selectedPin:FocusPin?
    @State var pinOne:String = ""
    @State var pinTwo:String = ""
    @State var pinThree:String = ""
    @State var pinFour:String = ""
    @State var pinFive:String = ""
    @State var pinSix:String = ""
    
    var onDismiss:() -> Void
    var onResendOtpTap:()->Void
    var onVerify:(String) -> Void
    
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
            
            Text("please_enter_your_otp_to_confirm".localized)
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
                            } else {
                                selectedPin = nil
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
                            if newValue.count == 1 {
                                selectedPin = .pinThree
                            } else {
                                selectedPin = .pinOne
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
                            if newValue.count == 1 {
                                selectedPin = .pinFour
                            } else {
                                selectedPin = .pinTwo
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
                            if newValue.count == 1 {
                                selectedPin = .pinFive
                            } else {
                                selectedPin = .pinThree
                            }
                        }
                        .focused($selectedPin, equals: .pinFour)
                        .textContentType(.oneTimeCode)
                }
            RoundedRectangle(cornerRadius: 16)
                .stroke(lineWidth: 1)
                .foregroundStyle(Color.colorBorder)
                .frame(height: 56)
                .overlay {
                    TextField("-", text: $pinFive)
                        .modifier(OtpModifer(pin: $pinFive))
                        .onChange(of: pinFive) { newValue in
                            if newValue.count == 1 {
                                selectedPin = .pinSix
                            } else {
                                selectedPin = .pinFour
                            }
                        }
                        .focused($selectedPin, equals: .pinFive)
                        .textContentType(.oneTimeCode)
                }
            RoundedRectangle(cornerRadius: 16)
                .stroke(lineWidth: 1)
                .foregroundStyle(Color.colorBorder)
                .frame(height: 56)
                .overlay {
                    TextField("-", text: $pinSix)
                        .modifier(OtpModifer(pin: $pinSix))
                        .onChange(of: pinSix) { newValue in
                            if newValue.count == 1 {
                                selectedPin = nil
                            } else {
                                selectedPin = .pinFive
                            }
                        }
                        .focused($selectedPin, equals: .pinSix)
                        .textContentType(.oneTimeCode)
                }
        }
        .padding(.horizontal, 20)
    }
    
    private var forgetOtpView: some View {
        let timeInt =   timerObserve.wrappedValue?.0 ?? 0

        return HStack{
            if timeInt <= 0 {
                Text("resend_otp".localized)
                    .font(.apply(size: 14))
                    .foregroundStyle(Color.colorPrimary)
                    .onTapGesture {
                        onResendOtpTap()
                    }
            } else if timeInt > 0 {
                Text(AppUtility.shared.isRTL ? "\("seconds".localized) \(timerObserve.wrappedValue?.1 ?? "") " : "\(timerObserve.wrappedValue?.1 ?? "") \("seconds".localized)")
                    .font(.apply(size: 14))
                    .foregroundStyle(Color.colorPrimary)
                    .onTapGesture {
                        onResendOtpTap()
                    }
            }
        }
        
    }
    
    private var verifyButton: some View {
        Text("verify".localized)
            .font(.apply(.medium, size: 16))
            .foregroundStyle(Color.white)
            .frame(maxHeight: 48)
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 16).fill(Color.colorPrimary))
            .padding(.horizontal, 24)
            .onTapGesture {
                onVerify(pinOne+pinTwo+pinThree+pinFive+pinFive+pinSix)
            }
    }
}
