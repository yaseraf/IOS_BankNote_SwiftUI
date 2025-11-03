//
//  CustomTextField.swift
//  QSC
//
//  Created by FIT on 23/07/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation
import SwiftUI
import FlagAndCountryCode

struct CustomTextField: View {
  

    private  var type:TextFieldViewType
    private var title:String
    private var inputValue:Binding<String>
   @State private var errorMsg:String = ""
    private var onTextAction: (( ValidationConstants.ValidationType? , String) -> Void)? = nil
    private var onCountryCodeTap: ((CountryFlagInfo?) -> Void)? = nil
    var countryCodeUIModel:Binding<CountryFlagInfo?>
    @State private var showError:Bool = false
    @State private var stateType:TextFieldStateType = .normal
    private var checkValidation:Binding<Bool>
    private var forceBorder:Binding<TextFieldStateType>? = nil
    private var height:CGFloat
    private var minHeight:CGFloat?
    var selectedSegment: Binding<Int>

    init(checkValidation:Binding<Bool> = .constant(false),type: TextFieldViewType, title: String,value:Binding<String>  = .constant(""),errorMsg:String = "" ,onTextAction: (( ValidationConstants.ValidationType?, String) -> Void)? = nil,onCountryCodeTap: ((CountryFlagInfo?) -> Void)? = nil,countryCodeUIModel:Binding<CountryFlagInfo?>,forceBorder:Binding<TextFieldStateType>? = nil, height:CGFloat = 54 ,minHeight:CGFloat? = nil, selectedSegment:Binding<Int> = .constant(0)) {
        self.checkValidation = checkValidation
        self.type = type
        self.title = title
        self.inputValue = value
        self.errorMsg = errorMsg
        self.onTextAction = onTextAction
        self.onCountryCodeTap = onCountryCodeTap
        self.countryCodeUIModel = countryCodeUIModel
        self.forceBorder = forceBorder
        self.height = height
        self.selectedSegment = .constant(0)
     }
    var body: some View {
        VStack(alignment: .leading){
            if type == .phoneNumber {
                inputViewPhoneNumber
            }else{
                inputViewDefault
            }

            if showError{
                errorView
            }

        }
    }


    private var errorView:some View{
        Text($errorMsg.wrappedValue)
            .foregroundStyle(Color.colorError)
            .font(.apply(size:13))
    }

    private  var inputViewDefault:some View {
        get{
            FloatingTextField(checkValidation:checkValidation,inputValue: inputValue.wrappedValue, placeholderText: title, filedType: type,onTextAction: {
                 error,newText in

//                debugPrint("errorMsg:\(errorMsg)")
//                debugPrint("newText:\(newText)")
                if errorMsg.isEmpty {
                    errorMsg = error?.description ?? ""
                }
                var completeText = newText
                if error == nil{
                        showError = false
                    if type == .phoneNumber && !newText.isEmpty{
                        completeText =  "\(countryCodeUIModel.wrappedValue?.dialCode ?? "")\(newText)"
                    }
                }else{
                        showError = true
                }

                DispatchQueue.main.async { onTextAction?( error,completeText) }

            },countryCodeUIModel:countryCodeUIModel.wrappedValue,forceBorder: forceBorder)
            .frame(maxWidth: .infinity)
            .frame(height: height)
            .frame(minHeight:minHeight)
        }
    }
    var inputViewPhoneNumber:some View {
        get{

            HStack(alignment: .center) {

                HStack(alignment: .center) {
                    countryCodeUIModel.wrappedValue?.getCountryImage(with: FlagType(rawValue: selectedSegment.wrappedValue) ?? .roundedRect)
                        .frame(width: 30)
//                    Image(countryCodeUIModel?.iconName ?? "").resizable()
//                        .frame(width: 32)
//                        .frame(height:  32)

                    Image("ic_downArrow").resizable()
                        .frame(width: 24)
                        .frame(height:  24)
                        .tint(Color.colorTextPlaceHolder)


                }
                .padding()
                .frame(height: 54)
                .background(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(forceBorder == nil ? stateType.borderColor : forceBorder!.wrappedValue.borderColor, lineWidth: 1)
                )
                .background(
                    RoundedRectangle(cornerRadius: 14)
                    .fill(Color.colorBGTertiary)
                )
                    .onTapGesture {
                        onCountryCodeTap?(countryCodeUIModel.wrappedValue)
                }

                inputViewDefault
                    .frame(maxWidth: .infinity)


            }
            .onTapGesture {
            }

        }
    }



}



#Preview {
    Group {

//        CustomTextField(type: .email, title: "EMAIL", value: "mhmathkour@gmail.com")
//        CustomTextField(type: .password, title: "password",value: "mhmathkour@gmail.com")
//        CustomTextField(type: .phoneNumber, title: "phoneNumber",value: "5432120")

    }

}


struct FloatingTextField: View {
    @State private var inputValue: String
    @State private var isEndEditing:Bool = false

    let placeholderText: String

    let animation: Animation = .spring(response: 0.1, dampingFraction: 0.6)



    //    @State private var scaleEffectValue: CGFloat = 1
    @State private var isSecure:Bool

    private var filedType:TextFieldViewType

    private var onTextAction: (( ValidationConstants.ValidationType? , String) -> Void)? = nil
    private var countryCodeUIModel:CountryFlagInfo?
    @State private var showError:Bool = false
    @State private var stateType:TextFieldStateType = .normal
    private var checkValidation:Binding<Bool>
    private var forceBorder:Binding<TextFieldStateType>? = nil

