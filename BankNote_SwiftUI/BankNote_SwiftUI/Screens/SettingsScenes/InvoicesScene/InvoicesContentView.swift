//
//  InvoicesContentView.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 09/03/2026.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct InvoicesContentView: View {
    
    @Binding var listMyInvoices:GetInvoicesUIModel?
    
    var onBackTap:()->Void

    var body: some View {
        VStack {
            HeaderView()
                
            titleView
            
            invoicesListView
                .padding()
            
            Spacer()
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
            
            Text("invoices".localized)
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

    
    private var invoicesListView: some View {
        return LazyVStack {
            ForEach(Array(($listMyInvoices.wrappedValue?.invoicesResData ?? []).enumerated()), id: \.offset) {index ,element in
                invoiceCellView(element, list: listMyInvoices?.invoicesResData ?? [], index: index)
            }
        }.background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.colorBGPrimary)
           )
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.colorBorderSecondary,lineWidth: 2)
            )
    }
    
    private func invoiceCellView(_ resData:InvoicesResDataItem, list: [InvoicesResDataItem], index: Int) -> some View {
        
        let buySellFlag = resData.buySellFlag ?? "-"
        let currency = resData.currency ?? "-"
        let date = resData.date ?? "-"
        let iconID = resData.iconID ?? "-"
        let symbolName = resData.symbolName ?? "-"
        let value = resData.net ?? "-"
        
        let dateString = date
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "M/d/yyyy h:mm:ss a" // Input format
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        var formattedDate = ""
        if let date = inputFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "dd/MM/yyyy" // Desired output format
            outputFormatter.locale = Locale(identifier: "en_US_POSIX")
            
            formattedDate = outputFormatter.string(from: date)
        }
        
        //debugPrint("Image link: \(UserDefaultController().iconPath ?? "" + "\"" + iconID)")
        
      return  HStack(spacing:16){

          WebImage(url: URL(string: "\(UserDefaultController().iconPath ?? "")/\(resData.symbolName ?? "").png")) { phase in
              switch phase {
              case .success(let image):
                  image
                      .padding(.horizontal, 4)
                      .foregroundStyle(.gray)
              case .failure:
                  Image("ic_selectStock")
                      .padding(.horizontal, 4)
                      .foregroundStyle(.gray)
              case .empty:
                  Image("ic_selectStock")
                      .padding(.horizontal, 4)
                      .foregroundStyle(.gray)
              @unknown default:
                  Image("ic_selectStock")
                      .padding(.horizontal, 4)
                      .foregroundStyle(.gray)
              }
          }

          VStack {
              HStack {
                  VStack(alignment: .leading,spacing:2){
                      Text("\(buySellFlag == "B" ? "Buy" : "Sell") \(symbolName)")
                          .foregroundColor(.colorTextPrimary)
                          .font(.apply(.semiBold,size:15))

                      Text("\(formattedDate)")
                          .foregroundColor(.colorTextSecondary)
                          .font(.apply(size:13))
                  }

                  Spacer()
                
                  VStack(alignment: .trailing) {
//                      Text("\(resData.invNo ?? "")")
//                          .foregroundColor(.colorFGQuinary)
//                          .font(.apply(.semiBold,size:15))
                      
                      Text("\(currency) \(AppUtility.shared.formatThousandSeparator(number: Double(value) ?? 0))")
                          .foregroundColor(.colorFGQuinary)
                          .font(.apply(.bold,size:15))
                  }
                  
                  RightImageView()
                      .frame(width: 20, height: 20)
                      .foregroundStyle(Color.colorFGQuinary)
                  
//                  Text("\(model.moneyTransactionType.rawValue) \(model.amountWithCurrency)")
//                      .foregroundColor(model.moneyTransactionType == .plus ?  .colorSuccess2 : .colorError)
//                      .font(.apply(.semiBold,size:15))
              }.padding(.top,16)
              
              HStack {
                  Text("\("qty".localized)")
                  
                  Spacer()
                  
                  Text("\("avg_price".localized)")
              }
              .font(.caption)
              .foregroundColor(.gray)

              HStack {
                  Text("\(AppUtility.shared.formatThousandSeparator(number: Double(resData.qty ?? "") ?? 0))")
                  
                  Spacer()
                  
                  Text("\(AppUtility.shared.formatThousandSeparator(number: Double(resData.avgPrice ?? "") ?? 0))")
              }
              .font(.caption)
              .foregroundColor(.gray)

              if index < list.count - 1{
                  Divider()
                      .frame(maxWidth: .infinity)

              }
          }
        }
            .padding(.horizontal,20)


    }


}

//#Preview {
//    InvoicesContentView()
//}
