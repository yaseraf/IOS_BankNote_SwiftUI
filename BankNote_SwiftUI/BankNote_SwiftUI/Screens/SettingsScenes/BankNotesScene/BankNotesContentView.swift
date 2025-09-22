//
//  BankNotesContentView.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 14/09/2025.
//

import Foundation
import SwiftUI




struct BankNotesContentView: View {
    
    var topUpItems: Binding<[RowItem]>
    var rewardsItems: Binding<[RowItem]>
    @State private var selectedSegment: Segment = .topUp
    @State private var showInsufficientFunds: Bool = false
    
    var onBackTap:()->Void
    var onTopUpTap:()->Void
    
    // An enum to represent our segmented control.
    enum Segment: String, CaseIterable {
        case topUp = "top_up"
        case rewards = "rewards"
    }
    
    // A reusable view for the segment buttons.
    private func segmentButton(title: String, segment: Segment) -> some View {
        Button(action: {
            withAnimation(.spring()) {
                selectedSegment = segment
            }
        }) {
            Text(title)
                .font(.cairoFont(.semiBold, size: 18))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8.5)
                .background(
                    RoundedRectangle(cornerRadius: 4)
                        .fill(selectedSegment == segment ? Color(hex: "#9C4EF7") : Color(hex: "#DDDDDD"))
                )
                .foregroundColor(selectedSegment == segment ? .white : Color(hex: "#828282"))
                .animation(.none, value: selectedSegment) // Disable animation on selection change for text
        }
    }
    
    var body: some View {
        ZStack {
                        
            VStack(spacing: 0) {
                
                headerView
                // Top section with BN Coins
                VStack(spacing: 0) {
                    Image("ic_bnCoin")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 200, maxHeight: 200)
                        .shadow(color: .purple.opacity(0.5), radius: 10, x: 0, y: 5)
                        .background {
                            VStack {
                                Spacer()
                                Image("ic_coinShadow")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 111, height: 7)
                                    .padding(.bottom, 20)
                            }
                        }
                    
                    HStack(spacing: 0) {
                        Text("you_have".localized)
                            .font(.cairoFont(.bold, size: 32))
                        
                        LinearGradient(
                            gradient: Gradient(colors: [Color(hex: "#FC814B"), Color(hex: "#9C4EF7"), Color(hex: "#629AF9")]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                        .frame(maxWidth: 110, maxHeight: 60)
                        .mask{
                            Text("499\("bn".localized)".uppercased())
                                .font(.cairoFont(.bold, size: 32))
                        }

                        Text("coins".localized)
                            .font(.cairoFont(.bold, size: 32))

                    }
                }
                .padding(.bottom, 17)
                
                // Segmented control
                HStack(spacing: 19) {
                    segmentButton(title: Segment.topUp.rawValue.localized, segment: .topUp)
                    segmentButton(title: Segment.rewards.rawValue.localized, segment: .rewards)
                }
                .padding(.horizontal, 18)
                .padding(.bottom, 22)

                
                // Content based on selected segment
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 12) {
                        if selectedSegment == .topUp {
                            ForEach(Array(topUpItems.wrappedValue)) { item in
                                listItem(item: item)
                            }
                        } else {
                            ForEach(Array(rewardsItems.wrappedValue)) { item in
                                listItem(item: item)
                            }
                        }
                    }
                    .frame(maxHeight: .infinity)
                }
            }
            .blur(radius: showInsufficientFunds ? 5 : 0)
            
            // Pop-up overlay
            if showInsufficientFunds {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation {
                            showInsufficientFunds = false
                        }
                    }
                insufficientFundsPopup
            }
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
    
    // A reusable view for a list row.
    private func listItem(item: RowItem) -> some View {
        HStack {
            Text(item.title)
                .font(.cairoFont(.semiBold, size: 18))

            Spacer()
            
            HStack {
                Image("ic_bnCoin")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)

                Text(item.value)
                    .font(.cairoFont(.semiBold, size: 18))
            }
        }
        .padding(.horizontal, 34)
        .padding(.vertical, 16)
        .background(
            Image("topUpBackground")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
                .frame(minHeight: 70)
                .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 5)
        )
        .padding(.top, 2)
        .onTapGesture {
            withAnimation {
                showInsufficientFunds = true
            }
        }
    }
    
    // The pop-up view for insufficient funds.
    private var insufficientFundsPopup: some View {
        VStack(spacing: 16) {
            VStack {
                Text("insufficient_funds_top_up".localized)
                    .font(.cairoFont(.semiBold, size: 18))
                Text("to_continue_purchase".localized)
                    .font(.cairoFont(.semiBold, size: 18))
            }
            .padding(.vertical, 23)
            .padding(.horizontal, 38)
            .frame(maxWidth: .infinity)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color(hex: "#AA1A1A"), lineWidth: 2)
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundStyle(.white)
                }
            )

            Button {
                withAnimation {
                    showInsufficientFunds = false
                }
                onTopUpTap()
            } label: {
                Text("top_up_now".localized)
                    .font(.cairoFont(.semiBold, size: 18))
                    .foregroundStyle(.white)
            }
            .padding(.vertical, 8.5)
            .padding(.horizontal, 36.5)
            .background(RoundedRectangle(cornerRadius: 4).fill(Color(hex: "#9C4EF7")))

        }
        .padding(.horizontal, 54)
        .frame(maxWidth: .infinity)
        .shadow(radius: 20)
        .transition(.scale)
    }
}

#Preview {
    BankNotesContentView(topUpItems: .constant([RowItem(title: "100 EGP", value: "1000 BN", color: .purple, icon: nil), RowItem(title: "150 EGP", value: "1500 BN", color: .purple, icon: nil), RowItem(title: "200 EGP", value: "2000 BN", color: .purple, icon: nil), RowItem(title: "250 EGP", value: "2500 BN", color: .purple, icon: nil), RowItem(title: "300 EGP", value: "3000 BN", color: .purple, icon: nil),]), rewardsItems: .constant([RowItem(title: "1 Month Spotify", value: "1000 BN", color: Color("SpotifyGreen"), icon: "play.circle"), RowItem(title: "25% OFF Netflix", value: "1500 BN", color: Color("NetflixRed"), icon: "play.rectangle")]), onBackTap: {
        
    }, onTopUpTap: {
        
    })
}
