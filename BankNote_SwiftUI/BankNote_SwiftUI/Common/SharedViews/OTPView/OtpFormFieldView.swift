//
//  OtpFormFieldView.swift
//  QSC
//
//  Created by FIT on 04/08/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import SwiftUI
import Combine
import SwiftUI
import Combine

struct OtpFormFieldView: View {
    //MARK -> PROPERTIES

    enum FocusPin {
        case  pinOne, pinTwo, pinThree, pinFour, pinFive ,pinSixth
    }

    @FocusState private var pinFocusState : FocusPin?
    @State var pinOne: String = ""
    @State var pinTwo: String = ""
    @State var pinThree: String = ""
    @State var pinFour: String = ""
    @State var pinFive: String = ""
    @State var pinSixth: String = ""
    private let emptyValue = "-"
    private var onOtpEntered:((String)->Void)? = nil
    
    @State var hasAutoFilled: Bool = false



    init(onOtpEntered:((String)->Void)? = nil) {
        self.onOtpEntered = onOtpEntered
    }
    private func calculateOTPValue() {
        let string = ("\(pinOne)\(pinTwo)\(pinThree)\(pinFour)\(pinFive)\(pinSixth)")
        onOtpEntered?(string)
    }
    
    private func fillAllFields(with otp: String) {
        let otpArray = Array(otp.prefix(6)) // Ensure only 6 digits
        if otpArray.count == 6 {
            pinOne = String(otpArray[0])
            pinTwo = String(otpArray[1])
            pinThree = String(otpArray[2])
            pinFour = String(otpArray[3])
            pinFive = String(otpArray[4])
            pinSixth = String(otpArray[5])
            hasAutoFilled = true
//            hideKeyboard()

        }
    }


    //MARK -> BODY
    var body: some View {
            VStack {

                HStack(spacing:0, content: {

                    TextField("", text: $pinOne,prompt: promptView )
                        .modifier(OtpModifer(pin:$pinOne))
                        .onChange(of:pinOne){newVal in
                            if newVal.count > 1 {
                                       fillAllFields(with: newVal)
                                
                                   } else if checkNextValue(newVal: newVal) {
                                       if hasAutoFilled {
                                           pinFocusState = .pinSixth
                                           hideKeyboard()
                                       } else {
                                           pinFocusState = .pinTwo
                                       }
                                   }
                            calculateOTPValue()
                        }
                        .focused($pinFocusState, equals: .pinOne)
                        .textContentType(.oneTimeCode)
                        

                    TextField("", text:  $pinTwo,prompt: promptView )
                        .modifier(OtpModifer(pin:$pinTwo))
                        .onChange(of:pinTwo){newVal in
                            if (checkNextValue(newVal: newVal)) {
                                pinFocusState = .pinThree
                            }else {
                                if (checkPrevValue(newVal: newVal)) {
                                    pinFocusState = .pinOne
                                }
                            }
                            calculateOTPValue()

                        }
                        .focused($pinFocusState, equals: .pinTwo)
                        .textContentType(.oneTimeCode)


                    TextField("", text:$pinThree,prompt: promptView )
                        .modifier(OtpModifer(pin:$pinThree))
                        .onChange(of:pinThree){newVal in
                            if (checkNextValue(newVal: newVal)) {
                                pinFocusState = .pinFour
                            }else {
                                if (checkPrevValue(newVal: newVal)) {
                                    pinFocusState = .pinTwo
                                }
                            }
                            calculateOTPValue()

                        }
                        .focused($pinFocusState, equals: .pinThree)
                        .textContentType(.oneTimeCode)


                    TextField("", text:$pinFour,prompt: promptView )
                        .modifier(OtpModifer(pin:$pinFour))
                        .onChange(of:pinFour){newVal in

                            if (checkNextValue(newVal: newVal)) {
                                pinFocusState = .pinFive
                            }else {
                                if (checkPrevValue(newVal: newVal)) {
                                    pinFocusState = .pinThree
                                }
                            }
                            calculateOTPValue()

                        }
                        .focused($pinFocusState, equals: .pinFour)
                        .textContentType(.oneTimeCode)


                    TextField("", text:$pinFive,prompt: promptView )
                        .modifier(OtpModifer(pin:$pinFive))
                        .onChange(of:pinFive){newVal in
                            if (checkNextValue(newVal: newVal)) {
                                pinFocusState = .pinSixth
                            }else {
                                if (checkPrevValue(newVal: newVal)) {
                                    pinFocusState = .pinFour
                                }
                            }
                            calculateOTPValue()

                        }
                        .focused($pinFocusState, equals: .pinFive)
                        .textContentType(.oneTimeCode)

                    TextField("", text:$pinSixth,prompt: promptView )
                        .modifier(OtpModifer(pin:$pinSixth))
                        .onChange(of:pinSixth){newVal in
                            if (checkPrevValue(newVal: newVal)) {
                                pinFocusState = .pinFive
                            }else{
                                hideKeyboard()

                            }
                            calculateOTPValue()
                        }
                        .focused($pinFocusState, equals: .pinSixth)
                        .textContentType(.oneTimeCode)

                })
                .background(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color.colorPrimary, lineWidth: 1)
                        .foregroundColor(Color.colorBGTertiary)
                )
                .onTapGesture {
//                    pinFocusState = .pinOne
                    hasAutoFilled = false
                }


            }

    }

    private var promptView: Text {
        get{
            Text(emptyValue.localized)
                .font(.apply(size: 28))
                .foregroundColor(.colorTextPrimary)

        }
    }

    private func checkNextValue(newVal:String) ->Bool{
        return newVal.count == 1
    }

    private func checkPrevValue(newVal:String) ->Bool{
        return newVal.count == 0
    }


}

struct OtpFormFieldView_Previews: PreviewProvider {
    static var previews: some View {
        OtpFormFieldView( )
    }
}
