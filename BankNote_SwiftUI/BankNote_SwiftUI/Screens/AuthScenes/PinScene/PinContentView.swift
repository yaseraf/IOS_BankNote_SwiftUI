//
//  PinContentView.swift
//  mahfazati
//
//  Created by FIT on 11/08/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import SwiftUI

struct PinContentView: View,BaseContentViewType {
    private let widthPinButtonView:CGFloat
    private let maxPinDigit:Int = 4
    private let isWrongPinInput: Binding<Bool>?
    @State var pinTextValue:String = ""
    @State var enablePinBtn:Bool = true
    var onPinTextFilled:((String)->Void)
    var onForgetTap:(()->Void)
    var onFaceIdTap:(()->Void)
    var onFailure:(()->Void)
    
    init(isWrongPinInput:Binding<Bool>?, pinsValue: String, onPinTextFilled:  @escaping (String) -> Void, onForgetTap:  @escaping () -> Void, onFaceIdTap:  @escaping () -> Void, onFailure: @escaping () -> Void) {
        self.isWrongPinInput = isWrongPinInput
        self.widthPinButtonView =  ( UIScreen.main.bounds.width) / 4
        self.pinTextValue = pinsValue
        self.onPinTextFilled = onPinTextFilled
        self.onForgetTap = onForgetTap
        self.onFaceIdTap = onFaceIdTap
        self.onFailure = onFailure
    }

    var body: some View {
        VStack(alignment:.center){
            
            AuthHeaderView(type: .back(.pop))

            Spacer().frame(height: 32)
            HStack{
                AuthLogoSmallView()
            }.frame(maxWidth: .infinity)
            
            Spacer()
            getIndicateTapView()
            if UIDevice.current.userInterfaceIdiom == .phone {
                Spacer().frame(maxHeight: 72)
            } else if UIDevice.current.userInterfaceIdiom == .pad {
                Spacer()                
            }
            getPinView()
            
            
        }.frame(maxWidth: .infinity)
    }
    

    
    
    private func getIndicateTapView() -> some View {
        HStack(spacing:16){
            ForEach(0 ..< maxPinDigit,id:\.self){i in
                Circle()
                    .fill(pinTextValue.count <= i ? Color.colorBGTertiary : Color.colorPrimary)
                    .frame(width: 12)
                    .frame(height: 12)


            }
        }.frame(maxWidth: .infinity)
    }
    private func getPinView() -> some View {
        VStack(spacing:8){
            HStack(spacing:8){
                getItemView(title: "1", subTitle: "")
                getItemView(title: "2", subTitle: "ABC")
                getItemView(title: "3", subTitle: "DEF")
            }
            
            HStack(spacing:8){
                getItemView(title: "4", subTitle: "GHI")
                getItemView(title: "5", subTitle: "JKL")
                getItemView(title: "6", subTitle: "MNO")
            }
            
            HStack(spacing:8){
                getItemView(title: "7", subTitle: "PQRS")
                getItemView(title: "8", subTitle: "TUV")
                getItemView(title: "9", subTitle: "WXYZ")
            }
            
            HStack(spacing:8){
                forgetBtnView
                    .opacity(0)
                getItemView(title: "0", subTitle: "TUV")
                faceIdBtnView
                    .opacity(0)
            }
            
            HStack(spacing:8){
                Spacer()
                deleteBtnView
            }
            
            
        }.frame(maxWidth: .infinity)
            .padding(.bottom,16)
        
    }
    
