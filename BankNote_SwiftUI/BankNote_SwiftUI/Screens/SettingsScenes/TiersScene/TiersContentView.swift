//
//  TiersContentView.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 11/09/2025.
//

import Foundation
import SwiftUI

struct TiersContentView: View {
    
    @Binding var tiersData: GetTiersUIModel
    @Binding var clientBankNotes: String
    @Binding var showInsufficientFunds: Bool
    @Binding var tiers: [Tier]
    
    var onBackTap:()->Void
    var onTierPurchase:(String, String)->Void
    var onTopupTap:()->Void
    
    var body: some View {
        ZStack {
            VStack {
                titleView
                
                if tiers.count > 0 {
                    TierCarouselView(tiers: $tiers, clientBankNotes: $clientBankNotes, showInsufficientFunds: $showInsufficientFunds, onTierPurchase: onTierPurchase)
                }
                
                Spacer()
            }
            // Pop-up overlay
            if showInsufficientFunds {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        showInsufficientFunds = false
                        withAnimation {
                        }
                    }
                insufficientFundsPopup
            }
        }

    }
    
    private var titleView: some View {
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
            
            Text("tiers".localized)
                .font(.cairoFont(.bold, size: 32))
            
            Spacer()
            
            Image("ic_leftArrow")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .opacity(0)
        }
        .padding(.horizontal, 18)
        .padding(.top, 40)
    }
    
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
                showInsufficientFunds = false
                withAnimation {
                }
                onTopupTap()
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

struct Tier: Identifiable {
    let id = UUID().uuidString
    let nameKey: String
    let price: String
    let imageName: String
    let tierCode: String
    let descriptionKeys: [String]
    let howToBecomeKeys: [String]?
    let benefitKeys: [String]
}


//var tiers: [Tier] = [
//    Tier(
//        nameKey: "tier_rookie".localized,
//        imageName: "ic_rookie",
//        descriptionKeys: ["rookie_desc1".localized, "rookie_desc2".localized],
//        howToBecomeKeys: nil,
//        benefitKeys: ["rookie_benefit1".localized, "rookie_benefit2".localized, "rookie_benefit3".localized]
//    ),
//    Tier(
//        nameKey: "tier_casual".localized,
//        imageName: "ic_rookie",
//        descriptionKeys: ["casual_desc1".localized, "casual_desc2".localized],
//        howToBecomeKeys: ["casual_how1".localized, "casual_how2".localized],
//        benefitKeys: ["casual_benefit1".localized, "casual_benefit2".localized, "casual_benefit3".localized, "casual_benefit4".localized, "casual_benefit5".localized]
//    ),
//    Tier(
//        nameKey: "tier_pro".localized,
//        imageName: "ic_rookie",
//        descriptionKeys: ["pro_desc1".localized, "pro_desc2".localized],
//        howToBecomeKeys: ["pro_how1".localized, "pro_how2".localized],
//        benefitKeys: ["pro_benefit1".localized, "pro_benefit2".localized, "pro_benefit3".localized, "pro_benefit4".localized, "pro_benefit5".localized]
//    ),
//    Tier(
//        nameKey: "tier_rolling_star".localized,
//        imageName: "ic_rookie",
//        descriptionKeys: ["rolling_desc1".localized, "rolling_desc2".localized],
//        howToBecomeKeys: ["rolling_how1".localized, "rolling_how2".localized],
//        benefitKeys: ["rolling_benefit1".localized, "rolling_benefit2".localized, "rolling_benefit3".localized, "rolling_benefit4".localized, "rolling_benefit5".localized, "rolling_benefit6".localized]
//    ),
//    Tier(
//        nameKey: "tier_tycoon".localized,
//        imageName: "ic_rookie",
//        descriptionKeys: ["tycoon_desc1".localized, "tycoon_desc2".localized],
//        howToBecomeKeys: ["tycoon_how1".localized, "tycoon_how2".localized],
//        benefitKeys: ["tycoon_benefit1".localized, "tycoon_benefit2".localized, "tycoon_benefit3".localized, "tycoon_benefit4".localized, "tycoon_benefit5".localized, "tycoon_benefit6".localized, "tycoon_benefit7".localized, "tycoon_benefit8".localized]
//    )
//]

let tiersImages = [
    "ic_rookie",
    "ic_casual",
    "ic_pro",
    "ic_rollingStar",
    "ic_tycoon",
    
]

