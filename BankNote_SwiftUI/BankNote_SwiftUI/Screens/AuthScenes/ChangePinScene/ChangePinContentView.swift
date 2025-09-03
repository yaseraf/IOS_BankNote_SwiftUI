//
//  ChangePinContentView.swift
//  QSC_SwiftUI
//
//  Created by FIT on 23/07/2025.
//

import SwiftUI

struct ChangePinContentView: View {
    
    enum FocusPin {
        case newPinOne
        case newPinTwo
        case newPinThree
        case newPinFour
        case confirmNewPinOne
        case confirmNewPinTwo
        case confirmNewPinThree
        case confirmNewPinFour
    }
    
    @FocusState var selectedPin:FocusPin?
    
    @State var newPinOne:String = ""
    @State var newPinTwo:String = ""
    @State var newPinThree:String = ""
    @State var newPinFour:String = ""
    
    @State var confirmNewPinOne:String = ""
    @State var confirmNewPinTwo:String = ""
    @State var confirmNewPinThree:String = ""
    @State var confirmNewPinFour:String = ""
    
    @State var confirmPinMatching = true
    
    var onBack: () -> Void
    var onCreatePin: () -> Void
    
    var body: some View {
        VStack {
            
            Spacer().frame(height: 20)
            headerView
            
            Spacer().frame(height: 20)
            
            pinsView
            
            Spacer()
            
            createPinView
            
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
            
            Text("set_pin".localized)
                .font(.apply(.medium, size: 16))
                .foregroundStyle(Color.colorTextPrimary)
            
            Spacer()
            
            Circle()
                .frame(width: 40, height: 40)
                .opacity(0)
            
        }
    }
    
    private var pinsView: some View {
        VStack(alignment: .leading) {
            Text("new_pin".localized)
                .font(.apply(.regular, size: 16))
                .foregroundStyle(Color.colorTextPrimary)
                .padding(.bottom, 8)
            
            HStack(spacing: 20) {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(lineWidth: 1)
                    .foregroundStyle(Color.colorBorder)
                    .frame(height: 56)
                    .overlay {
                        TextField("-", text: $newPinOne)
                            .modifier(OtpModifer(pin: $newPinOne))
                            .onChange(of: newPinOne) { newValue in
                                selectedPin = .newPinTwo
                            }
                            .focused($selectedPin, equals: .newPinOne)
                            .textContentType(.oneTimeCode)
                    }
                RoundedRectangle(cornerRadius: 16)
                    .stroke(lineWidth: 1)
                    .foregroundStyle(Color.colorBorder)
                    .frame(height: 56)
                    .overlay {
                        TextField("-", text: $newPinTwo)
                            .modifier(OtpModifer(pin: $newPinTwo))
                            .onChange(of: newPinTwo) { newValue in
                                selectedPin = .newPinThree
                            }
                            .focused($selectedPin, equals: .newPinTwo)
                            .textContentType(.oneTimeCode)
                    }
                RoundedRectangle(cornerRadius: 16)
                    .stroke(lineWidth: 1)
                    .foregroundStyle(Color.colorBorder)
                    .frame(height: 56)
                    .overlay {
                        TextField("-", text: $newPinThree)
                            .modifier(OtpModifer(pin: $newPinThree))
                            .onChange(of: newPinThree) { newValue in
                                selectedPin = .newPinFour
                            }
                            .focused($selectedPin, equals: .newPinThree)
                            .textContentType(.oneTimeCode)
                    }
                RoundedRectangle(cornerRadius: 16)
                    .stroke(lineWidth: 1)
                    .foregroundStyle(Color.colorBorder)
                    .frame(height: 56)
                    .overlay {
                        TextField("-", text: $newPinFour)
                            .modifier(OtpModifer(pin: $newPinFour))
                            .onChange(of: newPinFour) { newValue in
                                selectedPin = .confirmNewPinOne
                            }
                            .focused($selectedPin, equals: .newPinFour)
                            .textContentType(.oneTimeCode)
                    }
                
                RoundedRectangle(cornerRadius: 0).frame(height: 56).opacity(0)
                RoundedRectangle(cornerRadius: 0).frame(height: 56).opacity(0)
            }
            .padding(.bottom, 24)

            Text("confirm_new_pin".localized)
                .font(.apply(.regular, size: 16))
                .foregroundStyle(Color.colorTextPrimary)
                .padding(.bottom, 8)

            HStack(spacing: 20) {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(lineWidth: 1)
                    .foregroundStyle(Color.colorBorder)
                    .frame(height: 56)
                    .overlay {
                        TextField("-", text: $confirmNewPinOne)
                            .modifier(OtpModifer(pin: $confirmNewPinOne))
                            .onChange(of: confirmNewPinOne) { newValue in
                                selectedPin = .confirmNewPinTwo
                                
                            }
                            .focused($selectedPin, equals: .confirmNewPinOne)
                            .textContentType(.oneTimeCode)
                    }
                RoundedRectangle(cornerRadius: 16)
                    .stroke(lineWidth: 1)
                    .foregroundStyle(Color.colorBorder)
                    .frame(height: 56)
                    .overlay {
                        TextField("-", text: $confirmNewPinTwo)
                            .modifier(OtpModifer(pin: $confirmNewPinTwo))
                            .onChange(of: confirmNewPinTwo) { newValue in
                                selectedPin = .confirmNewPinThree
                            }
                            .focused($selectedPin, equals: .confirmNewPinTwo)
                            .textContentType(.oneTimeCode)
                    }
                RoundedRectangle(cornerRadius: 16)
                    .stroke(lineWidth: 1)
                    .foregroundStyle(Color.colorBorder)
                    .frame(height: 56)
                    .overlay {
                        TextField("-", text: $confirmNewPinThree)
                            .modifier(OtpModifer(pin: $confirmNewPinThree))
                            .onChange(of: confirmNewPinThree) { newValue in
                                selectedPin = .confirmNewPinFour
                            }
                            .focused($selectedPin, equals: .confirmNewPinThree)
                            .textContentType(.oneTimeCode)
                    }
                RoundedRectangle(cornerRadius: 16)
                    .stroke(lineWidth: 1)
                    .foregroundStyle(Color.colorBorder)
                    .frame(height: 56)
                    .overlay {
                        TextField("-", text: $confirmNewPinFour)
                            .modifier(OtpModifer(pin: $confirmNewPinFour))
                            .onChange(of: confirmNewPinFour) { newValue in
                                selectedPin = nil
                            }
                            .focused($selectedPin, equals: .confirmNewPinFour)
                            .textContentType(.oneTimeCode)
                    }
                
                RoundedRectangle(cornerRadius: 0).frame(height: 56).opacity(0)
                RoundedRectangle(cornerRadius: 0).frame(height: 56).opacity(0)
            }

        }
    }
    
    private var createPinView: some View {
        Text("create_pin".localized)
            .font(.apply(.bold, size: 18))
            .foregroundStyle(.white)
            .frame(height: 48)
            .frame(maxWidth: .infinity)
            .foregroundStyle(.white)
            .background(RoundedRectangle(cornerRadius: 16).fill(Color.colorPrimary).opacity(confirmNewPinFour.isEmpty == false && confirmPinMatching ? 1 : 0.5))
            .padding(.horizontal, 20)
            .onTapGesture {
                onCreatePin()
            }
        
    }

}
