//
//  CustomInput.swift
//  QSC
//
//  Created by FIT on 12/08/2024.
//  Copyright © 2024 FIT. All rights reserved.
//


import SwiftUI
import Lottie
struct CustomInput:UIViewRepresentable{
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    private var isSecure: Binding<Bool>
 private var text: Binding<String>
    private var placeholder: String

    private var filedType: TextFieldViewType
    private var keyboardType:UIKeyboardType

    private var onTextFieldDidBeginEditing:(()->Void)
    private var onTextFieldDidEndEditing:(()->Void)
    private var onTextChange:(((lastChar:String,textAfter:String))->Void)

    init(isSecure:Binding<Bool> = .constant(false),text: Binding<String>,placeholder: String, filedType: TextFieldViewType, keyboardType: UIKeyboardType, onTextFieldDidBeginEditing: @escaping () -> Void, onTextFieldDidEndEditing: @escaping () -> Void,  onTextChange: @escaping ((lastChar:String,textAfter:String)) -> Void) {
        self.isSecure = isSecure
        self.text = text
        self.placeholder = placeholder
        self.filedType = filedType
        self.keyboardType = keyboardType
        self.onTextFieldDidBeginEditing = onTextFieldDidBeginEditing
        self.onTextFieldDidEndEditing = onTextFieldDidEndEditing
        self.onTextChange = onTextChange
        
    }



    func makeUIView(context: UIViewRepresentableContext<CustomInput>) -> UITextField {

        let textField = UITextField(frame: .zero)
        textField.frame = .zero
        textField.text = text.wrappedValue
        textField.placeholder = placeholder
        textField.keyboardType = keyboardType
        textField.delegate = context.coordinator
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = AppUtility.shared.isRTL ? .right : .left
        textField.autocorrectionType = .no
        
        return textField
    }
    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<CustomInput>) {
        uiView.text = text.wrappedValue
        uiView.isSecureTextEntry = isSecure.wrappedValue

    }

    final class Coordinator: NSObject, UITextFieldDelegate {
        var parent: CustomInput

        init(parent: CustomInput) {
            self.parent = parent
        }

        func textFieldDidBeginEditing(_ textField: UITextField) {
            parent.onTextFieldDidBeginEditing()
        }

        func textFieldDidEndEditing(_ textField: UITextField) {
            parent.onTextFieldDidEndEditing()
        }
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if let text = textField.text,let textRange = Range(range, in: text) {

                if self.parent.filedType == .pinNumber {
                    let updatedText = text.replacingCharacters(in: textRange, with: string)
                            
                            // Trim the updated text to 4 characters
                            let trimmedText = String(updatedText.prefix(4))
                            
                            // Update the UITextField's text directly
                            textField.text = trimmedText
                            
                            // Call the onTextChange closure with the trimmed text
                            parent.onTextChange((lastChar: string, textAfter: trimmedText))
                            
                            // Update the Binding value
                            parent.text.wrappedValue = trimmedText
                            
                            // Return false to prevent UITextField from appending untrimmed text
                            return false
                } else {
                    let updatedText = text.replacingCharacters(in: textRange, with: string)
                    parent.onTextChange((lastChar:string,textAfter:updatedText))
                    parent.text =  .constant(updatedText)
                }
                
                return true

            }
            return false
        }

    }
}
