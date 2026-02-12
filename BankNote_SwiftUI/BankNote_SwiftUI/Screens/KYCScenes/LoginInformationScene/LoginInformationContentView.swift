//
//  LoginInformationContentView.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 15/09/2025.
//

import Foundation
import SwiftUI

struct LoginInformationContentView: View {
    enum FocusPassword {
        case  newPassword, confirmPassword
    }
    var listPasswordValidation: Binding<[PasswordValidationType:ChangePasswordUIModel]>
    var onPasswordTextChange: ((String)-> Void)
    var onBack:()->Void

    @State var stepNumber:Int = 2
    @State private var username = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @FocusState private var pinFocusState : FocusPassword?
    @State var continueAttempted: Bool = false
    @State var showPasswordCheckView: Bool = false
    @State var errorPasswordNotMatch:Bool = false
    @State private var enableBtn:Bool = false

    var isUsernameValid: Bool {
        // A simple validation rule
        return username.count > 3
    }

    var isPasswordValid: Bool {
        // A simple validation rule
        return password.count > 7
    }

    var doPasswordsMatch: Bool {
        return password == confirmPassword && password.count > 0
    }

    
    var onContinueTap:((_ username: String, _ password: String)->Void)?

    var body: some View {
        VStack {
            
            headerView
            
            logoView
            
            segmentsView
            
            contentView
                        
            Spacer()
            
            bottomView
                        
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
    
    private var logoView: some View {
        VStack(spacing: 0) {
            Image("ic_logo")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 225, maxHeight: 225)
            
            Text("XNTRQ".localized)
                .textCase(.uppercase)
                .font(.cairoFont(.extraBold, size: 40))
        }
    }
    
    private var segmentsView: some View {
        HStack(spacing: 4) {
            ForEach(0...5, id: \.self) { index in
                if stepNumber > index {
                    LinearGradient( gradient: Gradient(colors: [Color(hex: "#FC814B"), Color(hex: "#9C4EF7"), Color(hex: "#629AF9")]), startPoint: .leading, endPoint: .trailing)
                    
                        .cornerRadius(12)
                } else {
                    RoundedRectangle(cornerRadius: 12).fill(Color(hex: "#DDDDDD"))
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 6)
        .padding(.horizontal, 18)
    }
    
    private var contentView: some View {
        VStack {
            Text("register_information".localized)
                .font(.cairoFont(.semiBold, size: 18))
            
            Text("you_will_use_these_details_to_register_your_account".localized)
                .font(.cairoFont(.light ,size: 12))
            
            
            fieldsView
            
//            HStack(spacing: 8) {
//                Button(action: {
//
//                }, label: {
//                    HStack {
//                        Text("nationality".localized)
//                            .font(.cairoFont(.semiBold, size: 12))
//                        
//                        Spacer()
//                        
//                        Image("ic_downArrow")
//                            .renderingMode(.template)
//                            .resizable()
//                            .scaledToFit()
//                            .foregroundStyle(Color(hex: "#9C4EF7"))
//                            .frame(width: 15, height: 15)
//                    }
//                    .foregroundStyle(Color(hex: "#1C1C1C"))
//                    .padding(.horizontal, 16)
//                    .frame(height: 56)
//                    .background(RoundedRectangle(cornerRadius: 8).fill(Color(hex: "#DDDDDD")).shadow(color: .black, radius: 0.3, x: 0, y: 1))
//                    .padding(.bottom, 24)
//                })
//            }
//            .padding(.horizontal, 18)
        }
    }
    
    private var fieldsView: some View {
        VStack(spacing: 20) {
            InputField(
                title: "phone_number",
                text: .constant(KeyChainController().phoneNumberEntered ?? ""),
                isValid: isUsernameValid,
                onTextAction: { text in
                    checkEnableBtn()
                }
            )
            .disabled(true)

//            InputField(
//                title: "password",
//                text: $password,
//                isSecure: true,
//                isValid: isPasswordValid,
//                onTextAction: { text in
//                    checkEnableBtn()
//                    checkPasswordMatch()
//                    onPasswordTextChange(text)
//
//                    if continueAttempted && !checkPasswordValidity(password: password) {
//                        showPasswordCheckView = true
//                    } else {
//                        showPasswordCheckView = false
//                    }
//                }
//            )
//            .focused($pinFocusState, equals: .newPassword)

            
//            if pinFocusState == .newPassword{
//                    Spacer().frame(height: 12)
//                    getPasswordListView()
//            }


//            InputField(
//                title: "confirm_password",
//                text: $confirmPassword,
//                isSecure: true,
//                isValid: doPasswordsMatch,
//                onTextAction: { text in
//                    checkEnableBtn()
//                    checkPasswordMatch()
//                }
//            )
//            .focused($pinFocusState, equals: .confirmPassword)
        }
    }

    private var bottomView: some View {
        return VStack {
            Button {
                onContinueTap?(username, password)
            } label: {
                Text("continue".localized)
                    .font(.cairoFont(.semiBold, size: 18))
                    .foregroundStyle(.white)
                    .frame(minWidth: 357, minHeight: 51)
//                    .background(RoundedRectangle(cornerRadius: 99).fill(enableBtn ? Color.colorPrimary : Color.gray))
                    .background(RoundedRectangle(cornerRadius: 99).fill(Color.colorPrimary))
            }
//            .disabled(!enableBtn)
            
            Spacer().frame(height: 24)
        }
    }
    
    private func getPasswordListView() -> some View {

        VStack(alignment: .leading){
            HStack{
                Text("your_password_must_include".localized)
                    .font(Font.apply(.semiBold,size: 13))
                    .foregroundColor(.colorTextPrimary)

                Spacer()

                if !getPasswordStrong().0.isEmpty{
                        Text(getPasswordStrong().0)
                            .font(Font.apply(.semiBold,size: 13))
                            .foregroundColor(getPasswordStrong().1)


                }

            }
            ForEach(Array(listPasswordValidation.wrappedValue.keys.sorted(by: {$0.index < $1.index})), id: \.self) { key in

                HStack{
                    passwordItemView(key: key, value: listPasswordValidation.wrappedValue[key] ?? .init(match: .none))
                }

            }

        }
            .padding(.vertical,16)
            .padding(.horizontal,20)
            .background(RoundedRectangle(cornerRadius: 20)
                .fill(Color.colorBGTertiary))
    }

    private func passwordItemView(key:PasswordValidationType,value:ChangePasswordUIModel) -> some View{
          HStack(alignment: .center,spacing: 0){
              Image(value.match == .success ? "ic_checkCircleSelected" : "ic_checkCircle")
                  .resizable()
                  .frame(width: 18)
                  .frame(height: 18)
              Spacer().frame(width: 8)
              Text(key.message)
                  .font(Font.apply(.medium,size: 13))
                  .foregroundColor(.colorTextSecondaryThird)
          }

      }

    private func getPasswordStrong() ->(String,Color) {
        let count = Array(listPasswordValidation.wrappedValue.values).filter({
            $0.match == .success
        }).count
        if count == 0 && password.isEmpty{
            return ("",.clear)
        }else if count < listPasswordValidation.wrappedValue.count && !password.isEmpty{
            return ("weak".localized,.colorError)
        }
        else{
            return ("strong".localized,.colorSuccess2)

        }
    }
    
    private var errorView:some View{
        Text("password_need_to_be_the_same".localized)
            .foregroundStyle(Color.colorError)
            .font(.apply(size:13))

    }
    
    private func checkEnableBtn() {
//        enableBtn = !username.isEmpty
        enableBtn = true
    }

    
    private func checkPasswordValidity(password: String) -> Bool {
        
//        let lowercaseCheck = password.rangeOfCharacter(from: .lowercaseLetters) != nil
        let uppercaseCheck = password.rangeOfCharacter(from: .uppercaseLetters) != nil
        let numberCheck = password.rangeOfCharacter(from: .decimalDigits) != nil
        let specialCharacterCheck = password.rangeOfCharacter(from: .alphanumerics.inverted) != nil
        let lengthChecker = password.count >= 8
        
//        return lowercaseCheck && uppercaseCheck && numberCheck && specialCharacterCheck && lengthChecker
        return uppercaseCheck && numberCheck && specialCharacterCheck && lengthChecker
    }

    private func checkPasswordMatch(){
        if !enableBtn{
            return
        }
        if confirmPassword != password {
            errorPasswordNotMatch = true
       }else{
           errorPasswordNotMatch = false
       }
    }


}

struct InputField: View {
    var title: String
    @Binding var text: String
    var isSecure: Bool = false
    var isValid: Bool? = nil // nil for default, true for valid, false for invalid
    @State private var isVisible: Bool = false
    
    var onTextAction: ((String) -> Void)

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .center) {
                VStack(alignment: .leading, spacing: 0) {
                    Text(title.localized)
                        .font(.cairoFont(.light, size: 12))
                    if isSecure && !isVisible {
                        SecureField("", text: $text)
                            .font(.cairoFont(.semiBold, size: 12))
                            .onChange(of: text) { newValue in
                                onTextAction(newValue)
                            }
                    } else {
                        TextField("", text: $text)
                            .font(.cairoFont(.semiBold, size: 12))
                            .onChange(of: text) { newValue in
                                onTextAction(newValue)
                            }
                    }
                }


                if isSecure {
                    Button(action: {
                        isVisible.toggle()
                    }) {
                        Image(isVisible ? "ic_eyeVisible" : "ic_eyeInvisible")
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(Color(hex: "#828282"))
                            .frame(width: 24, height: 24)
                    }
                }
            }
        }
        .padding(.vertical, 5.5)
        .padding(.horizontal, 12)
        .background(RoundedRectangle(cornerRadius: 8).fill(Color(hex: "#DDDDDD")).shadow(color: .black, radius: 0.3, x: 0, y: 1))
        .padding(.horizontal, 18)

    }

    private var borderColor: Color {
        if let valid = isValid {
            return valid ? .green : .red
        }
        return .clear
    }
}


#Preview {
    LoginInformationContentView(listPasswordValidation: .constant([:]), onPasswordTextChange:  { text in
        
    }, onBack: {
        
    }, onContinueTap: {username,password in
        
    })
    
}
