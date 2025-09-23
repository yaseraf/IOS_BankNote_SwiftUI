//
//  OrdersContentView.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 09/09/2025.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct OrdersContentView:View {
    
    enum SelectedOrderType {
        case all
        case pending
        case completed
    }
    
    @State var selectedOrderType: SelectedOrderType = .all
    
    var ordersData: Binding<[OrderListUIModel]?>
    var filterOSSList: Binding<[GetLookupsUIModel]?>
    
    var onOrderTap:(String)->Void
    
    var body: some View {
        VStack(spacing: 0) {
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
                    Button {
                        onOrderTap(element.Symbol ?? "")
                    } label: {
                        OrdersCell(ordersData: element, filterOSSList: filterOSSList)
                    }

                }
            }
        }
    }
    
    private var segmentSelection: some View {
        HStack {
            HStack(alignment: .center, spacing: 6){
                if selectedOrderType == .all {
                    Circle()
                        .frame(width: 5, height: 5)
                        .foregroundStyle(Color(hex: "#9C4EF7"))
                }
                Text("all".localized)
                    .font(.cairoFont(.regular, size: 18))
                    .foregroundStyle(selectedOrderType == .all ? Color(hex: "#9C4EF7") : Color(hex: "#828282"))
                    .onTapGesture {
                        selectedOrderType = .all
                    }
            }
            
            HStack(alignment: .center, spacing: 6){
                if selectedOrderType == .pending {
                    Circle()
                        .frame(width: 5, height: 5)
                        .foregroundStyle(Color(hex: "#9C4EF7"))
                }
                Text("pending".localized)
                    .font(.cairoFont(.regular, size: 18))
                    .foregroundStyle(selectedOrderType == .pending ? Color(hex: "#9C4EF7") : Color(hex: "#828282"))
                    .onTapGesture {
                        selectedOrderType = .pending
                    }
            }
            
            HStack(alignment: .center, spacing: 6){
                if selectedOrderType == .completed {
                    Circle()
                        .frame(width: 5, height: 5)
                        .foregroundStyle(Color(hex: "#9C4EF7"))
                }
                Text("completed".localized)
                    .font(.cairoFont(.regular, size: 18))
                    .foregroundStyle(selectedOrderType == .completed ? Color(hex: "#9C4EF7") : Color(hex: "#828282"))
                    .onTapGesture {
                        selectedOrderType = .completed
                    }
            }
            Spacer()

        }
        .padding(.horizontal, 18)
    }

}

struct OrdersCell: View {
    
    var ordersData: OrderListUIModel
    var filterOSSList: Binding<[GetLookupsUIModel]?>

    var body: some View {
        HStack(spacing: 0) {
            HStack(spacing: 16) {
                WebImage(url: URL(string: "\(UserDefaultController().iconPath ?? "")/\(ordersData.Symbol ?? "").png")) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 45, maxHeight: 45)
                            .padding(.horizontal, 4)
                            .foregroundStyle(.gray)
                    case .failure:
                        Image("ic_selectStock")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 45, maxHeight: 45)
                            .padding(.horizontal, 4)
                            .foregroundStyle(.gray)
                    case .empty:
                        Image("ic_selectStock")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 45, maxHeight: 45)
                            .foregroundStyle(.gray)
                    @unknown default:
                        Image("ic_selectStock")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 45, maxHeight: 45)
                            .foregroundStyle(.gray)
                    }
                }

                
                VStack(alignment: .leading, spacing: 0) {
                    Text("\(ordersData.SellBuyFlag?.lowercased() == "b" ? "buy".localized : "sell".localized) \(ordersData.Symbol ?? "")")
                        .font(.cairoFont(.semiBold, size: 14))
                        .foregroundStyle(.black)
                    Text("\(convertDateString(ordersData.ValidityDate ?? "", format: "ddMMyyyyHHmmss") ?? "-")")
                        .font(.cairoFont(.semiBold, size: 12))
                        .foregroundStyle(.black)
                }
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 0) {
                Text("\(ordersData.SellBuyFlag?.lowercased() == "b" ? "+" : "") \(AppUtility.shared.formatThousandSeparator(number: Double(ordersData.Remaining ?? "") ?? 0))")
                    .font(.cairoFont(.semiBold, size: 12))
                    .foregroundStyle(Color(hex: ordersData.SellBuyFlag?.lowercased() == "b" ? "#1E961E" : "#AA1A1A" ))
                
                Text((AppUtility.shared.isRTL ? filterOSSList.wrappedValue?.filter({$0.id == ordersData.StatusCode}).first?.descA : filterOSSList.wrappedValue?.filter({$0.id == ordersData.StatusCode}).first?.descE) ?? "")
                    .font(.cairoFont(.semiBold, size: 12))
                    .foregroundStyle(getForegroundColor(m: ordersData))

            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .background(RoundedRectangle(cornerRadius: 12).fill(.white))
        .padding(.horizontal, 18)
    }
}

