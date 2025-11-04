//
//  VerifySignUpContentView.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 15/09/2025.
//

import Foundation
import SwiftUI


struct VerifySignUpContentView: View {
    
    enum FocusPin {
        case pinOne
        case pinTwo
        case pinThree
        case pinFour
        case pinFive
        case pinSix
    }
    
    @FocusState var selectedPin:FocusPin?
    @State var pinOne:String = ""
    @State var pinTwo:String = ""
    @State var pinThree:String = ""
    @State var pinFour:String = ""
    @State var pinFive:String = ""
    @State var pinSix:String = ""

        
    var verificationType:Binding<VerificationType>
    var timerObserve:Binding<(Int, String)?>
    var isVLens:Binding<Bool>
    var phone:Binding<String>
    var email:Binding<String>
    var pin:Binding<String>
    var onBack:()->Void
    var onContinueTap:(String, Bool, Bool)->Void
    var onResendOtpTap:(Bool)->Void
    
    var body: some View {
        ZStack {
            VStack {
                       
                headerView
                
                logoView
                
                titleView
                
                pinsView
//                PinFieldView(pin: pin)
                
                bottomView
                
                Spacer()
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
        }
    }
    
    private var headerView: some View {
        HStack {
            Button {
                onBack()
            } label: {
                Image("ic_leftArrow")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 45, maxHeight: 45)
            }
            
            Spacer()
        }
    }
    
    private var titleView: some View {
        VStack {
            Text("enter_code".localized)
                .font(.cairoFont(.semiBold, size: 18))
            Text("\("enter_the_6_digit_verification_code_we_sent_to".localized) \(verificationType.wrappedValue == .phone ? phone.wrappedValue : email.wrappedValue)")
                .font(.cairoFont(.light, size: 12))
                .padding(.horizontal, 38)
                .multilineTextAlignment(.center)
            
        }
        .frame(maxWidth: .infinity)
    }
    
    private var pinsView: some View {
        HStack(spacing: 8) {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(hex: "#DDDDDD")).shadow(color: .black, radius: 0.3, x: 0, y: 1)
                .frame(width: 41, height: 50)
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
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(hex: "#DDDDDD")).shadow(color: .black, radius: 0.3, x: 0, y: 1)
                .frame(width: 41, height: 50)
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
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(hex: "#DDDDDD")).shadow(color: .black, radius: 0.3, x: 0, y: 1)
                .frame(width: 41, height: 50)
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
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(hex: "#DDDDDD")).shadow(color: .black, radius: 0.3, x: 0, y: 1)
                .frame(width: 41, height: 50)
                .overlay {
                    TextField("-", text: $pinFour)
                        .modifier(OtpModifer(pin: $pinFour))
                        .onChange(of: pinFour) { newValue in
                            if newValue.isEmpty {
                                selectedPin = .pinThree
                            } else if newValue.count == 1 {
                                selectedPin = .pinFive
                            }
                        }
                        .focused($selectedPin, equals: .pinFour)
                        .textContentType(.oneTimeCode)
                }
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(hex: "#DDDDDD")).shadow(color: .black, radius: 0.3, x: 0, y: 1)
                .frame(width: 41, height: 50)
                .overlay {
                    TextField("-", text: $pinFive)
                        .modifier(OtpModifer(pin: $pinFive))
                        .onChange(of: pinFive) { newValue in
                            if newValue.isEmpty {
                                selectedPin = .pinFour
                            } else if newValue.count == 1 {
                                selectedPin = .pinSix
                            }
                        }
                        .focused($selectedPin, equals: .pinFive)
                        .textContentType(.oneTimeCode)
                }
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(hex: "#DDDDDD")).shadow(color: .black, radius: 0.3, x: 0, y: 1)
                .frame(width: 41, height: 50)
                .overlay {
                    TextField("-", text: $pinSix)
                        .modifier(OtpModifer(pin: $pinSix))
                        .onChange(of: pinSix) { newValue in
                            if newValue.isEmpty {
                                selectedPin = .pinFive
                            } else {
                                selectedPin = nil // dismiss focus at last digit
                            }
                        }
                        .focused($selectedPin, equals: .pinSix)
                        .textContentType(.oneTimeCode)
                }
        }
        .padding(.horizontal, 53)
        .padding(.bottom, 52)
    }

    
    private var bottomView: some View {
        let timeInt = timerObserve.wrappedValue?.0 ?? 0

        var resentAttribute: AttributedString {
            var str = AttributedString(timeInt > 0 ? "\("resend_link".localized) in \(timeInt)" : "click_to_resend_otp".localized)
            str.underlineStyle = .single
            return str
        }
        

        return VStack {
            Button {
                onContinueTap(pinOne+pinTwo+pinThree+pinFour+pinFive+pinSix, verificationType.wrappedValue == .email ? true : false, isVLens.wrappedValue)
            } label: {
                Text("confirm".localized)
                    .font(.cairoFont(.semiBold, size: 18))
                    .foregroundStyle(.white)
                    .frame(minWidth: 357, minHeight: 51)
                    .background(RoundedRectangle(cornerRadius: 99).fill(Color.colorPrimary))
            }
        
            Spacer().frame(height: 24)
            
            Button {
                onResendOtpTap(verificationType.wrappedValue == .email ? true : false)
            } label: {
                Text(resentAttribute)
                    .font(.cairoFont(.semiBold, size: 14))
                    .foregroundStyle(Color(hex: "#828282"))
            }
            .disabled(timeInt > 0)
            
            Spacer().frame(height: 34)
            
        }
    }
}

