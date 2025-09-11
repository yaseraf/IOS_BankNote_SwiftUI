//
//  OrdersContentView.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 09/09/2025.
//

import Foundation
import SwiftUI

struct OrdersContentView:View {
    
    enum SelectedOrderType {
        case all
        case pending
        case completed
    }
    
    @State var selectedOrderType: SelectedOrderType = .all
    
    var ordersData: Binding<[OrdersUIModel]?>

    
    var body: some View {
        VStack {
            HeaderView()
            
            titleView
            
            ordersView
            
            Spacer()
            
            HomeBottomBarView(selectedItem: .orders)
        }
    }
    
    
    private var titleView: some View {
        Text("orders".localized)
            .font(.cairoFont(.bold, size: 32))
            .foregroundStyle(.black)
    }
    
    private var ordersView: some View {
        VStack {
            segmentSelection
            
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(Array((ordersData.wrappedValue ?? []).enumerated()), id: \.offset) { idnex, element in
                    OrdersCell(ordersData: element)
                }
            }
        }
    }
    
    private var segmentSelection: some View {
        HStack {
            Text(selectedOrderType == .all ? "\("•" + " " + "all".localized)" : "all".localized)
                .font(.cairoFont(.regular, size: 18))
                .foregroundStyle(selectedOrderType == .all ? Color(hex: "#9C4EF7") : Color(hex: "#828282"))
                .onTapGesture {
                    selectedOrderType = .all
                }
            
            Text(selectedOrderType == .pending ? "\("•" + " "  + "pending".localized)" : "pending".localized)
                .font(.cairoFont(.regular, size: 18))
                .foregroundStyle(selectedOrderType == .pending ? Color(hex: "#9C4EF7") : Color(hex: "#828282"))
                .onTapGesture {
                    selectedOrderType = .pending
                }
            
            Text(selectedOrderType == .completed ? "\("•" + " "  + "completed".localized)" : "completed".localized)
                .font(.cairoFont(.regular, size: 18))
                .foregroundStyle(selectedOrderType == .completed ? Color(hex: "#9C4EF7") : Color(hex: "#828282"))
                .onTapGesture {
                    selectedOrderType = .completed
                }
            
            Spacer()

        }
        .padding(.horizontal, 18)
    }

}

struct OrdersCell: View {
    
    var ordersData: OrdersUIModel
    
    var body: some View {
        HStack(spacing: 0) {
            HStack(spacing: 16) {
                Image(ordersData.image ?? "")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 45, height: 45)
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("\(ordersData.name ?? "")")
                        .font(.cairoFont(.semiBold, size: 14))
                    Text("\(ordersData.time ?? "")")
                        .font(.cairoFont(.semiBold, size: 12))
                }
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 0) {
                Text("\(ordersData.value ?? 0 >= 0 ? "+" : "") \(AppUtility.shared.formatThousandSeparator(number: ordersData.value ?? 0))")
                    .font(.cairoFont(.semiBold, size: 12))
                    .foregroundStyle(Color(hex: ordersData.value ?? 0 >= 0 ? "#1E961E" : "#AA1A1A" ))
                
                Text(ordersData.status ?? "")
                    .font(.cairoFont(.semiBold, size: 12))
                    .foregroundStyle(Color(hex: ordersData.status == "pending".localized ? "#828282" : ordersData.status == "completed".localized ? "#1E961E" : "#000000" ))

            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .background(RoundedRectangle(cornerRadius: 12).fill(.white))
        .padding(.horizontal, 18)
    }
}


#Preview {
    OrdersContentView(ordersData: .constant([OrdersUIModel(image: "ic_adnocdistStock", type: "buy".localized, name: "ADNOCDIST", time: "28/05/2025    02:47 pm", value: -84.59, status: "pending".localized), OrdersUIModel(image: "ic_nvidiaStock", type: "buy".localized, name: "NVIDIA", time: "27/05/2025    12:34 pm", value: -150.35, status: "completed".localized), OrdersUIModel(image: "ic_topUp", type: "", name: "top_up", time: "27/05/2025    10:29pm", value: 400, status: "completed".localized)]))
}