func getStatusDescE(m: OrderListUIModel) -> String {
    switch m.StatusCode?.lowercased() {
    case StatusType.s.symbol.lowercased():
        return StatusType.s.text
    case StatusType.p.symbol.lowercased():
        return StatusType.p.text
    case StatusType.w.symbol.lowercased():
        return StatusType.w.text
    case StatusType.r.symbol.lowercased():
        return StatusType.r.text
    case StatusType.c.symbol.lowercased():
        return StatusType.c.text
    case StatusType.a.symbol.lowercased():
        return StatusType.a.text
    case StatusType.e.symbol.lowercased():
        return StatusType.e.text
    case StatusType.t.symbol.lowercased():
        return StatusType.t.text
    default: return "null"
    }
}

func getBackgroundColor(m: OrderListUIModel) -> Color {
    switch m.StatusCode?.lowercased() {
    case StatusType.s.symbol.lowercased():
        return StatusType.s.backgroundColor
    case StatusType.p.symbol.lowercased():
        return StatusType.p.backgroundColor
    case StatusType.w.symbol.lowercased():
        return StatusType.w.backgroundColor
    case StatusType.r.symbol.lowercased():
        return StatusType.r.backgroundColor
    case StatusType.c.symbol.lowercased():
        return StatusType.c.backgroundColor
    case StatusType.a.symbol.lowercased():
        return StatusType.a.backgroundColor
    case StatusType.e.symbol.lowercased():
        return StatusType.e.backgroundColor
    case StatusType.t.symbol.lowercased():
        return StatusType.t.backgroundColor
    default: return Color.orange
    }
}

func getForegroundColor(m: OrderListUIModel) -> Color {
    switch m.StatusCode?.lowercased() {
    case StatusType.s.symbol.lowercased():
        return StatusType.s.foregroundColor
    case StatusType.p.symbol.lowercased():
        return StatusType.p.foregroundColor
    case StatusType.w.symbol.lowercased():
        return StatusType.w.foregroundColor
    case StatusType.r.symbol.lowercased():
        return StatusType.r.foregroundColor
    case StatusType.c.symbol.lowercased():
        return StatusType.c.foregroundColor
    case StatusType.a.symbol.lowercased():
        return StatusType.a.foregroundColor
    case StatusType.e.symbol.lowercased():
        return StatusType.e.foregroundColor
    case StatusType.t.symbol.lowercased():
        return StatusType.t.foregroundColor
    default: return Color.orange
    }
}

enum  StatusType{
    case s // fulfilled, green
    case p // partial fulfilled ,green
    case w // waiting, yellow
    case r // rejected, red
    case c // canceled, red
    case a // active, green
    case e // expired, red
    case t // sent, green
    
    var symbol: String {
        switch self {
        case .s: "s"
        case .p: "p"
        case .w: "w"
        case .r: "r"
        case .c: "c"
        case .a: "a"
        case .e: "e"
        case .t: "t"
        }
    }


    var text:String {
        switch self {
        case .s:
            "fully_filled".localized
        case .p:
            "partially_fulfilled".localized
        case .w:
            "waiting".localized
        case .r:
            "rejected".localized
        case .c:
            "cancelled".localized
        case .a:
            "active".localized
        case .e:
            "expired".localized
        case .t:
            "sent".localized
        }
    }

    var foregroundColor:Color {
        switch self {
        case .s:
            Color.colorSuccess
        case .p:
            Color.colorSuccess
        case .w:
            Color.colorWarning600
        case .r:
            Color.colorError
        case .c:
            Color.colorError
        case .a:
            Color.colorSuccess
        case .e:
            Color.colorError
        case .t:
            Color.colorSuccess
        }
    }

    var backgroundColor:Color {
        switch self {
        case .s:
            Color.colorSuccess50
        case .p:
            Color.colorSuccess50
        case .w:
            Color.colorWarning50
        case .r:
            Color.colorError50
        case .c:
            Color.colorError50
        case .a:
            Color.colorSuccess50
        case .e:
            Color.colorError50
        case .t:
            Color.colorSuccess50
        }
    }
}

func convertDateString(_ dateString: String, format: String) -> String? {

    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = format
    
    guard let date = inputFormatter.date(from: dateString) else {
        return nil
    }
    
    let outputFormatter = DateFormatter()
    outputFormatter.dateFormat = "dd/MM/yyyy"
    
    return outputFormatter.string(from: date)
}


#Preview {
    OrdersContentView(ordersData: .constant([]), filterOSSList: .constant([]), onOrderTap: {_ in 
        
    })
}
