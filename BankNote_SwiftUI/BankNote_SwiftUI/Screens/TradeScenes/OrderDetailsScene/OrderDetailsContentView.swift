//
//  OrderDetailsContentView.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 22/10/2025.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct OrderDetailsContentView: View {
    
    var orderPreview:Binding<OrderListUIModel?>
    

    var onCancelTap:()->Void
    var onPlaceOrderTap:()->Void
    var onBackTap:()->Void
    
    var body: some View {
        VStack {
            headerView
            
            titleView
            
            contentView
            
            Spacer()
            
            bottomButtonsView
        }
    }
    
    private var headerView: some View {
        HStack {
            Button {
                onBackTap()
            } label: {
                Image("ic_leftArrow")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
            }

            
            Spacer()
        }
    }
    
    private var titleView: some View {
        VStack {
            WebImage(url: URL(string: "\(UserDefaultController().iconPath ?? "")/\(orderPreview.wrappedValue?.Symbol ?? "").png")) { phase in
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

            Text("\(orderPreview.wrappedValue?.SellBuyFlag?.lowercased() == "b" ? "buy".localized : "sell".localized) \(orderPreview.wrappedValue?.Symbol ?? "")")
                .font(.cairoFont(.bold, size: 28))

            Text("\(orderPreview.wrappedValue?.Symbol ?? "")")
                .font(.cairoFont(.bold, size: 16))

        }
    }
    
    private var contentView: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("order_details".localized)
                .font(.cairoFont(.semiBold, size: 17))

            VStack(spacing: 12) {
                rowView(title: "type".localized, value: orderPreview.wrappedValue?.SellBuyFlag?.lowercased() == "s" ? "sell".localized : "buy".localized)
                rowView(title: "account".localized, value: AppUtility.shared.isRTL ? orderPreview.wrappedValue?.AccountNameA ?? "" : orderPreview.wrappedValue?.AccountNameE ?? "")
                rowView(title: "custodian".localized, value: orderPreview.wrappedValue?.CustodianID ?? "")
                rowView(title: "quantity".localized, value: AppUtility.shared.formatThousandSeparator(number: Double(orderPreview.wrappedValue?.ExecQty ?? "") ?? 0))
                rowView(title: "price".localized, value: orderPreview.wrappedValue?.Price == "0" ? "MKT" : AppUtility.shared.formatThousandSeparator(number: Double(orderPreview.wrappedValue?.Price ?? "") ?? 0))
                rowView(title: "validity_date".localized, value: convertDateString(orderPreview.wrappedValue?.ValidityDate ?? ""))
                rowView(title: "order_value".localized, value: AppUtility.shared.formatThousandSeparator(number: Double(orderPreview.wrappedValue?.OrderValue ?? "") ?? 0))
            }
            .padding(.horizontal, 18)
            .padding(.vertical, 12)

            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 14).fill(.white)
                    RoundedRectangle(cornerRadius: 14).stroke(lineWidth: 1).fill(Color(hex: "#EAEDF0"))
                }
            )

        }
        .padding(.horizontal, 18)

    }
    
    private func rowView(title:String, value:String) -> some View {
        HStack {
            Text(title)
                .foregroundColor(.black)
            Spacer()
            Text(value)
                .foregroundStyle(Color(hex: "#828282"))
        }
        .font(.cairoFont(.medium, size: 15))

    }
    
    private var bottomButtonsView: some View {
        HStack {
            Button {
                onCancelTap()
            } label: {
                Text("cancel".localized)
                    .font(.cairoFont(.semiBold, size: 17))
                    .foregroundStyle(.black)
                    .frame(maxWidth: .infinity)
                    .frame(minHeight: 50)
                    .background(RoundedRectangle(cornerRadius: 14).fill(Color(hex: "#DDDDDD")))
            }

            Button {
                onPlaceOrderTap()
            } label: {
                Text("place_order".localized)
                    .font(.cairoFont(.semiBold, size: 17))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(minHeight: 50)
                    .background(RoundedRectangle(cornerRadius: 14).fill(Color(hex: "#9C4EF7")))
            }

        }
        .padding(.horizontal, 18)
    }
    
    func convertDateString(_ dateString: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "ddMMyyyyHHmmss"
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd/MM/yyyy"

        if let date = inputFormatter.date(from: dateString) {
            return outputFormatter.string(from: date)
        } else {
            return dateString // fallback if parsing fails
        }
    }
}

#Preview {
    OrderDetailsContentView(orderPreview: .constant(.initializer()), onCancelTap: {
        
    }, onPlaceOrderTap: {
        
    }, onBackTap: {
        
    })
}
