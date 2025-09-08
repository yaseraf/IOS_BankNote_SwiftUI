//
//  Font+Extension.swift
//  QSC
//
//  Created by FIT on 22/07/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation
import SwiftUI

let notoSansArabic = "NotoSansArabic"
let cairo = "Cairo"
let inter = "Inter"

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
        
        var notoSansArabicFont: String {
            switch self {
            case .thin:
                "\(notoSansArabic)-Thin"
            case .extraLight:
                "\(notoSansArabic)-ExtraLight"
            case .light:
                "\(notoSansArabic)-Light"
            case .regular:
                "\(notoSansArabic)-Regular"
            case .medium:
                "\(notoSansArabic)-Medium"
            case .semiBold:
                "\(notoSansArabic)-SemiBold"
            case .bold:
                "\(notoSansArabic)-Bold"
            case .extraBold:
                "\(notoSansArabic)-ExtraBold"
            case .black:
                "\(notoSansArabic)-Black"
            }
        }
        
        var cairoFont: String {
            switch self {
            case .thin:
                "\(cairo)-Thin"
            case .extraLight:
                "\(cairo)-ExtraLight"
            case .light:
                "\(cairo)-Light"
            case .regular:
                "\(cairo)-Regular"
            case .medium:
                "\(cairo)-Medium"
            case .semiBold:
                "\(cairo)-SemiBold"
            case .bold:
                "\(cairo)-Bold"
            case .extraBold:
                "\(cairo)-ExtraBold"
            case .black:
                "\(cairo)-Black"
            }
        }
        
        var interFont: String {
            switch self {
            case .thin:
                "\(inter)_28pt-Thin"
            case .extraLight:
                "\(inter)_28pt-ExtraLight"
            case .light:
                "\(inter)_28pt-Light"
            case .regular:
                "\(inter)_28pt-Regular"
            case .medium:
                "\(inter)_28pt-Medium"
            case .semiBold:
                "\(inter)_28pt-SemiBold"
            case .bold:
                "\(inter)_28pt-Bold"
            case .extraBold:
                "\(inter)_28pt-ExtraBold"
            case .black:
                "\(inter)_28pt-Black"
            }
        }
    }
    
    static func apply(_ type: Font.ThemeFont = .regular, size: CGFloat ) -> Font {
        return .custom(type.notoSansArabicFont, size: size)
    }
    
    static func notoSansArabicFont(_ type: Font.ThemeFont = .regular, size: CGFloat ) -> Font {
        return .custom(type.notoSansArabicFont, size: size)
    }
    
    static func cairoFont(_ type: Font.ThemeFont = .regular, size: CGFloat ) -> Font {
        return .custom(type.cairoFont, size: size)
    }
    
    static func interFont(_ type: Font.ThemeFont = .regular, size: CGFloat ) -> Font {
        return .custom(type.interFont, size: size)
    }
}
