//
//  LandingView.swift
//  QSC_SwiftUI
//
//  Created by FIT on 20/07/2025.
//

import SwiftUI

struct LandingContentView: View {

    enum languages {
        case arabic
        case english
    }
    
    @State var selectedLanguage: languages = .english
    var onLanguageSelected: (() -> Void)

    var body: some View {
        ZStack {
            VStack(alignment: .center) {
                                
                headerView
                
                chooseLanguageView
                
                Spacer()
                
               contactInformationView

                versionNumberView
            }
            .frame(maxWidth: .infinity)

        }
        .padding()
        .onAppear {
            if UserDefaultController().appLanguage == "ar" {
                selectedLanguage = .arabic
            } else {
                selectedLanguage = .english
            }
        }
    }
    
    @ViewBuilder
    private var headerView: some View {
        Image("ic_logo")
            .resizable()
            .scaledToFit()
            .padding(.top, 60)
        
        VStack(spacing: 10) {
            Text("powerful_trading_platform".localized)
                .foregroundStyle(Color.colorTextPrimary)
                .font(.apply(.bold, size: 20))
            Text("enhance_your_trading_experience".localized)
                .foregroundStyle(Color.colorTextPrimary)
                .font(.apply(.bold, size: 20))
        }
        
        Spacer()
    }
    
    @ViewBuilder
    private var chooseLanguageView: some View {
        VStack(alignment: .leading) {
            Text("choose_the_application_language".localized)
                .foregroundStyle(Color.colorTextPrimary)
                .font(.apply(.bold, size: 14))

            HStack(alignment: .center) {
                Text("arabic_language".localized)
                    .font(.apply(size: 16))
                    .foregroundStyle(selectedLanguage == .arabic ? Color.white : Color.colorTextPrimary)
                    .padding(.horizontal, 20.25)
                    .padding(.vertical, 6)
                    .frame(maxWidth: .infinity)
                    .frame(height: 36)
                    .background(
                        ZStack {
                            RoundedRectangle(cornerRadius: 8).fill(selectedLanguage == .arabic ? Color.colorPrimary : .clear)
                            
                            RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).fill(selectedLanguage == .arabic ? Color.colorPrimary : Color.colorBorder)
                        }
                    )
                    .onTapGesture {
                        AppUtility.shared.updateAppLanguage(language: .arabic)
//                        SceneDelegate.getAppCoordinator()?.restart()
                        selectedLanguage = .arabic
                        onLanguageSelected()
                    }


                Spacer()
                
                Text("English Language")
//                    .font(.apply(size: 16))
                    .foregroundStyle(selectedLanguage == .english ? Color.white : Color.colorTextPrimary)
                    .padding(.horizontal, 20.25)
                    .padding(.vertical, 6)
                    .frame(maxWidth: .infinity)
                    .frame(height: 36)
                    .background(
                        ZStack {
                            RoundedRectangle(cornerRadius: 8).fill(selectedLanguage == .english ? Color.colorPrimary : .clear)
                            
                            RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).fill(selectedLanguage == .english ? Color.colorPrimary : Color.colorBorder)
                        }
                    )
                    .onTapGesture {
                        AppUtility.shared.updateAppLanguage(language: .english)
//                        SceneDelegate.getAppCoordinator()?.restart()
                        selectedLanguage = .english
                        onLanguageSelected()
                    }

            }
            .frame(maxWidth: .infinity)
            .frame(height: 36)

        }

    }
    
    @ViewBuilder
    private var contactInformationView: some View {
        VStack(alignment: .leading, spacing:0) {
            Text("contact_us_for_further_assistance".localized)
                .foregroundStyle(Color.colorTextPrimary)
                .font(.apply(.bold, size: 14))
            
            Divider()
                .padding(.vertical, 10)
            
            HStack {
                Image("ic_phone")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                
                Text("(+974)44255273")
                    .foregroundStyle(Color.colorTextPrimary)
                    .font(.apply(size: 14))

            }
            
            HStack {
                Image("ic_mail")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                
                Text(verbatim: "info@qsc.qa")
                    .font(.apply(size: 14))
                    .foregroundStyle(Color.colorTextPrimary)

            }
        }
        .padding(16)
        .frame(maxWidth: .infinity)
        .frame(height: 134)
        .background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).fill(Color.colorBorder))
    }
    
    @ViewBuilder
    private var versionNumberView: some View {
        HStack {
            Text("application_version_number".localized)
                .foregroundStyle(Color.colorTextPrimary)
                .font(.apply(.bold, size: 14))
            
            Spacer()
            
            Text("\(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown")")
                .foregroundStyle(Color.colorTextPrimary)
                .font(.apply(.bold, size: 14))


        }
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity)
        .frame(height: 56)
        .background(RoundedRectangle(cornerRadius: 16).stroke(lineWidth: 1).fill(Color.colorBorder))
    }
}
