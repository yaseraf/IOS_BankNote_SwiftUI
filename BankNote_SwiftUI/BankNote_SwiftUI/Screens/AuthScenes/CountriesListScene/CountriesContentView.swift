//
//  CountriesContentView.swift
//  mahfazati
//
//  Created by FIT on 02/08/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import SwiftUI
import FlagAndCountryCode

struct CountriesContentView: View {
    var list:Binding<[CountryFlagInfo] >
    @State private var inputValue: String = ""
    var onCloseTap:(()->Void)?
    var onTap:((CountryFlagInfo)->Void)?
    var onTextChange:((String)->Void)?
    var selectModel:Binding<CountryFlagInfo?>
    var allCountries = CountryFlagInfo.all
    var selectedSegment: Binding<Int>

    init(list: Binding<[CountryFlagInfo]>,selectModel:Binding<CountryFlagInfo?>,  onTextChange:((String)->Void)?,onTap:((CountryFlagInfo)->Void)?,onCloseTap:(()->Void)?, selectedSegment:Binding<Int>) {
        self.list = list
        self.onTextChange = onTextChange
        self.selectModel = selectModel
        self.onTap = onTap
        self.onCloseTap = onCloseTap
        self.selectedSegment = selectedSegment
    }
    

    var body: some View {
            GeometryReader{geo in
                VStack(spacing:0){
                    
                    Spacer().frame(height: geo.size.height/5)
                    
                    VStack(spacing:0){
                        GrabberView()
                        HStack(alignment: .firstTextBaseline){
                            titleView
                            Spacer()
                            closeView
                        }
                        Spacer().frame(height: 24)
                        searchView
                        Spacer().frame(height: 20)
                        listView

                    }
                    .padding(.horizontal,16)
                    .padding(.top,16)

                    .background(Color.colorBGPrimary)
                        .cornerRadius(24, corners: [.topLeft,.topRight])

                }


            }


    }

    private var listView  : some View {
        get{

            List(){
                ForEach(list,id:\.self){ model in
                    cellView(model.wrappedValue)
                }.listRowBackground(Color.colorBGPrimary)
            }.listStyle(.plain)
                .background(Color.colorBGPrimary)
        }
    }
    private func cellView(_ model:CountryFlagInfo) -> some View {
        HStack{
            model.getCountryImage(with: FlagType(rawValue: selectedSegment.wrappedValue) ?? .roundedRect)
                .frame(width: 30)
//            Image(model.iconName)
//                .resizable()
//                .frame(width: 32)
//                .frame(height:  32)
            
            Spacer().frame(width: 32)

            Text("\(model.name.localized)")
                .foregroundColor(.colorTextPrimary)
                .font(.cairoFont(.semiBold, size:17))

            Spacer()

            Button {
                onTap?(model)
            } label: {
                Image((selectModel.wrappedValue?.name ) == model.name ?  "ic_radioFill" : "ic_radioEmpty")
                    .resizable()
                    .frame(width: 20)
                    .frame(height:  20)
            }

        }.padding(.vertical,8)

    }

    private var titleView:some View {
        get{
            Text("select_country".localized)
                .font(.cairoFont(.bold,size: 22))
                .foregroundColor(.colorTextPrimary)
        }
    }    

    private var closeView:some View {
        get{
            Button {
                onCloseTap?()
            } label: {
                CloseCustomView()
            }
        }
    }

    private var searchView:some View {
        
            let binding = Binding<String>(get: {
                       self.inputValue
                   }, set: {

                       self.inputValue = $0
                       onTextChange?( $0)
                       // do whatever you want here
                   })

            return HStack(alignment: .center){
                Image("ic_search")
                    .resizable()
                    .frame(width: 20)
                    .frame(height:  20)

                TextField("", text: binding, prompt: Text("search_for_country".localized)
                    .font(.cairoFont(.semiBold, size: 17))
                    .foregroundColor(.colorTextPlaceHolder)
                ) .font(.cairoFont(.semiBold, size: 17))
                    .foregroundColor(.colorTextPrimary)
            }
            .frame(height: 54)
            .padding(.horizontal,16)
            .background(RoundedRectangle(cornerRadius: 14)
                .foregroundColor(.colorBGTertiary)
                )
            .border(Color.colorBorderPrimary, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
            .cornerRadius(14)

    }
}
//
//#Preview {
//    CountriesContentView(list: .constant([.init(id: 1, name: "1", iconName: "flag1", mcc: "997")]), selectModel: .constant(nil), onTextChange: {_ in }, onTap: {_ in }, onCloseTap: {})
//}
