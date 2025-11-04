//
//  SettingsContentView.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 10/09/2025.
//

import Foundation
import SwiftUI

struct SettingsContentView: View {
    
    var onBankNotesTap:()->Void
    var onTiersTap:()->Void
    var onBadgesTap:()->Void
    var onHelpTap:()->Void
    var onLogoutTap:()->Void
    
    var body: some View {
        ZStack {
            VStack {
                HeaderView()
                
                profileView
                
                ScrollView(.vertical, showsIndicators: false) {
                    accountInfoView
                        .padding(.bottom, 12)
                    
                    appInfoView
                    
                }
                .padding(.bottom, 100)
                
                Spacer()
                
            }
            
            VStack {
                Spacer()
                
                HomeBottomBarView(selectedItem: .settings)
            }
        }
    }
    
    private var profileView: some View {
        VStack {
            VStack(spacing: 0) {
                Circle()
                    .fill(Color.gray)
                    .frame(width: 114, height: 114)
                    .overlay {
                        Image("ic_johnDou")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 114, height: 114)
                    }
                
                HStack {
                    Text("John Dou")
                        .font(.cairoFont(.semiBold, size: 18))
                    
                    Image("ic_badges")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 22, height: 22)
                }
                
                Text("Rookie")
                    .font(.cairoFont(.light, size: 12))
            }
            
            HStack {
                Button {
                    onBankNotesTap()
                } label: {
                    Image("ic_bnCoin")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 45, height: 45)
                    
                    VStack(spacing: 0) {
                        Text("XNTRQ".localized)
                            .font(.cairoFont(.semiBold, size: 18))
                        
                        Text("1,500.00 BN")
                            .font(.cairoFont(.semiBold, size: 18))
                    }
                    .foregroundStyle(.black)
                }

                
                Spacer()
                
