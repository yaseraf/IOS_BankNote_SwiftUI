//
//  SettingsContentView.swift
//  BankNote_SwiftUI
//
//  Created by FIT on 10/09/2025.
//

import Foundation
import SwiftUI
import StoreKit
//import Inject

struct SettingsContentView: View {
    
//    @ObserveInjection var redraw

    @Binding var clientBankNotes: String
    @Binding var userTier: GetTiersItemUIModel?
    
    @State private var showInviteSheet = false
    @State private var showPromoSheet = false
    
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
                .padding(.bottom, 75)
                
                Spacer()
                
            }
            
            VStack {
                Spacer()
                
                HomeBottomBarView(selectedItem: .settings)
            }
            
            if showInviteSheet || showPromoSheet {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture {
                        showInviteSheet = false
                        showPromoSheet = false
                    }
                
                if showInviteSheet {
                    InviteAFriendSheet {
                        showInviteSheet = false
                    }
                    .padding(.horizontal, 24)
                    .background(RoundedRectangle(cornerRadius: 20).fill(.white))
                    .padding(.horizontal, 24)
                    .fixedSize(horizontal: false, vertical: true)
                    .transition(.scale.combined(with: .opacity))
                }
                
                if showPromoSheet {
                    PromoCodeSheet {
                        showPromoSheet = false
                    }
                    .padding(.horizontal, 24)
                    .background(RoundedRectangle(cornerRadius: 20).fill(.white))
                    .padding(.horizontal, 24)
//                    .fixedSize(horizontal: false, vertical: true)
                    .transition(.scale.combined(with: .opacity))
                }
            }
        }
        .animation(.easeInOut(duration: 0.2), value: showInviteSheet)
        .animation(.easeInOut(duration: 0.2), value: showPromoSheet)
//        .enableInjection()
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
                        
                        Text("\(clientBankNotes) H")
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
                        
                        Image(AppUtility.shared.isRTL ? "ic_leftArrow" : "ic_rightArrow")
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
                    
//                    Image(AppUtility.shared.isRTL ? "ic_leftArrow" : "ic_rightArrow")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 22, height: 22)
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
                    
//                    Image(AppUtility.shared.isRTL ? "ic_leftArrow" : "ic_rightArrow")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 22, height: 22)
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
                    
//                    Image(AppUtility.shared.isRTL ? "ic_leftArrow" : "ic_rightArrow")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 22, height: 22)
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
                    
//                    Image(AppUtility.shared.isRTL ? "ic_leftArrow" : "ic_rightArrow")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 22, height: 22)
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
                    
                    Image(AppUtility.shared.isRTL ? "ic_leftArrow" : "ic_rightArrow")
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
                    
                    Image(AppUtility.shared.isRTL ? "ic_leftArrow" : "ic_rightArrow")
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
                    
                    Image(AppUtility.shared.isRTL ? "ic_leftArrow" : "ic_rightArrow")
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
                        
                        Image(AppUtility.shared.isRTL ? "ic_leftArrow" : "ic_rightArrow")
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
                        
                        Image(AppUtility.shared.isRTL ? "ic_leftArrow" : "ic_rightArrow")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 22, height: 22)
                    }
                }
                
                Divider()
                
                // Invite a friend
                Button {
//                    onInviteAFriendTap()
                    showInviteSheet = true
                    
                } label: {
                    HStack(spacing: 17) {
                        Image("ic_inviteAFriend")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                        
                        Text("invite_a_friend".localized)
                            .font(.cairoFont(.semiBold, size: 12))
                            .foregroundStyle(.black)
                        
                        Spacer()
                        
                        Image(AppUtility.shared.isRTL ? "ic_leftArrow" : "ic_rightArrow")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 22, height: 22)
                    }
                }
                
                Divider()
                
                // Promo Code
                Button {
//                    onPromoCodeTap()
                    showPromoSheet = true
                    
                } label: {
                    HStack(spacing: 17) {
                        Image(systemName: "ticket.fill")
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .foregroundStyle(Color(hex: "#9C4EF7"))
                        
                        Text("promo_codes".localized)
                            .font(.cairoFont(.semiBold, size: 12))
                            .foregroundStyle(.black)
                        
                        Spacer()
                        
                        Image(AppUtility.shared.isRTL ? "ic_leftArrow" : "ic_rightArrow")
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
                        
                        Image(AppUtility.shared.isRTL ? "ic_leftArrow" : "ic_rightArrow")
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
                    
//                    Image(AppUtility.shared.isRTL ? "ic_leftArrow" : "ic_rightArrow")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 22, height: 22)
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
                    
//                    Image(AppUtility.shared.isRTL ? "ic_leftArrow" : "ic_rightArrow")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 22, height: 22)
                }
                
                Divider()
                
                // About Us
                HStack(spacing: 17) {
                    Image("ic_aboutUs")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                    
                    Text("about_us".localized)
                        .font(.cairoFont(.semiBold, size: 12))
                    
                    Spacer()
                    
//                    Image(AppUtility.shared.isRTL ? "ic_leftArrow" : "ic_rightArrow")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 22, height: 22)
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
                    
//                    Image(AppUtility.shared.isRTL ? "ic_leftArrow" : "ic_rightArrow")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 22, height: 22)
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
                    
                    Image(AppUtility.shared.isRTL ? "ic_leftArrow" : "ic_rightArrow")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 22, height: 22)
                }
                .onTapGesture {
                    if let scene = UIApplication.shared.connectedScenes
                        .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                        SKStoreReviewController.requestReview(in: scene)
                    }
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
                        
                        Image(AppUtility.shared.isRTL ? "ic_leftArrow" : "ic_rightArrow")
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

