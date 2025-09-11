//
//  HomeContentView.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 07/09/2025.
//

import Foundation
import SwiftUI

struct HomeContentView: View {
    
    var portfoliosData:Binding<[PortfolioUIModel]?>
    @State var isBalanceHidden:Bool = false
    
    var onTopUpTap:()->Void
    var onWithdrawalTap:()->Void
    
    var body: some View {
        VStack {
            HeaderView()
            
            totalInvestmentView
            
            balanceView
            
            portfolioView
            
            Spacer()
            
            HomeBottomBarView(selectedItem: .home)
        }
//        .background(Color(hex: "#EBEBEB"))
    }
    
        
    private var totalInvestmentView: some View {
        HStack {
            Text("total_investment_value".localized)
                .font(.cairoFont(.semiBold, size: 14))
            
            Image("ic_downArrow")
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .foregroundStyle(Color(hex: "#9C4EF7"))
                .frame(width: 10, height: 10)
        }
        .padding(.vertical, 5)
        .padding(.horizontal, 10)
        .background(RoundedRectangle(cornerRadius: 99).fill(Color(hex: "#DDDDDD")))
    }
    
    private var balanceView: some View {
        
        var viewHistoryAttribute: AttributedString {
            var str = AttributedString("view_history".localized)
            str.underlineStyle = .single
            return str
        }
        
        return VStack(spacing: 8) {
            HStack {
                Text(isBalanceHidden ? "EGP 50,430.00" : "*******")
                    .font(.cairoFont(.bold, size: 32))
                
                Image(isBalanceHidden ? "ic_eyeInvisible" : "ic_eyeVisible")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .onTapGesture {
                        withAnimation {
                            isBalanceHidden.toggle()
                        }
                    }
            }
            
            HStack {
                Text("EGP +450.34")
                    .font(.cairoFont(.semiBold, size: 12))
                    .foregroundStyle(Color(hex: "#1E961E"))
                
                ZStack {
                    Text("+1.172")
                        .font(.cairoFont(.semiBold, size: 12))
                        .foregroundStyle(Color(hex: "#1E961E"))
                }
                .padding(.vertical, 2)
                .padding(.horizontal, 7)
                .background(RoundedRectangle(cornerRadius: 99).fill(Color(hex: "#D4EBCF")))
            }
            
            HStack(spacing: 21) {
                Button {
                    onTopUpTap()
                } label: {
                    VStack(spacing: 4) {
                        Image("ic_topUp")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                        
                        Text("top_up".localized)
                            .font(.cairoFont(.semiBold, size: 10))
                            .foregroundStyle(Color(hex: "#629AF9"))
                    }
                    .padding(.horizontal, 23)
                    .padding(.vertical, 2)
                    .background(RoundedRectangle(cornerRadius: 10).fill(.white))
                }

                Button {
                    onWithdrawalTap()
                } label: {
                    VStack(spacing: 4) {
                        Image("ic_withdrawal")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                        
                        Text("withdrawal".localized)
                            .font(.cairoFont(.semiBold, size: 10))
                            .foregroundStyle(Color(hex: "#9C4EF7"))
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 2)
                    .background(RoundedRectangle(cornerRadius: 10).fill(.white))
                }
            }
            
            Text(viewHistoryAttribute)
                .font(.cairoFont(.semiBold, size: 10))
                .foregroundStyle(Color(hex: "#629AF9"))
        }
    }
    
    private var portfolioView: some View {
        VStack {
            HStack {
                Text("my_portfolio".localized)
                    .font(.cairoFont(.semiBold, size: 18))
                    .foregroundStyle(.black)
                
                ZStack {
                    Text("4")
                        .font(.cairoFont(.semiBold, size: 12))
                }
                .padding(.horizontal, 4)
                .background(RoundedRectangle(cornerRadius: 2).fill(.white))
                
                Spacer()
                
                ZStack {
                    Text("view_all".localized)
                        .font(.cairoFont(.semiBold, size: 14))
                        .foregroundStyle(.black)
                }
                .padding(.vertical, 3)
                .padding(.horizontal, 10)
                .background(RoundedRectangle(cornerRadius: 99).fill(.white))
            }
            .padding(.horizontal, 18)
            
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(Array((portfoliosData.wrappedValue ?? []).enumerated()), id: \.offset) { idnex, element in
                    PortfolioCell(portfolioData: element)
                }
            }
        }
    }
    
}

struct PortfolioCell: View {
    
    var portfolioData: PortfolioUIModel
    
    var body: some View {
        HStack(spacing: 0) {
            HStack(spacing: 16) {
                Image(portfolioData.image ?? "")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 45, height: 45)
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("\(portfolioData.name ?? "")")
                        .font(.cairoFont(.semiBold, size: 14))
                    Text("\("egp".localized) \(AppUtility.shared.formatThousandSeparator(number: portfolioData.price ?? 0))")
                        .font(.cairoFont(.semiBold, size: 12))
                }
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 0) {
                HStack(spacing: 4) {
                    Image(portfolioData.changePerc ?? 0 >= 0 ? "ic_stockUp" : "ic_stockDown")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                    
                    Text("\(portfolioData.changePerc ?? 0 >= 0 ? "+" : "-") \(AppUtility.shared.formatThousandSeparator(number: portfolioData.changePerc ?? 0))%")
                        .font(.cairoFont(.semiBold, size: 12))
                        .foregroundStyle(Color(hex: portfolioData.changePerc ?? 0 >= 0 ? "#1E961E" : "#AA1A1A" ))
                }
                
                
                
                Text("\("egp".localized) \(portfolioData.change ?? 0 >= 0 ? "+" : "-") \(AppUtility.shared.formatThousandSeparator(number: portfolioData.change ?? 0))")
                    .font(.cairoFont(.semiBold, size: 12))
                    .foregroundStyle(Color(hex: portfolioData.changePerc ?? 0 >= 0 ? "#1E961E" : "#AA1A1A" ))

            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .background(RoundedRectangle(cornerRadius: 12).fill(.white))
        .padding(.horizontal, 18)
    }
}



#Preview {
    HomeContentView(portfoliosData: .constant([]), onTopUpTap: {
        
    }, onWithdrawalTap: {
        
    })
}
