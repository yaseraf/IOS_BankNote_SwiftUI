//
//  TopUpContentView.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 08/09/2025.
//

import Foundation
import SwiftUI

struct TopUpContentView: View {
    
    @State var topUpBalance: String = "0.00"
    @State var feesAmount: Double = 0
    @State var totalAmount: Double = 0
    
    var transactionType: Binding<TransactionTypes?>
    
    
    var onContinueTap:()->Void
    var onBackTap:()->Void
    
    var body: some View {
        VStack {
            HeaderView()
            
            dismissView
            
            amountView
            
            if transactionType.wrappedValue == .topUp {
                serviceFeesView
                
                totalAmountView
            } else {
                Spacer()
            }

            numberPadView
            
            Spacer()
        }
    }
        
    private var dismissView: some View {
        Button(action: {
            onBackTap()
        }) {
            HStack {
                Image("ic_close")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 35, height: 35)
                    .background(RoundedRectangle(cornerRadius: 4).fill(.white))
            
                Spacer()
            }
            .padding(.horizontal, 18)
        }
    }
    
    private var amountView: some View {
        VStack(spacing: 0) {
            Text(transactionType.wrappedValue == .topUp ? "top_up_balance".localized : "balance".localized)
                .font(.cairoFont(.bold, size: 32))
                .foregroundStyle(.black)
            
            Text("enter_amount".localized)
                .font(.cairoFont(.semiBold, size: 18))
                .foregroundStyle(.black)

            Text("\(topUpBalance) \("egp".localized)")
                .font(.cairoFont(.bold, size: 32))
                .foregroundStyle(.black)
        }
    }
    
    private var serviceFeesView: some View {
        HStack {
            HStack {
                Text("service_fees".localized)
                    .font(.cairoFont(.semiBold, size: 14))
                
                Image("ic_info")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 18, height: 18)
            }
            
            Spacer()
            
            Text("\("egp".localized) \(AppUtility.shared.formatThousandSeparator(number: feesAmount))")
        }
        .padding(.horizontal, 18)
    }
    
    private var totalAmountView: some View {
        HStack {
            Text("total_amount".localized)
                .font(.cairoFont(.semiBold, size: 14))
            
            Spacer()
            
            Text("\("egp".localized) \(AppUtility.shared.formatThousandSeparator(number: totalAmount))")
                .font(.cairoFont(.semiBold, size: 14))
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(RoundedRectangle(cornerRadius: 99).fill(.white))
        .padding(.horizontal, 18)
        .padding(.bottom, 34)
        
    }
    
    private var numberPadView: some View {
        VStack(spacing: 12) {
            HStack {
                Button(action: {
                    if Double(topUpBalance) ?? 0 <= 0 {
                        topUpBalance.removeAll()
                    }
                    topUpBalance.append("1")
                }, label: {
                    Text("1")
                        .font(.cairoFont(.semiBold, size: 18))
                        .foregroundStyle(.black)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 50)
                        .background(RoundedRectangle(cornerRadius: 99).fill(Color(hex: "#DDDDDD")))
                })
                Button {
                    if Double(topUpBalance) ?? 0 <= 0 {
                        topUpBalance.removeAll()
                    }
                    topUpBalance.append("2")
                } label: {
                    Text("2")
                        .font(.cairoFont(.semiBold, size: 18))
                        .foregroundStyle(.black)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 50)
                        .background(RoundedRectangle(cornerRadius: 99).fill(Color(hex: "#DDDDDD")))
                }

                Button {
                    if Double(topUpBalance) ?? 0 <= 0 {
                        topUpBalance.removeAll()
                    }
                    topUpBalance.append("3")
                } label: {
                    Text("3")
                        .font(.cairoFont(.semiBold, size: 18))
                        .foregroundStyle(.black)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 50)
                        .background(RoundedRectangle(cornerRadius: 99).fill(Color(hex: "#DDDDDD")))
                }

            }
            
            HStack {
                Button {
                    if Double(topUpBalance) ?? 0 <= 0 {
                        topUpBalance.removeAll()
                    }
                    topUpBalance.append("4")
                } label: {
                    Text("4")
                        .font(.cairoFont(.semiBold, size: 18))
                        .foregroundStyle(.black)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 50)
                        .background(RoundedRectangle(cornerRadius: 99).fill(Color(hex: "#DDDDDD")))
                }

                Button {
                    if Double(topUpBalance) ?? 0 <= 0 {
                        topUpBalance.removeAll()
                    }
                    topUpBalance.append("5")
                } label: {
                    Text("5")
                        .font(.cairoFont(.semiBold, size: 18))
                        .foregroundStyle(.black)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 50)
                        .background(RoundedRectangle(cornerRadius: 99).fill(Color(hex: "#DDDDDD")))
                }

                
                Button {
                    if Double(topUpBalance) ?? 0 <= 0 {
                        topUpBalance.removeAll()
                    }
                    topUpBalance.append("6")
                } label: {
                    Text("6")
                        .font(.cairoFont(.semiBold, size: 18))
                        .foregroundStyle(.black)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 50)
                        .background(RoundedRectangle(cornerRadius: 99).fill(Color(hex: "#DDDDDD")))
                }

            }
            
            HStack {
                Button {
                    if Double(topUpBalance) ?? 0 <= 0 {
                        topUpBalance.removeAll()
                    }
                    topUpBalance.append("7")
                } label: {
                    Text("7")
                        .font(.cairoFont(.semiBold, size: 18))
                        .foregroundStyle(.black)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 50)
                        .background(RoundedRectangle(cornerRadius: 99).fill(Color(hex: "#DDDDDD")))
                }

                
                Button {
                    if Double(topUpBalance) ?? 0 <= 0 {
                        topUpBalance.removeAll()
                    }
                    topUpBalance.append("8")
                } label: {
                    Text("8")
                        .font(.cairoFont(.semiBold, size: 18))
                        .foregroundStyle(.black)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 50)
                        .background(RoundedRectangle(cornerRadius: 99).fill(Color(hex: "#DDDDDD")))
                }

                Button {
                    if Double(topUpBalance) ?? 0 <= 0 {
                        topUpBalance.removeAll()
                    }
                    topUpBalance.append("9")
                } label: {
                    Text("9")
                        .font(.cairoFont(.semiBold, size: 18))
                        .foregroundStyle(.black)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 50)
                        .background(RoundedRectangle(cornerRadius: 99).fill(Color(hex: "#DDDDDD")))
                }

            }
            
            HStack {
                Button {
                    if Double(topUpBalance) ?? 0 <= 0 {
                        topUpBalance.removeAll()
                    }
                    topUpBalance.append(".")
                } label: {
                    Text(".")
                        .font(.cairoFont(.semiBold, size: 18))
                        .foregroundStyle(.black)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 50)
                        .background(RoundedRectangle(cornerRadius: 99).fill(Color(hex: "#DDDDDD")))
                }

                
                Button {
                    if Double(topUpBalance) ?? 0 <= 0 {
                        topUpBalance.removeAll()
                    }
                    topUpBalance.append("0")
                } label: {
                    Text("0")
                        .font(.cairoFont(.semiBold, size: 18))
                        .foregroundStyle(.black)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 50)
                        .background(RoundedRectangle(cornerRadius: 99).fill(Color(hex: "#DDDDDD")))
                        .frame(maxWidth: 112, maxHeight: 54)

                }

                
                ZStack {
                    Image("ic_erase")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                }
                .frame(maxWidth: 112, maxHeight: 54)
                .background(RoundedRectangle(cornerRadius: 99).fill(Color(hex: "#DDDDDD")))
                .onTapGesture {
                    if !topUpBalance.isEmpty {
                        topUpBalance.removeLast()
                    }
                }


            }
            
            Button {
                onContinueTap()
            } label: {
                Text("continue".localized)
                    .font(.cairoFont(.semiBold, size: 18))
                    .foregroundStyle(.white)
                    .frame(minHeight: 51)
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 99).fill(Color.colorPrimary))
                    .padding(.horizontal, 18)
            }

        }
    }
}

#Preview {
    TopUpContentView(transactionType: .constant(.withdrawal), onContinueTap: {
        
    }, onBackTap: {
        
    })
}
