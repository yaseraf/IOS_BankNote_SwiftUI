//
//  CutomeImageView.swift
//  QSC
//
//  Created by FIT on 06/09/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation
import SwiftUI
struct BackCustomView: View {
    var body: some View {
        Image(AppUtility.shared.isRTL ? "ic_rightArrow" :"ic_leftArrow")
            .resizable()
            .frame(width: 24)
            .frame(height: 24)
            .foregroundStyle(Color.colorFGPrimary)
            .padding(6)
            .background(
                Circle()
                    .fill(Color.colorQuaternary)
            )
//            .scaleEffect(AppUtility.shared.isRTL ? 1 : -1)
    }
}

struct RightImageView:View {
    var body: some View {
        Image(AppUtility.shared.isRTL ?  "ic_leftArrow" : "ic_rightArrow")
            .resizable()
            .renderingMode(.template)

    }
}

struct HistoryCustomView: View {
    var body: some View {
        Image("ic_history")
            .resizable()
            .renderingMode(.template)
            .resizable()
            .frame(width: 20)
            .frame(height: 20)
            .foregroundStyle(Color.colorFGPrimary)
            .padding(6)
            .background(
                Circle()
                    .fill(Color.colorQuaternary)
            )
    }
}

struct SettingCustomView: View {
    var body: some View {
        Image("ic_settingChart")
            .resizable()
            .renderingMode(.template)
            .resizable()
            .frame(width: 20)
            .frame(height: 20)
            .foregroundStyle(Color.colorFGPrimary)
            .padding(6)
            .background(
                Circle()
                    .fill(Color.colorQuaternary)
            )
    }
}

struct MoreCustomView: View {
    var body: some View {
        Image("ic_menuMore")
            .resizable()
            .renderingMode(.template)
             .frame(width: 20)
            .frame(height: 20)
            .foregroundStyle(Color.colorFGPrimary)
            .padding(6)
            .background(
                Circle()
                    .fill(Color.colorQuaternary)
            )
    }
}

struct FilterCustomView: View {
    var body: some View {
        Image("ic_filter")
            .resizable()
            .renderingMode(.template)
             .frame(width: 20)
            .frame(height: 20)
            .foregroundStyle(Color.colorFGPrimary)
            .padding(6)
            .background(
                Circle()
                    .fill(Color.colorQuaternary)
            )
    }
}


struct CloseCustomView: View {
    var body: some View {
        Image("ic_close")
            .resizable()
            .renderingMode(.template)
             .frame(width: 20)
            .frame(height: 20)
            .foregroundStyle(Color.colorFGPrimary)
            .padding(6)
            .background(
                Circle()
                    .fill(Color.colorQuaternary)
            )
    }
}


struct BankCircleCustomView: View {
    var body: some View {
        Image("ic_bank")
            .resizable()
            .renderingMode(.template)
             .frame(width: 20)
            .frame(height: 20)
            .foregroundStyle(Color.colorFGPrimary)
            .padding(16)
            .background(
                Circle()
                    .fill(Color.colorQuaternary)
            )
    }
}


struct ExportCircleCustomView: View {
    var body: some View {
        Image("ic_export")
            .resizable()
            .renderingMode(.template)
             .frame(width: 20)
            .frame(height: 20)
            .foregroundStyle(Color.colorFGPrimary)
            .padding(6)
            .background(
                Circle()
                    .fill(Color.colorQuaternary)
            )
    }
}
struct AlertPlusCircleCustomView: View {
    var body: some View {
        Image("ic_alertAdd")
            .resizable()
            .renderingMode(.template)
            .resizable()
            .frame(width: 20)
            .frame(height: 20)
            .foregroundStyle(Color.colorFGPrimary)
            .padding(6)
            .background(
                Circle()
                    .fill(Color.colorQuaternary)
            )
    }
}

struct AlertPlusCircleCustomViewActive: View {
    var body: some View {
        Image("ic_alertActive")
//            .resizable()
//            .renderingMode(.template)
            .resizable()
            .frame(width: 30)
            .frame(height: 30)
//            .foregroundStyle(Color.colorFGPrimary)
            .padding(6)
            
    }
}

struct StarCircleCustomView: View {
    
    @State var isFavorite:Bool = false
    
    var body: some View {
        Image(isFavorite ? "star_selected" : "ic_star")
            .resizable()
            .renderingMode(.template)
            .resizable()
            .frame(width: 20)
            .frame(height: 20)
            .foregroundStyle(Color.colorFGPrimary)
            .padding(6)
            .background(
                Circle()
                    .fill(Color.colorQuaternary)
            )
    }
}
