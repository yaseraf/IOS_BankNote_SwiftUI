//
//  PickerItemsContentView.swift
//  mahfazati
//
//  Created by Mohammmed on 10/08/2024.
//  Copyright © 2024 Mohammed Mathkour. All rights reserved.
//

import SwiftUI

struct PickerItemsContentView: View {
    var listSearch:Binding<[ItemPickerModelType]?>
    var selectType:Binding<PickerItemsSelectType>
    var allowSearch:Binding<Bool>
     var title:Binding<String>
    var list:Binding<[ItemPickerModelType] >
    var maxCount:Binding<Int>
    @State private var inputValue: String = ""
    var onCloseTap:(()->Void)?
    var onTap:((ItemPickerModelType)->Void)?
    var onTextChange:((String)->Void)?
    var selectModel:Binding<ItemPickerModelType?>
    var selectModels:Binding<[ItemPickerModelType]>

    init(allowSearch:Binding<Bool>, listSearch: Binding<[ItemPickerModelType]?>, selectType:Binding<PickerItemsSelectType>,title:Binding<String>,maxCount:Binding<Int>,list: Binding<[ItemPickerModelType]>,selectModel:Binding<ItemPickerModelType?>,selectModels:Binding<[ItemPickerModelType]>,  onTextChange:((String)->Void)?,onTap:((ItemPickerModelType)->Void)?,onCloseTap:(()->Void)?) {
        self.allowSearch = allowSearch
        self.listSearch = listSearch
        self.selectType = selectType
        self.title = title
        self.maxCount = maxCount
        self.list = list
        self.onTextChange = onTextChange
        self.selectModel = selectModel
        self.selectModels = selectModels
        self.onTap = onTap
        self.onCloseTap = onCloseTap
    }
    

    var body: some View {
            GeometryReader{geo in
                VStack(spacing:0){
                    
                    Spacer().frame(height: geo.size.height/5)
                    Spacer()
                    VStack(spacing:0){
                        GrabberView()
                        HStack(alignment: .firstTextBaseline){
                            titleView
                            Spacer()
                            closeView
                        }
                        Spacer().frame(height: 24)
                        if allowSearch.wrappedValue {
                            searchView
                            Spacer().frame(height: 20)
                        }

                        getSearchViewResult()
//                            .padding(.top,24)
//                            .padding(.horizontal,16)
                        Spacer()
//                            listView

                    }
                    .padding(.horizontal,16)
                    .padding(.top,16)
                    .padding(.bottom,AppUtility.bottomNotch)

                    .background(Color.colorBGPrimary)
                        .cornerRadius(24, corners: [.topLeft,.topRight])

                }


            }


    }

    private var listView  : some View {
        get{

            ScrollView(){
                LazyVStack(spacing: 0) {
                    ForEach(list,id:\.id){ model in
                        cellView(model.wrappedValue)
                            .frame(height: 40)
                        Divider()
                    }
                }
            }
            .frame(maxHeight: maxCount.wrappedValue <= 5 ? (CGFloat(list.count) * 40) : .infinity )

            .listStyle(.plain)
                .background(Color.colorBGPrimary)
        }
    }
    private func cellView(_ model:ItemPickerModelType) -> some View {
        Button {
            onTap?(model)
        } label: {

            HStack{
                VStack(alignment: .leading, spacing: 5) {
                    Text("\(model.name)")
                        .foregroundColor(.colorTextPrimary)
                        .font(.apply(size:17))
                    
                    if model.subName != "" {
                        Text("\(model.subName)")
                            .foregroundColor(.colorTextSecondary)
                            .font(.caption)
                    }
                }

                Spacer()

                if selectType.wrappedValue == .one{
                    Image((selectModel.wrappedValue?.key ) == model.key ?  "ic_radioFill" : "ic_radioEmpty")
                        .resizable()
                        .frame(width: 20)
                        .frame(height:  20)
                }else{
                    Image(selectModels.wrappedValue.filter({$0.id == model.id}).isEmpty ?  "ic_checkbox" : "ic_checkboxSelected")
                        .resizable()
                        .frame(width: 20)
                        .frame(height:  20)
                }
            }

        }.padding(.vertical,8)

    }

    private var titleView:some View {
        get{
            Text(title.wrappedValue)
                .font(.apply(.bold,size: 22))
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
    
    private func getSearchViewResult()-> some View{
        return VStack(alignment:.leading,spacing: nil){
            if ((listSearch.wrappedValue?.isEmpty) == nil){
                ScrollView{
                    LazyVStack{
//                        DiscoverSearchEmptyView(searchWord: inputValue)
//                    Spacer()
                    }
                }            }else{
                
                if !inputValue.isEmpty {
                    List(listSearch.wrappedValue ?? [], id: \.id) { element in
                        Button {
//                            let d = Double(element.allowdBuyLimit ?? "")
//                            onSelect(OrderItemUIModel(itemName: element.symbol, itemBrand: element.exchange ?? "", iconName: "ic_selectStock", currency: element.currCode ?? "", amount: d ?? 0.0, changeValue: "", changeValueType: .minus))
                        } label: {
                            cellView(element)
//                            cellTopGainersView(list:listSearch.wrappedValue ?? [],model:element)
                        }

                    }
                    .listStyle(.plain)

                } else {
                    List(list.wrappedValue, id: \.id) { element in
                        Button {
//                            onSelect(OrderItemUIModel(itemName: "", itemBrand: "", iconName: "", currency: "", amount: 0.0, changeValue: "", changeValueType: .minus))
                        } label: {
                            cellView(element)
//                            cellTopGainersView(list:companiesLookups.wrappedValue ?? [],model:element)
                        }

                    }
                    .listStyle(.plain)

                }
                
//                LazyVStack(){
//                    ForEach(listSearch.wrappedValue ?? [], id: \.symbolID) {element in
//                        cellTopGainersView(list:listSearch.wrappedValue ?? [],model:element)
//
//                    }
//                }
            }
                

        }.frame(maxWidth: .infinity)
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

                TextField("", text: binding, prompt: Text("search_for_name".localized)
                    .font(.apply(size: 17))
                    .foregroundColor(.colorTextPlaceHolder)
                ) .font(.apply(size: 17))
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
