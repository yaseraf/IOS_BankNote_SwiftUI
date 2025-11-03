//
//  SignOutPopupContentView.swift
//  mahfazati
//
//  Created by FIT on 05/09/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import SwiftUI

struct SignOutPopupContentView: View {

    var onDoneTap:(()->Void)
    var onCancelTap:(()->Void)
    var onCloseTap:(()->Void)




    var body: some View {
                 VStack(spacing:0){
                     Spacer()
                    VStack(spacing:0){
                        GrabberView()
                        HStack(alignment: .top){
                            iconView
                            Spacer()
                            closeView
                        }
                        Spacer().frame(height: 10)

                        titleView
                            .frame(maxWidth: .infinity,alignment: .leading)
                        Spacer().frame(height: 16)

                        signOutDescriptionView
                        Spacer().frame(height: 16)

                        VStack{
                            CustomButton(type: .primary, title: "sign_out_yes".localized,onTap:  {
                                onDoneTap()
                             })
                             .frame(height: 50)
                            CustomButton(type: .grey, title: "cancel".localized,onTap:  {
                                onCancelTap()
                             })
                             .frame(height: 50)
                        }
                    }

                    .padding(.horizontal,16)
                    .padding(.vertical,16)
                    .padding(.bottom,AppUtility.bottomNotch)

                    .background(Color.colorBGPrimary)
                        .cornerRadius(24, corners: [.topLeft,.topRight])
                }




    }

    private var signOutDescriptionView:some View {
        get{
                Text("sign_out_description")
                    .font(Font.apply(.regular,size: 17))
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.colorTextSecondary)


        }
    }




    private var iconView :some View {
            Image("ic_signOutCircle")
                .resizable()
                .frame(width: 48)
                .frame(height: 48)


    }



    private var titleView:some View {
        get{
          return  VStack(alignment: .leading,spacing: 10){
                Text("sign_out".localized)
                    .font(.apply(.bold,size: 22))
                    .foregroundColor(.colorTextPrimary)
            }
        }
    }

    private var closeView:some View {
        get{
            Button {

                onCloseTap()
            } label: {
                CloseCustomView()
            }
        }
    }

 }
