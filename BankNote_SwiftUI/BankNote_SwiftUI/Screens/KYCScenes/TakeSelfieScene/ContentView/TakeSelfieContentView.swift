//
//  TakeSelfieContentView.swift
//  mahfazati
//
//  Created by Mohammmed on 07/08/2024.
//  Copyright © 2024 Mohammed Mathkour. All rights reserved.
//

import SwiftUI

struct TakeSelfieContentView: View,BaseContentViewType {
    @State private var isLoading = false
      var isLivenessCheck:Binding<Bool>
    var onContinueTap:(()->Void)?

    var body: some View {
        VStack(alignment:.leading){
            AuthHeaderView(type: .logo)

            Spacer().frame(height: 24)

            HorizontalIndicatorView(selectIndex: isLivenessCheck.wrappedValue ?  .constant(.five) : .constant(.four))
//
            Spacer().frame(height: 21)

                CustomLottieAnimationView(fileName: .selfie, loopMode: .loop)
                    .frame(maxWidth: .infinity)
                    .frame(height: UIScreen.main.bounds.height / 3.4)

            titleView

            Spacer().frame(height: 8)

            descriptionView

            Spacer().frame(height: 24)
            
            Divider()

            Spacer().frame(height: 24)
            noteViews

            Spacer()
            
            bottomsView

        }
    }

    private var titleView:some View {
        get{
            let title = isLivenessCheck.wrappedValue ? "liveness_check" : "take_a_selfie"
            return Text(title.localized)
                .font(Font.apply(.bold,size: 28))
                .foregroundColor(.colorTextPrimary)
        }
    }


    private var descriptionView:some View {
        get{
            return  Text("take_a_selfie_description".localized)
                    .font(Font.apply(size: 16))
                    .foregroundColor(.colorTextSecondaryThird)
        }
    }

    private var noteViews:some View {
        get{
            VStack(alignment: .leading,spacing:16) {
                itemFormView(title: "make_sure_there_is_good_lighting".localized, imageName: "ic_lighting")

                itemFormView(title: "take_off_your_eyeglasses".localized, imageName: "ic_eyeglasses")
                itemFormView(title: "look_directly_into_the_camera".localized, imageName: "ic_camera")


            }

        }

    }



    func itemFormView(title:String,imageName:String) ->some View{

        HStack(alignment: .center,spacing:0){
            Image(imageName)
                .resizable()
                .frame(width: 20)
                .frame(height: 20)
                .padding(10)
                .background(
                    Circle()
                        .fill(Color.colorBGPrimary)
                )
                .background(
                    Circle()
                        .stroke(Color.colorBorderPrimary,lineWidth: 1)
                )
                Spacer()
                    .frame(width: 16)

                Text(title)
                    .font(Font.apply(.semiBold,size: 17))
                    .foregroundColor(.colorTextSecondaryThird)


        }

    }


    private var bottomsView:some View {
        get{
               return CustomButton(type: .primary, title: "take_selfie".localized,isLoading:$isLoading,onTap:  {
                    isLoading = true
                    onContinueTap?()
                })
                .frame(height: 50)
        }
    }




}

#Preview {
    TakeSelfieContentView(isLivenessCheck: .constant(false))
}
