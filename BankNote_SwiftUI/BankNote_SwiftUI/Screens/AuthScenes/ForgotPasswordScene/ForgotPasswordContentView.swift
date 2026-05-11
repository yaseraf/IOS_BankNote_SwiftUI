//
//  ForgotPasswordContentView.swift
//  QSC_SwiftUI
//
//  Created by FIT on 22/07/2025.
//

import Foundation
import SwiftUI

struct ForgotPasswordContentView: View {
    
    var forgotType: Binding<ForgotDataEnum>
    var authenticationType: Binding<AuthenticationViewType>
    @State var nin: String = ""
    @State var qid: String = ""
    @State var username: String = ""
    @Binding var phoneNumber: String
    @Binding var email: String
    
    // ── Resend timer ──────────────────────────────────────────
    /// Pass the seconds value you receive from the API response here.
    /// e.g. if the API returns { "resend_after_seconds": 161 } → pass 161
    var resendSeconds: Int = 161
    @State private var resendCountdown: Int = 0
    @State private var resendTimer: Timer? = nil
    // ─────────────────────────────────────────────────────────

    var onBack: () -> Void
    var onSubmit: () -> Void
    var onLoginTap: () -> Void
    var onCountryPickerTap: () -> Void
    var onResendLinkTap: () -> Void
    
    var body: some View {
        ZStack {
            VStack {
                headerView
                logoView
                titleView
                fieldView
                bottomView
                Spacer()
            }
        }
        .onDisappear {
            stopTimer()
        }
    }
    
    // MARK: - Subviews (unchanged)
    
