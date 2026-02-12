//
//  LoginInformationContentView.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 15/09/2025.
//

import Foundation
import SwiftUI

struct QuestionsContentView: View {
    
    var questionsData: Binding<GetQuestionsValifyUIModel?>

    @State var stepNumber:Int = 3
    @State private var answer = ""
    @State private var enableBtn:Bool = false
    
    var onBack: ()->Void

    var isAnswerValid: Bool {
        // A simple validation rule
        return answer.count > 0
    }
    
    var onContinueTap:(String, String)->Void

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
            Text("questions".localized)
                .font(.cairoFont(.semiBold, size: 18))
            
//            Text("you_will_use_these_details_to_login_to_your_account".localized)
//                .font(.cairoFont(.light ,size: 12))
            
            
            fieldsView
                .padding(.top, 20)
            
        }
    }
    
    private var fieldsView: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("\(AppUtility.shared.isRTL ? questionsData.wrappedValue?.questions?.first?.ar ?? "" : questionsData.wrappedValue?.questions?.first?.en ?? "")")
                .font(.cairoFont(.semiBold, size: 18))
                .padding(.horizontal, 16)

            InputField(
                title: "",
                text: $answer,
                isValid: isAnswerValid,
                onTextAction: { text in
                    checkEnableBtn()
                }
            )

        }
    }

    private var bottomView: some View {
        return VStack {
            Button {
                onContinueTap(answer, questionsData.wrappedValue?.questions?.first?.id ?? "")
            } label: {
                Text("continue".localized)
                    .font(.cairoFont(.semiBold, size: 18))
                    .foregroundStyle(.white)
                    .frame(minWidth: 357, minHeight: 51)
                    .background(RoundedRectangle(cornerRadius: 99).fill(enableBtn ? Color.colorPrimary : Color.gray))
            }
            .disabled(!enableBtn)
            
            Spacer().frame(height: 24)
        }
    }

    private func checkEnableBtn() {
        enableBtn = !answer.isEmpty
    }
}

//#Preview {
//    LoginInformationContentView(listPasswordValidation: .constant([:]), onPasswordTextChange:  { text in
//        
//    }, onContinueTap: {username,password in
//        
//    })
//}