struct PinFieldView: View {
    let pinCount = 6
    var pin:Binding<String>
    @FocusState private var focusedField: Int?

    var body: some View {
        HStack(spacing: 12) {
            ForEach(0..<pinCount, id: \.self) { index in
                VStack {
                    TextField("", text: bindingForIndex(index))
                        .font(.largeTitle)
                        .multilineTextAlignment(.center)
                        .keyboardType(.numberPad)
                        .frame(width: 41, height: 50)
                        .background(RoundedRectangle(cornerRadius: 8).fill(Color(hex: "#DDDDDD")).shadow(color: .black, radius: 0.3, x: 0, y: 1))
                        .focused($focusedField, equals: index)
                        .tag(index) // Add a tag to ensure the view is uniquely identifiable
                        .textContentType(.oneTimeCode)

                    // This is to hide the actual text field and show a dash if needed
                    .overlay(
                        Text(characterForIndex(index))
                            .font(.cairoFont(.semiBold, size: 20))
                            .opacity(pin.wrappedValue.count > index ? 0 : 1)
                            .padding(.top, 12)
                    )
                }
            }
        }
        .padding()
        .onAppear {
            focusedField = 0 // Focus on the first field when the view appears
        }
        .onChange(of: pin.wrappedValue) { newValue in
            // Only allow up to pinCount digits
            if newValue.count > pinCount {
                pin.wrappedValue = String(newValue.prefix(pinCount))
            }
            
            let newCount = pin.wrappedValue.count
            
            if newCount < pinCount {
                focusedField = newCount
            } else {
                focusedField = nil // dismiss keyboard
            }
        }
    }


    // A helper function to get the character for a specific index
    func characterForIndex(_ index: Int) -> String {
        guard index < pin.wrappedValue.count else { return "-" }
        return String(pin.wrappedValue[pin.wrappedValue.index(pin.wrappedValue.startIndex, offsetBy: index)])
    }

    // A binding to update a single character in the pin string
    func bindingForIndex(_ index: Int) -> Binding<String> {
        Binding(
            get: {
                if index < pin.wrappedValue.count {
                    return String(pin.wrappedValue[pin.wrappedValue.index(pin.wrappedValue.startIndex, offsetBy: index)])
                } else {
                    return ""
                }
            },
            set: { newChar in
                if newChar.isEmpty {
                    // Backspace handling
                    if index < pin.wrappedValue.count {
                        let removeIndex = pin.wrappedValue.index(pin.wrappedValue.startIndex, offsetBy: index)
                        pin.wrappedValue.remove(at: removeIndex)
                    }
                } else if let char = newChar.last, char.isNumber {
                    // Replace or append digit
                    if index < pin.wrappedValue.count {
                        let startIndex = pin.wrappedValue.index(pin.wrappedValue.startIndex, offsetBy: index)
                        let endIndex = pin.wrappedValue.index(after: startIndex)
                        pin.wrappedValue.replaceSubrange(startIndex..<endIndex, with: String(char))
                    } else {
                        pin.wrappedValue.append(char)
                    }
                }
            }
        )
    }
}



#Preview {
    VerifySignUpContentView(verificationType: .constant(.email), timerObserve: .constant((1,"1")), isVLens: .constant(false), phone: .constant(""), email: .constant(""), pin: .constant(""), onBack: {
        
    }, onContinueTap: {_,_,_ in
        
    }, onResendOtpTap: { _ in
        
    })
}