    init(checkValidation:Binding<Bool> = .constant(true),inputValue:String,placeholderText: String, filedType:TextFieldViewType, onTextAction: ((ValidationConstants.ValidationType? , String) -> Void)? = nil,countryCodeUIModel:CountryFlagInfo? = nil,forceBorder:Binding<TextFieldStateType>? ) {

        self.checkValidation = checkValidation

        self.countryCodeUIModel = countryCodeUIModel
        self.inputValue = inputValue
        self.placeholderText = placeholderText
        self.onTextAction = onTextAction
        self.filedType = filedType
        self.forceBorder = forceBorder
        self.isSecure = filedType == .password

    }


    func getPlaceHolderOffsetValue(text:String) -> CGFloat {
        if filedType == .phoneNumber{
            return -25
        }
        return text.isEmpty ? 0 : -25
    }

    func getScaleEffectValue(text:String) -> CGFloat {
        if filedType == .phoneNumber{
            return 0.75
        }
        return text.isEmpty ? 1 : 0.75
    }

    func getFont(text:String) -> Font {
        if filedType == .phoneNumber{
            return  Font.apply(size:12)
        }
        return text.isEmpty ? Font.apply(size: 17) : Font.apply(size:12)
    }

    var body: some View {
        var placeholderOffset: CGFloat {
            get{
                getPlaceHolderOffsetValue(text: $inputValue.wrappedValue)
            }
        }

        var scaleEffectValue: CGFloat {
            get{
                getScaleEffectValue(text: $inputValue.wrappedValue)
            }
        }

        ZStack(alignment: .leading) {
            Text(placeholderText)
                .foregroundStyle( Color.colorTextPlaceHolder)
                .font(getFont(text: $inputValue.wrappedValue))
                .offset(y:  placeholderOffset)
                .scaleEffect(scaleEffectValue, anchor: .leading)

            HStack(alignment:.center){
                if filedType == .phoneNumber{
                    Text(countryCodeUIModel?.dialCode ?? "" )
                }
                
                CustomInput(isSecure: $isSecure, text: $inputValue, placeholder: "", filedType: filedType, keyboardType: getKeyboardType(), onTextFieldDidBeginEditing: {
                        stateType = .active
                        validateAction(text: inputValue)

                }, onTextFieldDidEndEditing: {
                    validateAction(text: inputValue)
                    if stateType != .error{
                        stateType = .normal
                    }

                }, onTextChange: { (lastChar: String, textAfter: String) in
                    
                    // Put logic to only trim for only .pinNumber
                    if textAfter.count > 4 && filedType == .pinNumber{
                        inputValue = String(textAfter.prefix(4))
                        debugPrint("Text after trimming: \(inputValue)")
                    } else {
                        inputValue = textAfter
                    }

                    validateAction(text: inputValue)
                })


                if filedType == .password{
                    Button(action: {
                        isSecure.toggle()
                    }, label: {
                        Image(isSecure ? "icEyeOn" : "icEyeOff" )
                            .resizable()
                            .frame(width:16)
                            .frame(height:16)
                    })


                }
            }


        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 14)
                .stroke(forceBorder == nil ? stateType.borderColor : forceBorder!.wrappedValue.borderColor, lineWidth: 1)
        )
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color.colorBGTertiary)
        )
//        .cornerRadius(14)


    }


    private func validateAction(text:String){
        do {

            let textValue:String
            if checkValidation.wrappedValue{
                 textValue = try validateField(text: text)
            }else{
                 textValue = text
            }

            showError = false
            stateType = .active
            DispatchQueue.main.async { onTextAction?( nil,textValue) }


        }catch{
            showError = true
            let error = error as?  ValidationConstants.ValidationType
            stateType = .error

            DispatchQueue.main.async { onTextAction?( error,"") }

        }

    }

    private func validateField(text:String) throws -> String {
        if text.isEmpty{
            return text
        }
        switch filedType {
        case .number:
            if text.isOnlyNumber{
                return text
            }
            throw  NetworkError.custom(error: "")

        case .name:
            return try AppValidation.shared.isTextValid(text)
        case .email:
            return try AppValidation.shared.isEmail(text)
        case .phoneNumber:
            return try AppValidation.shared.phoneNumberValidate(text, countryUIModel: countryCodeUIModel ?? AppConstants.defaultSaudiCountry)
        case .password:
            return try AppValidation.shared.isValidPassword(text)
        case .pinNumber:
            if text.isOnlyNumber, text.count <= 4 {
                return text
            }
            throw NetworkError.custom(error: "Pin must be 4 digits.")
        }

    }




    func getKeyboardType() -> UIKeyboardType{
        switch filedType {
        case .name:
                .namePhonePad
        case .email:
                .emailAddress
        case .phoneNumber:
                .asciiCapableNumberPad
        case .password:
                .default
        case .number:
                .decimalPad
        case .pinNumber:
                .asciiCapableNumberPad
        }
    }



    struct TextfieldModifier: ViewModifier {

        func body(content: Content) -> some View {
           content .font(.apply(.bold,size: 17))
                .foregroundStyle(Color.colorTextPrimary)
        }
    }


}

//extension FloatingTextField {
//    public func onTextChange(_ onTextAction: (( ,_ newValue : String) -> ())?) -> Self {
//        var view = self
//        view.onTextAction = onTextAction
//        return view
//    }
//}