struct InviteAFriendSheet: View {

    var onDismiss: () -> Void

    @State private var copied = false
    private let referralLink = "Https://\(UserDefaultController().username ?? "Username").Banknote"

    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 10) {
                VStack(spacing: 0) {
                    Text("share_with_friends".localized)
                        .font(.cairoFont(.semiBold, size: 18))

                    Text("earn_more_inviting_friends".localized)
                        .font(.cairoFont(.medium, size: 14))
                        .foregroundStyle(.gray)
                }
                .padding(.top, 25)

                // Link row
                VStack(alignment: .leading, spacing: 8) {
                    Text("share_your_link".localized)
                        .font(.cairoFont(.semiBold, size: 14))

                    HStack {
                        Text(referralLink)
                            .font(.cairoFont(.regular, size: 13))
                            .foregroundStyle(.gray)
                            .lineLimit(1)

                        Spacer()

                        Button {
                            UIPasteboard.general.string = referralLink
                            copied = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                copied = false
                            }
                        } label: {
                            Image(systemName: copied ? "checkmark" : "doc.on.doc")
                                .foregroundStyle(Color(hex: "#9C4EF7"))
                                .font(.system(size: 18))
                        }
                    }
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color(hex: "#F5F5F5")))
                }

                // Share to
                VStack(alignment: .leading, spacing: 12) {
                    Text("share_to".localized)
                        .font(.cairoFont(.semiBold, size: 14))
                        .frame(maxWidth: .infinity, alignment: .leading)

                    HStack(spacing: 20) {
                        ShareIconButton(icon: "ic_facebook", label: "Facebook") {
                            shareToApp(scheme: "fb://", url: "https://www.facebook.com/sharer/sharer.php?u=\(referralLink)")
                        }
                        ShareIconButton(icon: "ic_instagram", label: "Instagram") {
                            shareToApp(scheme: "instagram://", url: "https://www.instagram.com")
                        }
                        ShareIconButton(icon: "ic_whatsapp", label: "WhatsApp") {
                            shareToApp(scheme: "whatsapp://send?text=\(referralLink)", url: "https://wa.me/?text=\(referralLink)")
                        }
                        ShareIconButton(icon: "ic_x", label: "X") {
                            shareToApp(scheme: "twitter://post?message=\(referralLink)", url: "https://twitter.com/intent/tweet?text=\(referralLink)")
                        }
                    }
                }

    //            Spacer()
            }
            .padding(24)
            
            // Icon
            Circle()
                .fill(Color(hex: "#EEEEEE"))
                .shadow(radius: 3, y: 5)
                .frame(width: 80, height: 80)
                .overlay {
                    Image(systemName: "person.2.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                        .foregroundStyle(Color(hex: "#9C4EF7"))
                }
                .background(Circle().fill(.white))
                .offset(y: -35)

        }
    }

    private func shareToApp(scheme: String, url: String) {
        if let schemeURL = URL(string: scheme), UIApplication.shared.canOpenURL(schemeURL) {
            UIApplication.shared.open(schemeURL)
        } else if let fallbackURL = URL(string: url) {
            UIApplication.shared.open(fallbackURL)
        }
    }
}

struct ShareIconButton: View {
    let icon: String
    let label: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 6) {
                Image(icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 28, height: 28)

                Text(label)
                    .font(.cairoFont(.regular, size: 7))
                    .foregroundStyle(.black)
            }
        }
    }
}

struct PromoCodeSheet: View {

    @State private var promoCode = ""
    var onDismiss: () -> Void
    var onSubmit: ((String) -> Void)? = nil

    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 10) {

                

                Text("promo_code".localized)
                    .font(.cairoFont(.bold, size: 18))

                // Input row
                VStack(alignment: .leading, spacing: 8) {
                    Text("enter_your_promo_code".localized)
                        .font(.cairoFont(.semiBold, size: 14))

                    HStack {
                        TextField("promo_code".localized, text: $promoCode)
                            .font(.cairoFont(.regular, size: 14))
                            .foregroundStyle(.gray)

                        Button {
                            onSubmit?(promoCode)
                        } label: {
                            Image(systemName: "chevron.right")
                                .foregroundStyle(Color(hex: "#9C4EF7"))
                                .font(.system(size: 18, weight: .semibold))
                        }
                    }
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color(hex: "#F5F5F5")))
                }

    //            Spacer()
            }
            .padding(24)
            .padding(.top, 10)
            
            // Icon
            Circle()
                .fill(Color(hex: "#EEEEEE"))
                .shadow(radius: 3, y: 5)
                .frame(width: 70, height: 70)
                .overlay {
                    Image(systemName: "ticket.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 34, height: 34)
                        .foregroundStyle(Color(hex: "#9C4EF7"))
                }
                .offset(y: -35)

        }
    }
}

#Preview {
    SettingsContentView(clientBankNotes: .constant(""), userTier: .constant(.initializer()), onBankNotesTap: {}, onTiersTap: {}, onBadgesTap: {}, onStatementsTap: {}, onInvoicesTap: {}, onTransactionsTap: {}, onHelpTap: {}, onLogoutTap: {})
}
