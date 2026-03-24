//
//  NotificationsContentView.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 08/03/2026.
//

import Foundation

import SwiftUI
import SwiftUICharts
import SDWebImageSwiftUI

struct NotificationsContentView: View {
    
    @Binding var notifications: [NotificationObject]?
    var filteredOSSList:Binding<[GetLookupsUIModel]?>
    var selectedTab:Binding<NotificationsTabs>

    var minimumBoxWidth:CGFloat = 45
    
    var onChangeTap:((NotificationsTabs)->Void)
    var onBackTap:()->Void

    var body: some View {
        ZStack(alignment: .top){
            VStack(spacing: 0){
                
                HeaderView()

                titleView

                CustomTabsView(
                    selectType: .constant(selectedTab.wrappedValue == .news ? .left : .right),
                    leftTitle: "news".localized,
                    onLeftTap: {
                        if selectedTab.wrappedValue != .news {
                            onChangeTap(.news)
                        }
                    },
                    rightTitle: "orders".localized,
                    onRightTap: {
                        if selectedTab.wrappedValue != .orders {
                            onChangeTap(.orders)
                        }
                    }
                )
                .padding(.horizontal,32)
                .padding(.vertical,16)
                
                ScrollView(showsIndicators: false) {
                    notificationsList
                        .padding(.horizontal,16)
                }
            }
        }
    }
    
    private var titleView: some View {
        HStack {
            Button {
                onBackTap()
            } label: {
                Image("ic_backArrow")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .padding(7)
                    .background(RoundedRectangle(cornerRadius: 4).fill(.white))
            }
            
            Spacer()
            
            Text("notifications".localized)
                .font(.cairoFont(.bold, size: 32))
                .foregroundStyle(.black)

            Spacer()

            Image("ic_backArrow")
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .background(RoundedRectangle(cornerRadius: 4).fill(.white))
                .opacity(0)

        }
        .padding(.horizontal, 18)
    }

    
    private var notificationsList: some View {
        VStack(spacing: 10) {
            ForEach((notifications ?? []).reversed(), id: \.id) { item in
                if item.objectType == "o" && selectedTab.wrappedValue == .orders {
                    VStack(spacing: 4) {
                        HStack {
                            WebImage(url: URL(string: "\(UserDefaultController().iconPath ?? "")/\(item.symbol ?? "").png")) { phase in
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
                                        .padding(.horizontal, 4)
                                        .foregroundStyle(.gray)
                                @unknown default:
                                    Image("ic_selectStock")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(maxWidth: 45, maxHeight: 45)
                                        .padding(.horizontal, 4)
                                        .foregroundStyle(.gray)
                                }
                            }
                            HStack {
                                Text("\(item.companyName ?? "")")
                                    .font(.apply(.semiBold, size: 14))
                                
                                Text(" - ")
                                    .font(.apply(.semiBold, size: 14))
                                    .padding(.horizontal, 4)

                                Text("\(item.symbol ?? "")")
                                    .font(.apply(.semiBold, size: 14))
                                    .foregroundStyle(Color.colorTextSecondary)
                            }
                            .padding(.horizontal, 4)

                            Spacer()
                        }
                        
                        HStack(spacing: 0) {
                            VStack {
                                Text("order_id".localized)
                                    .font(.apply(.medium, size: 12))
                                    .frame(minWidth: minimumBoxWidth)

                                Text("\(item.orderId ?? "")")
                                    .font(.apply(.medium, size: 12))
                                    .frame(minWidth: minimumBoxWidth)
                            }
                            
                            Spacer()
                            
                            VStack {
                                Text("quantity".localized)
                                    .font(.apply(.medium, size: 12))
                                    .frame(minWidth: minimumBoxWidth)

                                Text(AppUtility.shared.formatThousandSeparator(number: Double(item.quantity ?? "") ?? 0))
                                    .font(.apply(.medium, size: 12))
                                    .frame(minWidth: minimumBoxWidth)
                            }

                            Spacer()
                            
                            VStack {
                              
                                Text("price".localized)
                                    .font(.apply(.medium, size: 12))
                                    .frame(minWidth: minimumBoxWidth)

                                Text(AppUtility.shared.formatThousandSeparator(number: Double(item.price ?? "") ?? 0))
                                    .font(.apply(.medium, size: 12))
                                    .frame(minWidth: minimumBoxWidth)
                            }
                            
                            Spacer()
                            
                            VStack {
                                
                                Text("status".localized)
                                    .font(.apply(.medium, size: 12))
                                    .frame(minWidth: minimumBoxWidth)

                                Text(description(for: item.statusCode ?? ""))
                                    .font(.apply(.medium, size: 12))
                                    .foregroundStyle(getForegroundColorNotification(m: item))
                                    .frame(minWidth: minimumBoxWidth)
                            }

                            Spacer()
                            

                        }
                        .frame(maxWidth: .infinity)
                    }
                    .padding(.vertical, 12)
                    .padding(.horizontal, 20)
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 16).stroke(lineWidth: 1).fill(Color.white))
                    .background(RoundedRectangle(cornerRadius: 16).fill(Color.white))
                    .padding(.horizontal, 15)
                    .onTapGesture {
                        SceneDelegate.getAppCoordinator()?.currentHomeCoordinator?.getOrdersCoordinator().start()
                        UserDefaultController().notifiedOrders?.removeAll(where: { $0.id == item.id })
                    }

                } else if item.objectType == "n" && selectedTab.wrappedValue == .news {
                    VStack(spacing: 4) {
                        HStack {
                            WebImage(url: URL(string: "\(UserDefaultController().iconPath ?? "")/\(item.symbol ?? "").png")) { phase in
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
                                        .padding(.horizontal, 4)
                                        .foregroundStyle(.gray)
                                @unknown default:
                                    Image("ic_selectStock")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(maxWidth: 45, maxHeight: 45)
                                        .padding(.horizontal, 4)
                                        .foregroundStyle(.gray)
                                }
                            }
                            HStack {

                                Text("\(item.symbol ?? "")")
                                    .font(.apply(.semiBold, size: 14))
                                    .foregroundStyle(Color.colorTextSecondary)
                            }
                            .padding(.horizontal, 4)

                            Spacer()
                        }
                        
                        VStack(spacing: 0) {
                            Text("\(item.newsTitle ?? "")")
                                .font(.apply(.medium, size: 12))
                                .frame(minWidth: minimumBoxWidth)
                            
                            Text("\(item.newsDesc ?? "")")
                                .font(.apply(.medium, size: 12))
                                .frame(minWidth: minimumBoxWidth)

                        }
                        .frame(maxWidth: .infinity)
                    }
                    .padding(.vertical, 12)
                    .padding(.horizontal, 20)
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 16).stroke(lineWidth: 1).fill(Color.white))
                    .background(RoundedRectangle(cornerRadius: 16).fill(Color.white))
                    .padding(.horizontal, 15)

                }
            }

        }
    }

    func description(for statusCode: String?) -> String {
        guard let code = statusCode else { return "" }
        return AppUtility.shared.isRTL ? filteredOSSList.wrappedValue?.first(where: { $0.id == code })?.descA ?? "" : filteredOSSList.wrappedValue?.first(where: { $0.id == code })?.descE ?? ""
    }


}

func getForegroundColorNotification(m: NotificationObject) -> Color {
    switch m.statusCode?.lowercased() {
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
