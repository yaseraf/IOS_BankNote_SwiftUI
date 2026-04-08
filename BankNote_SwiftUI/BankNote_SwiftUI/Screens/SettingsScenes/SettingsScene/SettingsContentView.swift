//
//  SettingsContentView.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 10/09/2025.
//

import Foundation
import SwiftUI

struct SettingsContentView: View {
    
    @Binding var clientBankNotes: String
    @Binding var userTier: GetTiersItemUIModel?
    
    var onBankNotesTap:()->Void
    var onTiersTap:()->Void
    var onBadgesTap:()->Void
    var onStatementsTap:()->Void
    var onInvoicesTap:()->Void
    var onTransactionsTap:()->Void
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
    
    func formatDateOnly(_ dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "M/dd/yyyy hh:mm:ss a"
        
        guard let date = formatter.date(from: dateString) else { return dateString }
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "M/dd/yyyy"
        
        return outputFormatter.string(from: date)
    }
    
    private var profileView: some View {
        VStack {
            VStack(spacing: 0) {
                Circle()
                    .fill(Color.gray)
                    .frame(width: 114, height: 114)
                    .overlay {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 114, height: 114)
                    }
                
                HStack {
                    Text(AppUtility.shared.isRTL ? UserDefaultController().selectedUserAccount?.MainClientNameA ?? "" : UserDefaultController().selectedUserAccount?.MainClientNameE ?? "")
                        .font(.cairoFont(.semiBold, size: 14))
                        .minimumScaleFactor(0.5)
                    
                    Image(tiers(code: userTier?.userCode ?? "")?.tierImage ?? "")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 22, height: 22)
                }
                
                Text(AppUtility.shared.isRTL ? userTier?.arabicDescription ?? "" : userTier?.englishDescription ?? "")
                    .font(.cairoFont(.light, size: 12))
            }
            
            HStack {
                HStack {
                    Image("ic_newCoin")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 45, height: 45)
                    
                    VStack(spacing: 0) {
                        Text("HSSLAYA")
                            .font(.cairoFont(.semiBold, size: 18))
                        
                        Text("\(clientBankNotes) B")
                            .font(.cairoFont(.semiBold, size: 18))
                    }
                    .foregroundStyle(.black)
                }

                
                Spacer()
                
                Button {
                    onBankNotesTap()
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
                            
                            Text(AppUtility.shared.isRTL ? userTier?.arabicDescription ?? "" : userTier?.englishDescription ?? "")
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
                        
                        Text("\(formatDateOnly(UserDefaultController().birthdate ?? ""))")
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
                        
                        Text("\(UserDefaultController().gender?.lowercased() == "m" ? "male".localized : "female".localized)")
                            .font(.cairoFont(.semiBold, size: 14))
                    }
                    
                    Spacer()
                    
                    Image("ic_rightArrow")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 22, height: 22)
                }
                
                Divider()
                
                // MARK: - Language
                HStack(spacing: 17) {
                    Image("ic_globe")
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(Color.colorPrimary)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("language".localized)
                            .font(.cairoFont(.semiBold, size: 12))
                        
                        Text("\(AppUtility.shared.isRTL ? "عربي" : "English")")
                            .font(.cairoFont(.semiBold, size: 14))
                    }
                    
                    Spacer()
                    
                    Image("ic_rightArrow")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 22, height: 22)
                }
                .onTapGesture {
                    if AppUtility.shared.isRTL {
                        AppUtility.shared.updateAppLanguage(language: .english)
                    } else {
                        AppUtility.shared.updateAppLanguage(language: .arabic)
                    }
                    SceneDelegate.getAppCoordinator()?.restart()
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
                .onTapGesture {
                    onStatementsTap()
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
                .onTapGesture {
                    onInvoicesTap()
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
                
                Divider()
                
                // Transactions
                Button {
                    onTransactionsTap()
                } label: {
                    HStack(spacing: 17) {
                        Image("ic_badges")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                        
                        Text("buy_transactions".localized)
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

//#Preview {
//    SettingsContentView(clientBankNotes: .constant(""), onBankNotesTap: {
//        
//    }, onTiersTap: {
//        
//    }, onBadgesTap: {
//        
//    }, onTransactionsTap: {
//        
//    }, onHelpTap: {
//        
//    }, onLogoutTap: {
//        
//    })
//}
