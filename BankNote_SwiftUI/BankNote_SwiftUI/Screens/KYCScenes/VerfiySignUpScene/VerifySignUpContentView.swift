//
//  VerifySignUpContentView.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 15/09/2025.
//

import Foundation
import SwiftUI


struct VerifySignUpContentView: View {
        
    var verificationType:Binding<VerificationType>
    var phone:Binding<String>
    var email:Binding<String>
    var onBack:()->Void
    var onContinueTap:()->Void
    
    var body: some View {
        ZStack {
            VStack {
                                            
                logoView
                
                titleView
                
                PinFieldView()
                
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
            Image("ic_close")
                .resizable()
                .scaledToFit()
                .frame(width: 38, height: 38)
                .onTapGesture {
                    onBack()
                }
            Spacer()
        }
        .padding(.horizontal, 18)
    }
    
    private var titleView: some View {
        VStack {
            Text("enter_code".localized)
                .font(.cairoFont(.semiBold, size: 18))
            Text("\("enter_the_6_digit_verification_code_we_sent_to".localized) \(verificationType.wrappedValue == .phone ? phone.wrappedValue : email.wrappedValue)")
                .font(.cairoFont(.light, size: 12))
                .padding(.horizontal, 77)
                .multilineTextAlignment(.center)
            
        }
    }
    
    private var bottomView: some View {
        
        var resentAttribute: AttributedString {
            var str = AttributedString("\("resend_link".localized) in 02:41")
            str.underlineStyle = .single
            return str
        }

        return VStack {
            Button {
                onContinueTap()
            } label: {
                Text("confirm".localized)
                    .font(.cairoFont(.semiBold, size: 18))
                    .foregroundStyle(.white)
                    .frame(minWidth: 357, minHeight: 51)
                    .background(RoundedRectangle(cornerRadius: 99).fill(Color.colorPrimary))
            }
            
            Spacer().frame(height: 24)
            
            Button {

            } label: {
                Text(resentAttribute)
                    .font(.cairoFont(.semiBold, size: 14))
                    .foregroundStyle(Color(hex: "#828282"))
            }
            
            Spacer().frame(height: 34)
            
        }
    }
}

struct PinFieldView: View {
    let pinCount = 6
    @State private var pin: String = ""
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

                    // This is to hide the actual text field and show a dash if needed
                    .overlay(
                        Text(characterForIndex(index))
                            .font(.cairoFont(.semiBold, size: 20))
                            .opacity(pin.count > index ? 0 : 1)
                            .padding(.top, 12)
                    )
                }
            }
        }
        .padding()
        .onAppear {
            focusedField = 0 // Focus on the first field when the view appears
        }
        .onChange(of: pin) { newValue in
            let newPinCount = newValue.count
            if newPinCount < pinCount {
                // Move focus to the next field if a digit was added
                focusedField = newPinCount
            } else if newPinCount == pinCount {
                // Dismiss the keyboard if all digits are entered
                focusedField = nil
            }
        }
    }

    // A helper function to get the character for a specific index
    func characterForIndex(_ index: Int) -> String {
        guard index < pin.count else { return "-" }
        return String(pin[pin.index(pin.startIndex, offsetBy: index)])
    }

    // A binding to update a single character in the pin string
    func bindingForIndex(_ index: Int) -> Binding<String> {
        Binding(
            get: {
                if index < pin.count {
                    return String(pin[pin.index(pin.startIndex, offsetBy: index)])
                } else {
                    return ""
                }
            },
            set: { newChar in
                if newChar.count == 1 {
                    if pin.count <= index {
                        pin += newChar
                    } else {
                        let startIndex = pin.index(pin.startIndex, offsetBy: index)
                        let endIndex = pin.index(startIndex, offsetBy: 1)
                        pin.replaceSubrange(startIndex..<endIndex, with: newChar)
                    }
                } else if newChar.isEmpty {
                    if pin.count > index {
                        let startIndex = pin.index(pin.startIndex, offsetBy: index)
                        pin.remove(at: startIndex)
                    }
                }
            }
        )
    }
}



#Preview {
    VerifySignUpContentView(verificationType: .constant(.email), phone: .constant(""), email: .constant(""), onBack: {
        
    }, onContinueTap: {
        
    })
}
