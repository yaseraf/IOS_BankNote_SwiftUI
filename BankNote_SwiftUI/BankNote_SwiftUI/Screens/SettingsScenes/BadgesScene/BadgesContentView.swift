//
//  BadgesContentView.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 11/09/2025.
//

import Foundation
import SwiftUI

struct BadgesContentView: View {
 
    
    @State private var expandedBadgeName: String? = "Pioneer"
    
    @Binding var badgesData: GetBankNotesMainBadgesUIModel
    @Binding var userBadgesData: GetBankNotesBadgesUIModel
    
    @State private var showBadgePopup: Bool = false
    @State private var selectedBadge: GetBankNotesMainBadgesItemUIModel = .init()
    
    let badgeSize: CGFloat = 100
    
    var onBackTap:() -> Void
    
    var body: some View {
        ZStack {
            VStack {
                headerView
                
                Text("unlock_badges_and_elevate_your_game".localized)
                    .font(.cairoFont(.semiBold, size: 18))

                BadgeGridView(
                    badgesData: badgesData,
                    showBadgePopup: $showBadgePopup,
                    selectedBadge: $selectedBadge
                )
                .padding()
                
                Spacer()
            }
            .blur(radius: showBadgePopup ? 5 : 0)
            .overlay{
                if showBadgePopup {
                    badgePopup
                    .onTapGesture {
                        withAnimation {
                            showBadgePopup = false
                        }
                    }
                }
            }
            .onTapGesture {
                withAnimation {
                    showBadgePopup = false
                }
            }
        }
    }
        
    private var badgePopup: some View {
        VStack {
            HStack(alignment: .center) {
                
                VStack {
//                    Image(badges(code: selectedBadge.code ?? "")?.badgeImage ?? "")
                    Image(
                        Badge(
                            rawValue: selectedBadge.code ?? ""
                        )?.image(
                            for: BadgeCategory(
                                subBadgeCode: Badge(
                                    rawValue: selectedBadge.code ?? ""
                                )?.getSubBadgeCode(code: selectedBadge.code ?? "") ?? ""
                            )
                        ) ?? ""
                    )
                    .resizable()
                    .scaledToFit()
                    .frame(width: badgeSize, height: badgeSize)

                    Text(
                        Badge(
                            rawValue: selectedBadge.code ?? ""
                        )?.name(
                            for: BadgeCategory(
                                subBadgeCode: Badge(
                                    rawValue: selectedBadge.code ?? ""
                                )?.getSubBadgeCode(code: selectedBadge.code ?? "") ?? ""
                            )
                        ) ?? ""
                    )
                    .font(.cairoFont(.bold, size: 14))
                }

                Image("ic_rightDoubleArrow")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)

                VStack {
//                    Image(badges(code: selectedBadge.code ?? "")?.badgeImage ?? "")
                    Image(
                        Badge(
                            rawValue: selectedBadge.code ?? ""
                        )?.nextImage(
                            for: BadgeCategory(
                                subBadgeCode: Badge(
                                    rawValue: selectedBadge.code ?? ""
                                )?.getSubBadgeCode(code: selectedBadge.code ?? "") ?? ""
                            )
                        ) ?? ""
                    )
                    .resizable()
                    .scaledToFit()
                    .frame(width: badgeSize, height: badgeSize)

                    Text(
                        Badge(
                            rawValue: selectedBadge.code ?? ""
                        )?.nextName(
                            for: BadgeCategory(
                                subBadgeCode: Badge(
                                    rawValue: selectedBadge.code ?? ""
                                )?.getSubBadgeCode(code: selectedBadge.code ?? "") ?? ""
                            )
                        ) ?? ""
                    )
                        .font(.cairoFont(.bold, size: 14))
                }
            }

            
            VStack(alignment: .leading) {
                Text("\("how_to".localized):")
                    .font(.cairoFont(.bold, size: 16))

                Text(selectedBadge.notes ?? "")
                    .font(.cairoFont(.regular, size: 14))
                    .minimumScaleFactor(0.7)
            }

        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).fill(.white))
        .padding()
        .padding(.horizontal, 16)
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
            
            Text("Badges")
                .font(.cairoFont(.bold, size: 32))

            Spacer()
            
            Image("ic_leftArrow")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .opacity(0)
        }
        .padding()

    }
    
        
    // MARK: Single Badge Card
    struct BadgeCard: View {
        let badge: GetBankNotesMainBadgesItemUIModel

        var body: some View {
            ZStack(alignment: .top) {

                VStack(spacing: 4) {
                    
                    // Icon
//                    Image(badges(code: badge.code ?? "")?.badgeImage ?? "")
                    Image(
                        Badge(
                            rawValue: badge.code ?? ""
                        )?.image(
                            for: BadgeCategory(
                                subBadgeCode: Badge(
                                    rawValue: badge.code ?? ""
                                )?.getSubBadgeCode(
                                    code: badge.code ?? ""
                                ) ?? ""
                            )
                        ) ?? ""
                    )
                    .resizable()
                    .scaledToFit()
//                        .frame(width: 32, height: 32)

                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        

        
    }

    // MARK: Badge Grid View
    struct BadgeGridView: View {
        let badgesData: GetBankNotesMainBadgesUIModel
                
        let columns = Array(repeating: GridItem(.flexible(), spacing: 12), count: 4)

        @Binding var showBadgePopup: Bool
        @Binding var selectedBadge: GetBankNotesMainBadgesItemUIModel

        var body: some View {
            ZStack {
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(badgesData.data?.sorted {(Double($0.code ?? "") ?? 0) < (Double($1.code ?? "") ?? 0)} ?? [] , id:\.id) { badge in
                        Button {
                            withAnimation {
                                showBadgePopup.toggle()
                            }
                            selectedBadge = badge
                        } label: {
                            BadgeCard(badge: badge)
                        }

                    }
                }
                .padding(.horizontal, 12)
            }
        }
    }


    
}


//#Preview {
//    BadgesContentView(onBackTap: {
//        
//    })
//}
