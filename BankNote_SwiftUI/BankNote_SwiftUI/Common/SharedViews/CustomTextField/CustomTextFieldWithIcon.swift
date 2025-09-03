//
//  CustomTextField.swift
//  QSC
//
//  Created by FIT on 23/07/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation
import SwiftUI
struct CustomTextFieldWithIcon: View {
    enum TextFieldViewType{
        case name
        case number

    }

    private  var type:CustomTextFieldWithIcon.TextFieldViewType
    private var title:String
    private var iconName:String
    @Binding private var inputValue:String
   @State private var errorMsg:String = ""
    private var onTextAction: (( ValidationConstants.ValidationType? , String) -> Void)? = nil
    @State private var showError:Bool = false
    @State private var stateType:TextFieldStateType = .normal
    private var checkValidation:Binding<Bool>
    private var forceBorder:Binding<TextFieldStateType>? = nil
    var onCopyButton:((String)->Void)

    init(checkValidation:Binding<Bool> = .constant(true),type: CustomTextFieldWithIcon.TextFieldViewType = .name, iconName:String,title: String,value:Binding<String>  = .constant(""),errorMsg:String = "" ,onTextAction: (( ValidationConstants.ValidationType?, String) -> Void)? = nil,forceBorder:Binding<TextFieldStateType>? = nil, onCopyButton: @escaping (String) -> Void) {
        self.checkValidation = checkValidation
        self.type = type
        self.title = title
        self.iconName = iconName
        self._inputValue = value
        self.errorMsg = errorMsg
        self.onTextAction = onTextAction
        self.forceBorder = forceBorder
        self.onCopyButton = onCopyButton
     }
    var body: some View {
        VStack(alignment: .leading){

                inputViewDefault

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
            FloatingTextFieldWithIcon(checkValidation:checkValidation, imageNameValue: iconName,inputValue: $inputValue, placeholderText: title, filedType: type,onTextAction: {
                 error,newText in

                debugPrint("errorMsg:\(errorMsg)")
                debugPrint("newText:\(newText)")
                if errorMsg.isEmpty {
                    errorMsg = error?.description ?? ""
                }
                var completeText = newText
                if error == nil{
                        showError = false

                }else{
                        showError = true
                }

                DispatchQueue.main.async { onTextAction?( error,completeText) }

            },forceBorder: forceBorder, onCopyButton: onCopyButton)
            .frame(maxWidth: .infinity)
            .frame(height: 54)
        }
    }



}




struct FloatingTextFieldWithIcon: View {
    
    @State private var localInputValue: String = ""
    @Binding private var inputValue: String
    @State private var isEndEditing:Bool = false

    let placeholderText: String
    let imageNameValue: String

    let animation: Animation = .spring(response: 0.1, dampingFraction: 0.6)



    //    @State private var scaleEffectValue: CGFloat = 1

    private var filedType:CustomTextFieldWithIcon.TextFieldViewType

    private var onTextAction: (( ValidationConstants.ValidationType? , String) -> Void)? = nil
    @State private var showError:Bool = false
    @State private var stateType:TextFieldStateType = .normal
    private var checkValidation:Binding<Bool>
    private var forceBorder:Binding<TextFieldStateType>? = nil
    var onCopyButton:((String)->Void)

    init(checkValidation:Binding<Bool> = .constant(true),imageNameValue:String,inputValue:Binding<String>,placeholderText: String, filedType:CustomTextFieldWithIcon.TextFieldViewType, onTextAction: ((ValidationConstants.ValidationType? , String) -> Void)? = nil,forceBorder:Binding<TextFieldStateType>?, onCopyButton: @escaping (String) -> Void) {

        self.imageNameValue = imageNameValue
        self.checkValidation = checkValidation
        self._inputValue = inputValue
        self.placeholderText = placeholderText
        self.onTextAction = onTextAction
        self.filedType = filedType
        self.forceBorder = forceBorder
        self.onCopyButton = onCopyButton

    }


    func getPlaceHolderOffsetValue(text:String) -> CGFloat {

        return text.isEmpty ? 0 : -25
    }

    func getScaleEffectValue(text:String) -> CGFloat {

        return text.isEmpty ? 1 : 0.75
    }

    func getFont(text:String) -> Font {

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

                
                CustomInput(isSecure: .constant(false), text: $inputValue, placeholder: "", filedType: .name, keyboardType: getKeyboardType(), onTextFieldDidBeginEditing: {
                        stateType = .active
                        validateAction(text: inputValue)

                }, onTextFieldDidEndEditing: {
                    validateAction(text: inputValue)
                    if stateType != .error{
                        stateType = .normal
                    }

                }, onTextChange: { (lastChar: String, textAfter: String) in
                    localInputValue = textAfter
                        DispatchQueue.main.async {
                            inputValue = textAfter  // Now updates inputValue asynchronously, avoiding the SwiftUI warning
//                            validateAction(text: textAfter)
                        }
                }).disabled(true)


                    Button(action: {
                        onCopyButton(inputValue)
                    }, label: {
                        Image(imageNameValue)
                            .resizable()
                            .frame(width:20)
                            .frame(height:20)
                    })


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
            DispatchQueue.main.async {  onTextAction?( nil,textValue) }




        }catch{
            showError = true
            let error = error as?  ValidationConstants.ValidationType
            stateType = .error

            DispatchQueue.main.async {onTextAction?( error,"") }

        }

    }

    private func validateField(text:String) throws -> String {
        if text.isEmpty{
            return text
        }
        switch filedType {
        case .name:
            return try AppValidation.shared.isTextValid(text)
        case .number:
            if text.isOnlyNumber{
                return text
            }
            throw  NetworkError.custom(error: "")

        }

    }




    func getKeyboardType() -> UIKeyboardType{
        switch filedType {
        case .name:
                .namePhonePad

        case .number:
                .asciiCapableNumberPad

        }
    }




}