    private var logoView: some View {
        VStack(spacing: 0) {
            Image(AppUtility.shared.APP_LOGO)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 225, maxHeight: 225)
            
            Text(AppUtility.shared.APP_NAME)
                .foregroundStyle(Color(hex: AppUtility.shared.APP_MAIN_COLOR))
                .font(.cairoFont(.extraBold, size: 40))
        }
    }
    
    private var headerView: some View {
        HStack {
            Image("ic_close")
                .resizable()
                .scaledToFit()
                .frame(width: 38, height: 38)
                .onTapGesture { onBack() }
            Spacer()
        }
        .padding(.horizontal, 18)
    }
    
    private var titleView: some View {
        VStack {
            Text("\("forgot_password".localized)?")
                .font(.cairoFont(.semiBold, size: 18))
            
            if authenticationType.wrappedValue == .phoneNumber {
                Text("please_enter_your_phone_number_and_well_send_you_a_link_to_change_password".localized)
                    .font(.cairoFont(.light, size: 12))
                    .padding(.horizontal, 77)
                    .multilineTextAlignment(.center)
            } else if authenticationType.wrappedValue == .email {
                Text("please_enter_your_email_and_well_send_you_a_link_to_change_password".localized)
                    .font(.cairoFont(.light, size: 12))
                    .padding(.horizontal, 77)
                    .multilineTextAlignment(.center)
            }
        }
    }
    
    private var fieldView: some View {
        HStack(spacing: 8) {
            if authenticationType.wrappedValue == .phoneNumber {
                Button(action: { onCountryPickerTap() }) {
                    HStack {
                        Text("🇪🇬 +20")
                            .font(.cairoFont(.semiBold, size: 12))
                        Image("ic_downArrow")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 12, height: 6)
                    }
                    .foregroundStyle(Color(hex: "#1C1C1C"))
                    .padding(.horizontal, 16)
                    .frame(height: 56)
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color(hex: "#DDDDDD")).shadow(color: .black, radius: 0.3, x: 0, y: 1))
                    .padding(.bottom, 24)
                }
                
                TextField("phone_number".localized, text: $phoneNumber)
                    .font(.cairoFont(.semiBold, size: 12))
                    .foregroundStyle(Color(hex: "#1C1C1C"))
                    .padding(.horizontal, 16)
                    .frame(height: 56)
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color(hex: "#DDDDDD")).shadow(color: .black, radius: 0.3, x: 0, y: 1))
                    .padding(.bottom, 24)
                
            } else if authenticationType.wrappedValue == .email {
                TextField("enter_your_email".localized, text: $email)
                    .font(.cairoFont(.semiBold, size: 12))
                    .textInputAutocapitalization(.never)
                    .foregroundStyle(Color(hex: "#1C1C1C"))
                    .padding(.horizontal, 16)
                    .frame(height: 56)
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color(hex: "#DDDDDD")).shadow(color: .black, radius: 0.3, x: 0, y: 1))
                    .padding(.bottom, 24)
            }
        }
        .padding(.horizontal, 18)
    }
    
    // MARK: - Bottom View
    
    private var bottomView: some View {
        var continueWithPhoneNumberAttribute: AttributedString {
            var str = AttributedString(
                authenticationType.wrappedValue == .phoneNumber
                    ? "continue_with_email".localized
                    : "continue_with_phone_number".localized
            )
            str.underlineStyle = .single
            return str
        }
        
        return VStack {
            // Continue button
            Button {
                onSubmit()
                startTimer(seconds: resendSeconds) // ← start timer after API call
            } label: {
                Text("continue".localized)
                    .font(.cairoFont(.semiBold, size: 18))
                    .foregroundStyle(.white)
                    .frame(minWidth: 357, minHeight: 51)
                    .background(RoundedRectangle(cornerRadius: 99).fill(Color.colorPrimary))
            }
            
            Spacer().frame(height: 24)
            
//            // ── Resend link button with countdown ─────────────────
//            Button {
//                onResendLinkTap()
//                startTimer(seconds: resendSeconds) // restart timer on resend
//            } label: {
//                resendLinkLabel
//            }
//            .disabled(resendCountdown > 0)
//            // ──────────────────────────────────────────────────────
//            
//            Spacer().frame(height: 34)
            
            // Switch auth type
            Button {
                withAnimation {
                    if authenticationType.wrappedValue == .phoneNumber {
                        authenticationType.wrappedValue = .email
                    } else {
                        authenticationType.wrappedValue = .phoneNumber
                    }
                }
            } label: {
                Text(continueWithPhoneNumberAttribute)
                    .font(.cairoFont(.semiBold, size: 14))
                    .foregroundStyle(Color(hex: "#629AF9"))
            }
        }
    }
    
    /// Shows "Resend link in MM:SS" while counting down, plain "Resend link" when ready.
    @ViewBuilder
    private var resendLinkLabel: some View {
        if resendCountdown > 0 {
            // Countdown active — greyed out with timer
            var attr: AttributedString {
                var str = AttributedString("\("resend_link".localized) \("in".localized) \(formattedCountdown)")
                str.underlineStyle = .single
                return str
            }
            Text(attr)
                .font(.cairoFont(.semiBold, size: 14))
                .foregroundStyle(Color(hex: "#828282"))
        } else {
            // Countdown finished — tappable
            var attr: AttributedString {
                var str = AttributedString("resend_link".localized)
                str.underlineStyle = .single
                return str
            }
            Text(attr)
                .font(.cairoFont(.semiBold, size: 14))
                .foregroundStyle(Color(hex: "#629AF9"))
        }
    }
    
    // MARK: - Timer helpers
    
    /// Formats remaining seconds as MM:SS  (e.g. 161 → "02:41")
    private var formattedCountdown: String {
        let m = resendCountdown / 60
        let s = resendCountdown % 60
        return String(format: "%02d:%02d", m, s)
    }
    
    /// Call this with the `resend_after_seconds` value from your API response.
    func startTimer(seconds: Int) {
        stopTimer()
        resendCountdown = seconds
        resendTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if resendCountdown > 0 {
                resendCountdown -= 1
            } else {
                stopTimer()
            }
        }
    }
    
    private func stopTimer() {
        resendTimer?.invalidate()
        resendTimer = nil
    }
}