    private func getItemView(title:String,subTitle:String) -> some View {
        
        Button {
               addValue(value: title)
        } label: {
            
            if UIDevice.current.userInterfaceIdiom == .pad {
                VStack{
                    Text(title)
                        .font(.largeTitle)
    //                    .font(Font.apply(size: 28))
                        .foregroundColor(.colorTextPrimary)
                    
                    if !subTitle.isEmpty {
                        
                        Spacer().frame(height: 8)
                        
                        Text(subTitle)
                            .font(.subheadline)
    //                        .font(Font.apply(size: 12))
                            .foregroundColor(.colorTextSecondaryThird)
                    }
                }
                .frame(maxWidth: 400, maxHeight: 70)
    //            .frame(width: widthPinButtonView)
    //            .frame(height: widthPinButtonView)
                .background(RoundedRectangle(cornerSize: CGSize(width: 36, height: 36)).fill(Color.colorBGTertiary))
            } else if UIDevice.current.userInterfaceIdiom == .phone {
                VStack{
                    Text(title)
                        .font(.largeTitle)
    //                    .font(Font.apply(size: 28))
                        .foregroundColor(.colorTextPrimary)
                    
                    if !subTitle.isEmpty {
                        
                        Spacer().frame(height: 8)
                        
                        Text(subTitle)
                            .font(.subheadline)
    //                        .font(Font.apply(size: 12))
                            .foregroundColor(.colorTextSecondaryThird)
                    }
                }
                .frame(maxWidth: widthPinButtonView, maxHeight: widthPinButtonView)
    //            .frame(width: widthPinButtonView)
    //            .frame(height: widthPinButtonView)
                .background(Circle().fill(Color.colorBGTertiary))
            }
           
        }
        .disabled(!enablePinBtn)


    }
    
    private var forgetBtnView : some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            Button {
                onForgetTap()
            } label: {
                Text("forget".localized)
                    .font(Font.apply(.semiBold,size: 16))
                    .foregroundColor(.colorTextPrimary)
            }
            .frame(maxWidth: widthPinButtonView, maxHeight: widthPinButtonView)

        } else if UIDevice.current.userInterfaceIdiom == .pad {
            Button {
                onForgetTap()
            } label: {
                Text("forget".localized)
                    .font(Font.apply(.semiBold,size: 16))
                    .foregroundColor(.colorTextPrimary)
            }
            .frame(maxWidth: 400, maxHeight: 70)

        } else {
            Button {
                onForgetTap()
            } label: {
                Text("forget".localized)
                    .font(Font.apply(.semiBold,size: 16))
                    .foregroundColor(.colorTextPrimary)
            }
            .frame(maxWidth: widthPinButtonView, maxHeight: widthPinButtonView)

        }
       
    }
    
    
    private var faceIdBtnView : some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            Button {
                onFaceIdTap()
            } label: {
                
                Image("ic_faceIdSolid")
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 20)
                    .frame(height:  20)
    //                .tint(Color.colorTextPrimary)
                    .foregroundStyle(Color.colorTextPrimary)

                
            }
            .frame(maxWidth: widthPinButtonView, maxHeight: widthPinButtonView)

        } else if UIDevice.current.userInterfaceIdiom == .pad {
            Button {
                onFaceIdTap()
            } label: {
                
                Image("ic_faceIdSolid")
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 20)
                    .frame(height:  20)
    //                .tint(Color.colorTextPrimary)
                    .foregroundStyle(Color.colorTextPrimary)

                
            }
            .frame(maxWidth: 400, maxHeight: 70)

        } else {
            Button {
                onFaceIdTap()
            } label: {
                
                Image("ic_faceIdSolid")
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 20)
                    .frame(height:  20)
    //                .tint(Color.colorTextPrimary)
                    .foregroundStyle(Color.colorTextPrimary)

                
            }
            .frame(maxWidth: widthPinButtonView, maxHeight: widthPinButtonView)

        }
       
    }
    
    private var deleteBtnView : some View {
        Button {
            removeValue()
        } label: {
            Text("clear".localized)
                .font(Font.apply(.semiBold,size: 14))
                .foregroundColor(.colorTextPrimary)
        }
        .frame(width: widthPinButtonView)
        .frame(height: 30)
    }
    
   private func checkCanAdd() {
        enablePinBtn = pinTextValue.count < maxPinDigit

       if !enablePinBtn && !pinTextValue.isEmpty{
           onPinTextFilled(pinTextValue)
           if ((isWrongPinInput?.wrappedValue) != nil) {
               pinTextValue = "\(pinTextValue.suffix(pinTextValue.count - 4))"
               checkCanAdd()
           }
       }

    }

    private func addValue(value:String){
        pinTextValue += value
        checkCanAdd()
    }

    private func removeValue(){
        if !pinTextValue.isEmpty{
            pinTextValue = "\(pinTextValue.suffix(pinTextValue.count - 1))"
        }
        checkCanAdd()
    }

}

#Preview {
    PinContentView(isWrongPinInput: .constant(false), pinsValue: "1234") { eee in
        
    } onForgetTap: {
        
    } onFaceIdTap: {
        
    } onFailure: {
        
    }

}
