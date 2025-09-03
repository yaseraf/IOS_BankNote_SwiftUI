//
//  LanguageHeaderView.swift
//  QSC
//
//  Created by FIT on 22/07/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import SwiftUI

struct LanguageHeaderView: View {
    @State var isArabic: Bool = AppUtility.shared.isRTL

    var body: some View {
        VStack{
            HStack(spacing: 0){
                
                Button {
                    guard  isArabic else{return}
                    AppUtility.shared.updateAppLanguage(language: .english)
                    isArabic = false
                    restartView()
                } label: {
                    Text(LanguageType.english.textShort)
                        .font(Font.apply(.bold,size: 13))
                        .foregroundColor( Color.colorTextPrimary  )
                        .frame(maxWidth: 51)
                        .frame(height: 28)
                        .cornerRadius(7)
                        .background(
                            Rectangle()
                                .fill(!isArabic ?  getFillColor() : .clear)
                                .cornerRadius(7)
                                .shadow(color:!isArabic ?   Color.black.opacity(0.2) :.clear, radius: 2)
                            
                                .padding(2)
                        )
                    
                }
                Button {
                    guard  !isArabic else{return}
                    AppUtility.shared.updateAppLanguage(language: .arabic)
                    isArabic = true
                    restartView()
                } label: {
                    Text(LanguageType.arabic.textShort)
                        .font(Font.apply(.bold,size: 13))
                        .foregroundColor( Color.colorTextPrimary  )
                        .frame(maxWidth: 51)
                        .frame(height: 28)
                        .cornerRadius(7)
                        .background(
                            Rectangle().fill(isArabic ?  getFillColor() : .clear)
                                .cornerRadius(7)
                                .shadow(color:isArabic ?   Color.black.opacity(0.2) :.clear, radius: 2)
                                .padding(2)
                        )
                    
                }
            }
            .background(getBackgroundFillColor())
            .cornerRadius(7)
        }
        
        
    }
    

    private func getFillColor() -> Color{
        AppUtility.shared.isDarkTheme ? Color.colorQuaternary : Color.colorBGPrimary
    }

    private func getBackgroundFillColor() -> Color{
        AppUtility.shared.isDarkTheme ? Color.colorBGTertiary : Color.colorQuaternary
    }

    private func restartView(){
        SceneDelegate.getAppCoordinator()?.restart()

    }
}

#Preview {
    LanguageHeaderView()
}

extension Binding {
    func withDefault<T>(_ defaultValue: T) -> Binding<T> where Value == Optional<T> {
        return Binding<T>(get: {
            self.wrappedValue ?? defaultValue
        }, set: { newValue in
            self.wrappedValue = newValue
        })
    }
}
