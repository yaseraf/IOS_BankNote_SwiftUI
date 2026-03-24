//
//  StatementContentView.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 09/03/2026.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct StatementsContentView: View {
    
    @Binding var listMyStatements:[GetStatementOfAccountUIModel]?
    
    var onBackTap:()->Void
    
    var body: some View {
        VStack {
            HeaderView()
                
            titleView
            
            statementsListView
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
            
            Text("statements".localized)
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

    
    private var statementsListView: some View {
        VStack {
            
            VStack {
                HStack {
                    Text("starting_balance".localized)
                    
                    Spacer()
                    
                    Text("\(listMyStatements?.first?.CUR_CODE ?? "") \(AppUtility.shared.formatThousandSeparator(number: listMyStatements?.first?.balance ?? 0))")
                }
            }
            .padding()
            .background(
             RoundedRectangle(cornerRadius: 20)
                 .fill(Color.colorBGPrimary)
            )
             .background(
                 RoundedRectangle(cornerRadius: 20)
                     .stroke(Color.colorBorderSecondary,lineWidth: 2)
             )
            
            VStack {
                HStack {
                    Text("ending_balance".localized)
                    
                    Spacer()
                    
                    Text("\(listMyStatements?.last?.CUR_CODE ?? "") \(AppUtility.shared.formatThousandSeparator(number: listMyStatements?.last?.balance ?? 0))")
                }
            }
            .padding()
            .background(
             RoundedRectangle(cornerRadius: 20)
                 .fill(Color.colorBGPrimary)
            )
             .background(
                 RoundedRectangle(cornerRadius: 20)
                     .stroke(Color.colorBorderSecondary,lineWidth: 2)
             )
            
            LazyVStack(){
                
                HStack {
                    Image("ic_selectStock")
                        .opacity(0)
                    
                    VStack(alignment: .leading){
                         HStack{
                             Text("credit".localized)
    //                                .foregroundStyle(Color.colorSuccess2)
                             Text("/")
                             
                             Text("debit".localized)
    //                                .foregroundStyle(Color.colorError)
                         }
                        Text("remarks".localized)
                     }
                    
                    Spacer()
                    
                    Text("balance".localized)
                }
                .font(.system(size: 14, weight: .bold))
                .padding(.horizontal,20)
                .padding(.top)
                
                Divider()
                
                ForEach(Array((listMyStatements ?? []).dropFirst(1).dropLast(1).enumerated().reversed()), id: \.offset) {index, element in
                    statementCellView(element, list: listMyStatements ?? [], index: index)
                }
             }
            .background(
             RoundedRectangle(cornerRadius: 20)
                 .fill(Color.colorBGPrimary)
            )
             .background(
                 RoundedRectangle(cornerRadius: 20)
                     .stroke(Color.colorBorderSecondary,lineWidth: 2)
             )
        }

    }
    
    private func statementCellView(_ data:GetStatementOfAccountUIModel, list:[GetStatementOfAccountUIModel], index: Int) -> some View {
        
        let buySellFlag = data.status ?? "-"
        let currency = AppUtility.shared.isRTL ? data.curNameA ?? "-" : data.curNameE ?? "-"
        let date = data.postDate?.dropFirst(6).dropLast(2) ?? "-"
        
        var value = 0.0
        var isDebit = false
        if data.dbAmt == 0 {
            value = data.crAmt ?? 0
            isDebit = false
        }
        if data.crAmt == 0 {
            value = data.dbAmt ?? 0
            isDebit = true
        }
        
        //debugPrint("Image link: \(UserDefaultController().iconPath ?? "" + "\"" + iconID)")
        
      return  HStack(spacing:16){

          WebImage(url: URL(string: "\(UserDefaultController().iconPath ?? "")/\(data.symbol ?? "").png")) { phase in
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
                      Text("\(data.CUR_CODE ?? "") \(value.format2Fraction)")
                          .foregroundColor(isDebit ? .colorError : .colorPrimary)
                          .font(.apply(.semiBold,size:15))
                      
                      Text("\(AppUtility.shared.isRTL ? data.remarkA ?? "" : data.remarkE ?? "")")
                          .foregroundColor(.colorTextPrimary)
                          .font(.apply(.semiBold,size:15))

//                      Text("\(convertMillisecondsToDate(Int64(date) ?? 0) ?? "")")
                      Text("\(convertStatementDateFormat(inputDateString: String(date)) ?? "")")
                          .foregroundColor(.colorTextSecondary)
                          .font(.apply(size:13))
                  }

                  Spacer()
                                  
                  Text("\(data.balance ?? 0, specifier: "%.2f")")
                      .foregroundColor(isDebit ? .colorError : .colorPrimary)
                      .font(.apply(.semiBold,size:15))
                  
//                  Text("\(model.moneyTransactionType.rawValue) \(model.amountWithCurrency)")
//                      .foregroundColor(model.moneyTransactionType == .plus ?  .colorSuccess2 : .colorError)
//                      .font(.apply(.semiBold,size:15))
              }.padding(.vertical,16)

//              if index < list.count - 1{
//                  Divider()
//                      .frame(maxWidth: .infinity)
//
//              }
              
              if index < list.count - 1 {
                  SeparatorCustomView()
//                      .padding(.vertical,20)
              }
          }
        }
          .padding(.horizontal,20)
    }
    
    func convertStatementDateFormat(inputDateString: String) -> String? {
        let regex = try! NSRegularExpression(pattern: "(\\d+)([+-]\\d{4})")
        if let match = regex.firstMatch(in: inputDateString, range: NSRange(inputDateString.startIndex..., in: inputDateString)) {
            // Extract timestamp and timezone components
            let timestampString = String(inputDateString[Range(match.range(at: 1), in: inputDateString)!])
            let timeZoneString = String(inputDateString[Range(match.range(at: 2), in: inputDateString)!])
            
            if let timestampMillis = Double(timestampString) {
                let timestampSeconds = timestampMillis / 1000 // Convert milliseconds to seconds
                let date = Date(timeIntervalSince1970: timestampSeconds) // Create a Date object
                
                // Calculate the time zone offset in seconds
                let sign = timeZoneString.first == "+" ? 1 : -1
                let hours = Int(timeZoneString.dropFirst().prefix(2)) ?? 0
                let minutes = Int(timeZoneString.suffix(2)) ?? 0
                let timeZoneOffset = sign * ((hours * 3600) + (minutes * 60))
                
                // Set up the DateFormatter
                let formatter = DateFormatter()
                formatter.dateFormat = "dd/MM/yyyy" // Desired format
                formatter.locale = Locale(identifier: "en_US_POSIX")
                formatter.timeZone = TimeZone(secondsFromGMT: timeZoneOffset) // Dynamic time zone
                let formattedDate = formatter.string(from: date)

                return formattedDate
            } else {
                return "-"
            }
        } else {
            return "-"
        }
    }


}