                Button {
                    
                } label: {
                    Text("view_details".localized)
                        .font(.cairoFont(.semiBold, size: 14))
                        .foregroundStyle(.black)
                        .padding(.vertical, 3)
                        .padding(.horizontal, 10)
                        .background(RoundedRectangle(cornerRadius: 12).fill(.white))
                }

            }
            .padding(.horizontal, 18)
        }
    }
    
    private var accountInfoView: some View {
        VStack(spacing: 8) {
            HStack {
                Text("account_info".localized)
                    .font(.cairoFont(.semiBold, size: 18))
                
                Spacer()
            }
            
            VStack(spacing: 10) {
                
                // Tiers
                Button {
                    onTiersTap()
                } label: {
                    HStack(spacing: 17) {
                        Image("ic_tiers")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                        
                        VStack(alignment: .leading, spacing: 0) {
                            Text("tiers".localized)
                                .font(.cairoFont(.semiBold, size: 12))
                            
                            Text("rookie".localized)
                                .font(.cairoFont(.semiBold, size: 14))
                        }
                        .foregroundStyle(.black)
                        
                        Spacer()
                        
                        Image("ic_rightArrow")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 22, height: 22)
                    }
                }

                
                Divider()
                
                // Phone Number
                HStack(spacing: 17) {
                    Image("ic_phone")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("phone_number".localized)
                            .font(.cairoFont(.semiBold, size: 12))
                        
                        Text("01234567898".localized)
                            .font(.cairoFont(.semiBold, size: 14))
                    }
                    
                    Spacer()
                    
                    Image("ic_rightArrow")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 22, height: 22)
                }
                
                Divider()
                
                // Name
                HStack(spacing: 17) {
                    Image("ic_person")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("name".localized)
                            .font(.cairoFont(.semiBold, size: 12))
                        
                        Text("John Dou".localized)
                            .font(.cairoFont(.semiBold, size: 14))
                    }
                    
                    Spacer()
                    
                    Image("ic_rightArrow")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 22, height: 22)
                }
                
                Divider()
                
                // Date
                HStack(spacing: 17) {
                    Image("ic_calendar")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("date_of_birth".localized)
                            .font(.cairoFont(.semiBold, size: 12))
                        
                        Text("September 20, 1999".localized)
                            .font(.cairoFont(.semiBold, size: 14))
                    }
                    
                    Spacer()
                    
                    Image("ic_rightArrow")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 22, height: 22)
                }
                
                Divider()
                
                // Gender
                HStack(spacing: 17) {
                    Image("ic_gender")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("gender".localized)
                            .font(.cairoFont(.semiBold, size: 12))
                        
                        Text("male".localized)
                            .font(.cairoFont(.semiBold, size: 14))
                    }
                    
                    Spacer()
                    
                    Image("ic_rightArrow")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 22, height: 22)
                }
                
                Divider()
                
                // Statement
                HStack(spacing: 17) {
                    Image("ic_statement")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                    
                    Text("statement".localized)
                        .font(.cairoFont(.semiBold, size: 12))
                    
                    Spacer()
                    
                    Image("ic_rightArrow")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 22, height: 22)
                }
                
                Divider()
                
                // Invoice
                HStack(spacing: 17) {
                    Image("ic_invoice")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                    
                    Text("invoice".localized)
                        .font(.cairoFont(.semiBold, size: 12))
                    
                    Spacer()
                    
                    Image("ic_rightArrow")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 22, height: 22)
                }
                
                Divider()
                
                // Badges
                Button {
                    onBadgesTap()
                } label: {
                    HStack(spacing: 17) {
                        Image("ic_badges")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                        
                        Text("badges".localized)
                            .font(.cairoFont(.semiBold, size: 12))
                            .foregroundStyle(.black)
                        
                        Spacer()
                        
                        Image("ic_rightArrow")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 22, height: 22)
                    }
                }

                
            }
            .padding(16)
            .background(RoundedRectangle(cornerRadius: 10).fill(.white))

        }
        .padding(.horizontal, 18)
    }
    
    private var appInfoView: some View {
        VStack(spacing: 8) {
            HStack {
                Text("app_info_and_help".localized)
                    .font(.cairoFont(.semiBold, size: 18))
                
                Spacer()
            }
            
            VStack(spacing: 10) {
                
                // Help and feedback
                Button {
                    onHelpTap()
                } label: {
                    HStack(spacing: 17) {
                        Image("ic_help")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                        
                        Text("help_and_feedback".localized)
                            .font(.cairoFont(.semiBold, size: 12))
                            .foregroundStyle(.black)
                        
                        Spacer()
                        
                        Image("ic_rightArrow")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 22, height: 22)
                    }
                }

                
                Divider()
                
                // Terms of Service
                HStack(spacing: 17) {
                    Image("ic_termsOfService")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                    
                    Text("terms_of_service".localized)
                        .font(.cairoFont(.semiBold, size: 12))
                    
                    Spacer()
                    
                    Image("ic_rightArrow")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 22, height: 22)
                }
                
                Divider()
                
                // Privacy Policy
                HStack(spacing: 17) {
                    Image("ic_privacyPolicy")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                    
                    Text("privacy_policy".localized)
                        .font(.cairoFont(.semiBold, size: 12))
                    
                    Spacer()
                    
                    Image("ic_rightArrow")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 22, height: 22)
                }
                
                Divider()
                
                // Privacy Policy
                HStack(spacing: 17) {
                    Image("ic_aboutUs")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                    
                    Text("about_us".localized)
                        .font(.cairoFont(.semiBold, size: 12))
                    
                    Spacer()
                    
                    Image("ic_rightArrow")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 22, height: 22)
                }
                
                Divider()
                
                // Help
                HStack(spacing: 17) {
                    Image("ic_help")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                    
                    Text("help".localized)
                        .font(.cairoFont(.semiBold, size: 12))
                    
                    Spacer()
                    
                    Image("ic_rightArrow")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 22, height: 22)
                }
                
                Divider()
                
                // Rating App
                HStack(spacing: 17) {
                    Image("ic_ratingApp")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                    
                    Text("rating_app".localized)
                        .font(.cairoFont(.semiBold, size: 12))
                    
                    Spacer()
                    
                    Image("ic_rightArrow")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 22, height: 22)
                }
                
                Divider()
                
                // Logout
                Button {
                    onLogoutTap()
                } label: {
                    HStack(spacing: 17) {
                        Image("ic_logout")
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(Color(hex: "#9C4EF7"))
                            .frame(width: 24, height: 24)
                        
                        Text("logout".localized)
                            .font(.cairoFont(.semiBold, size: 12))
                            .foregroundStyle(.black)
                        
                        Spacer()
                        
                        Image("ic_rightArrow")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 22, height: 22)
                    }

                }


            }
            .padding(16)
            .background(RoundedRectangle(cornerRadius: 10).fill(.white))
            
        }
        .padding(.horizontal, 18)
    }
}

#Preview {
    SettingsContentView(onBankNotesTap: {
        
    }, onTiersTap: {
        
    }, onBadgesTap: {
        
    }, onHelpTap: {
        
    }, onLogoutTap: {
        
    })
}