let tiersDisabledImages = [
    "ic_rookieDisable",
    "ic_casualDisable",
    "ic_proDisable",
    "ic_rollingStarDisable",
    "ic_tycoonDisable",
    
]

struct TierCarouselView: View {
    @State private var selectedIndex = 0
    
    @Binding var tiers: [Tier]
    @Binding var clientBankNotes: String
    @Binding var showInsufficientFunds: Bool

    var onTierPurchase:(String, String)->Void

    var body: some View {
        VStack(spacing: 20) {
            // Carousel
            TabView(selection: $selectedIndex) {
                if tiers.isEmpty == false {
                    ForEach(Array(tiers.enumerated()), id: \.element.id) { index, tier in
                        if index < tiersImages.count && index < tiersDisabledImages.count {
                            VStack {
                                Image(
                                    UserDefaultController().tierCode?.isEmpty == false ?
                                    (Double(tier.tierCode) ?? 0) <= (Double(UserDefaultController().tierCode ?? "") ?? 0) ?
                                    tiersImages[index] : tiersDisabledImages[index]
                                    : tiersDisabledImages[index]
                                )
                                .resizable()
                                .scaledToFit()
                                .frame(width: 150, height: 150)
                            }
                            .tag(index)
                        }
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .scaledToFit()
            
            // Custom indicator
            HStack(spacing: 8) {
                ForEach(0..<tiers.count, id: \.self) { index in
                    Capsule()
                        .fill(index == selectedIndex ? Color.purple : Color.gray.opacity(0.3))
                        .frame(width: index == selectedIndex ? 20 : 8, height: 8)
                        .animation(.easeInOut, value: selectedIndex)
                }
            }
            
            // Details of selected tier
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 6) {
                    let tier = tiers[selectedIndex]
                    
//                    Text("Who is \(tier.nameKey)")
                    Text("\(tier.nameKey)")
                        .font(.cairoFont(.semiBold, size: 18))
                        .frame(maxWidth: .infinity, alignment: .leading)

//                    VStack(spacing: 6) {
//                        ForEach(tier.descriptionKeys, id: \.self) { item in
//                            Label(item, systemImage: "circle.fill")
//                                .font(.cairoFont(.semiBold, size: 14))
//                                .labelStyle(.titleOnly) // hide bullet icon
//                                .padding(.leading, 8)
//                        }
//                    }

//                    if let howTo = tier.howToBecomeKeys {
//                        Text("How to become \(tier.nameKey)")
//                            .font(.cairoFont(.semiBold, size: 18))
//
//                        VStack(spacing: 6) {
//                            ForEach(howTo, id: \.self) { item in
//                                Label(item, systemImage: "checkmark.circle.fill")
//                                    .font(.cairoFont(.semiBold, size: 14))
//                                    .foregroundColor(.blue)
//                                    .padding(.leading, 8)
//                            }
//                        }
//                    }
                    
//                    Text("Benefits")
                    Text("notes".localized)
                        .font(.title3).bold()
                    
                    VStack(spacing: 6) {
                        ForEach(Array(tier.benefitKeys.enumerated()), id: \.offset) { index, benefit in
                            HStack(alignment: .top) {
//                                Text("\(index + 1).")
                                Text(benefit)
                            }
                            .font(.cairoFont(.semiBold, size: 14))

                            .padding(.leading, 8)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 18)
                .padding(.bottom, 20)
            }
            
            bottomButtonView
                .opacity((Double(tiers[selectedIndex].tierCode) ?? 0) != (Double(UserDefaultController().tierCode ?? "") ?? 0) ? 1 : 0)
            
        }
        .padding(.top)
    }
    
    private var bottomButtonView: some View {
        Button {
            if (Double(clientBankNotes) ?? 0) >= (Double(tiers[selectedIndex].price) ?? 0) {
                onTierPurchase(tiers[selectedIndex].price, tiers[selectedIndex].tierCode)
            } else {
                showInsufficientFunds.toggle()
            }
            debugPrint("Clicked buy now")
        } label: {
            Text("buy_now".localized)
                .font(.cairoFont(.semiBold, size: 18))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8.5)
                .background(RoundedRectangle(cornerRadius: 99).fill(Color(hex: "#9C4EF7")))
                .padding(.horizontal, 18)
        }
    }
}
//
//#Preview {
//    TiersContentView(
//        tiersData: .constant(.initializer()),
//        tiers: .constant([]),
//        onBackTap: {
//        
//        }
//    )
//}
