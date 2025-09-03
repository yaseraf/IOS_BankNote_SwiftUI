//
//  Font+Extension.swift
//  QSC
//
//  Created by FIT on 22/07/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation
import SwiftUI
extension Font {

    enum ThemeFont {
        case thin
        case extraLight
        case light
        case regular
        case medium
        case semiBold
        case bold
        case extraBold
        case black
        var value: String {
            switch self {
            case .thin:
                "NotoSansArabic-Thin"
            case .extraLight:
                "NotoSansArabic-ExtraLight"
            case .light:
                "NotoSansArabic-Light"
            case .regular:
                "NotoSansArabic-Regular"
            case .medium:
                "NotoSansArabic-Medium"
            case .semiBold:
                "NotoSansArabic-SemiBold"
            case .bold:
                "NotoSansArabic-Bold"
            case .extraBold:
                "NotoSansArabic-ExtraBold"
            case .black:
                "NotoSansArabic-Black"
            }
        }
    }
    
    static func apply(_ type: Font.ThemeFont = .regular, size: CGFloat ) -> Font {
        return .custom(type.value, size: size)
    }
}
