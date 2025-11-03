//
//  Color+Extension.swift
//  QSC
//
//  Created by FIT on 22/07/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation
import SwiftUI

extension Color {
    
    init(hex: String) {
        var hexString = hex
        if hexString.contains("#" ) {
            hexString = hexString.replacingOccurrences(of: "#", with: "")
        }
           let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
           var int: UInt64 = 0
           Scanner(string: hex).scanHexInt64(&int)
           let a, r, g, b: UInt64
           switch hex.count {
           case 3: // RGB (12-bit)
               (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
           case 6: // RGB (24-bit)
               (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
           case 8: // ARGB (32-bit)
               (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
           default:
               (a, r, g, b) = (1, 1, 1, 0)
           }

           self.init(
               .sRGB,
               red: Double(r) / 255,
               green: Double(g) / 255,
               blue: Double(b) / 255,
               opacity: Double(a) / 255
           )
       }
    func uiColor() -> UIColor {
            return UIColor(self)
        }
}
extension Color {
    static let userGradientsColor:[Color] = [Color.init(hex: "E0D8FB"),
                                 Color.init(hex: "B39CFF")]
}
extension Color {

    private static let colorFGPrimary_101C28: Color = Color.init(hex: "#101C28")
    private static let colorFGError_F97066: Color = Color.init(hex: "#F97066")

//-------------------------------------------------------------------------------
    
// MARK: LIGHT
  private static let colorPrimary_9C4EF7: Color = Color.init(hex: "#9C4EF7")
  private static let colorTextPrimaryLight: Color = Color.init(hex: "#24180E")
  private static let colorPrimaryLight: Color = Color.init(hex: "#374FA3")
  private static let colorBorderLight: Color = Color.init(hex: "#F0EEED")
  private static let colorBorderSecondaryLight: Color = Color.init(hex: "#989898")
  private static let colorBGLight: Color = Color.init(hex: "#FFFFFF")
  private static let colorBGThirdLight: Color = Color.init(hex: "#FAFBFC")
  private static let colorDocumentBGLight: Color = Color.init(hex: "#F3F3F5")
  private static let colorBGSelectionLight: Color = Color.init(hex: "#F7F8FB")
  private static let colorStockUpliftHeaderGradientLight: Color = Color.init(hex: "#FFEDF8")
  private static let colorStockWithdrawalHeaderGradientLight: Color = Color.init(hex: "#EAEEFF")
  private static let colorBGTableLight: Color = Color.init(hex: "#F8FAFC")
  private static let colorAlertLight: Color = Color.init(hex: "#E52E2E")
  private static let colorTextSecondaryLight: Color = Color.init(hex: "#948F8D")
  private static let colorBGSecondaryLight: Color = Color.init(hex: "#EBEDF6")
  private static let colorBGHeaderLight: Color = Color.init(hex: "#EBEDF6")
  private static let colorPositiveLight: Color = Color.init(hex: "#00B050")
  private static let colorPositiveLightSecondary: Color = Color.init(hex: "#00B050")
  private static let colorNegativeLight: Color = Color.init(hex: "#E52E2E")
  private static let colorNegativeLightSecondary: Color = Color.init(hex: "#E52E2E")
  private static let colorZeroLight: Color = Color.init(hex: "#FF8207")
  private static let colorBGPositiveLight: Color = Color.init(hex: "#E8F9F1")
  private static let colorBGNegativeLight: Color = Color.init(hex: "#FCECEC")
  private static let colorOfferLight: Color = Color.init(hex: "#F0DCE8")
  private static let colorBidLight: Color = Color.init(hex: "#D4E5FF")
  private static let colorNeutralLight: Color = Color.init(hex: "#DDDCDC")
  private static let colorBuyLight: Color = Color.init(hex: "#61A0FC")
  private static let colorSellLight: Color = Color.init(hex: "#E697C6")

    
  private static let colorTextPrimary_101C28: Color = Color.init(hex: "#101C28")
  private static let colorTextDisable_667585: Color = Color.init(hex: "#667585")
  private static let colorTextPrimaryTwo_F5F5F6: Color = Color.init(hex: "#F5F5F6")
  private static let colorTextTertiary_475667: Color = Color.init(hex: "#475667")
  private static let colorFGQuinary_98A5B3: Color = Color.init(hex: "#98A5B3")
  private static let colorBrand_EBF6FF: Color = Color.init(hex: "#EBF6FF")
  private static let colorBlack_000000: Color = Color.black
  private static let colorWarning600_DC6803: Color = Color.init(hex: "#DC6803")
  private static let colorWarning200_FEDF89: Color = Color.init(hex: "#FEDF89")
  private static let colorWarning50_FFFAE: Color = Color.init(hex: "#FFFAEB")
  private static let colorBrandPrimary_3559E9: Color = Color.init(hex: "#3559E9")
  private static let colorDarkGrayButton_333A41: Color = Color.init(hex: "#333A41")
  private static let colorBGTertiary_F2F4F7: Color = Color.init(hex: "#F2F4F7")
  private static let colorTextPlaceHolder_667585: Color = Color.init(hex: "#667585")
  private static let colorTextSecondary_344354: Color = Color.init(hex: "#344354")
  private static let colorTextSecondaryTwo_CED0D2: Color = Color.init(hex: "#CED0D2")
  private static let colorTextTernary_0D1126: Color = Color.init(hex: "#0D1126")
  private static let colorPrimary_3595E9: Color = Color.init(hex: "#3595E9")
  private static let colorQuaternary_EAEDF0: Color = Color.init(hex: "#EAEDF0")
  private static let colorFGQuaternary_667585: Color = Color.init(hex: "#667585")
  private static let colorBGSecondary_FFFFFF: Color = Color.init(hex: "#FFFFFF")
  private static let colorBGDisable_F2F4F7: Color = Color.init(hex: "#F2F4F7")
  private static let colorBorderPrimary_D0D6DD: Color = Color.init(hex: "#D0D6DD")
  private static let colorBorderSecondary_EAEDF0: Color = Color.init(hex: "#EAEDF0")
  public static let colorSuccess_26A95F: Color = Color.init(hex: "#1E961E")
  private static let colorSuccess50_EEFBF4: Color = Color.init(hex: "#EEFBF4")
  private static let colorLink_39A0F8: Color = Color.init(hex: "#39A0F8")
  private static let colorError_D92D20: Color = Color.init(hex: "#AA1A1A")
  private static let colorError50_FEF3F2: Color = Color.init(hex: "#FEF3F2")
  private static let colorWhite_FFFFFF: Color = Color.white
  private static let colorBGPrimary_FFFFFF: Color = Color.init(hex: "#FFFFFF")
  private static let colorChartGreen_2DCA72: Color = Color.init(hex: "#2DCA72")
  private static let colorChartBlue_335CFF: Color = Color.init(hex: "#335CFF")
  private static let colorChartOrange_F79009: Color = Color.init(hex: "#F79009")
  private static let colorChartOther_98A5B3: Color = Color.init(hex: "#98A5B3")
    
//-------------------------------------------------------------------------------
    
// MARK: DARK
    
    private static let colorTextPrimaryDark: Color = Color.init(hex: "#FFFFFF")
    private static let colorPrimaryDark: Color = Color.init(hex: "#374FA3")
    private static let colorBorderDark: Color = Color.init(hex: "#212A36")
    private static let colorBGDark: Color = Color.init(hex: "#0B0E13")
    private static let colorBGThirdDark: Color = Color.init(hex: "#1C1C1C")
    private static let colorDocumentBGDark: Color = Color.init(hex: "#1E232F")
    private static let colorBGSelectionDark: Color = Color.init(hex: "#1D243A")
    private static let colorStockUpliftHeaderGradientDark: Color = Color.init(hex: "#7A2357")
    private static let colorStockWithdrawalHeaderGradientDark: Color = Color.init(hex: "#22367C")
    private static let colorBGTableDark: Color = Color.init(hex: "#1C212E")
    private static let colorAlertDark: Color = Color.init(hex: "#E52E2E")
    private static let colorTextSecondaryDark: Color = Color.init(hex: "#EEE9E7")
    private static let colorBGSecondaryDark: Color = Color.init(hex: "#1E222F")
    private static let colorBGHeaderDark: Color = Color.init(hex: "#1E232F")
    private static let colorPositiveDark: Color = Color.init(hex: "#FFFFFF")
    private static let colorPositiveDarkSecondary: Color = Color.init(hex: "#4BB0A0")
    private static let colorNegativeDark: Color = Color.init(hex: "#FFFFFF")
    private static let colorNegativeDarkSecondary: Color = Color.init(hex: "#EB6D71")
    private static let colorZeroDark: Color = Color.init(hex: "#FF8207")
    private static let colorBGPositiveDark: Color = Color.init(hex: "#4BB0A0")
    private static let colorBGNegativeDark: Color = Color.init(hex: "#EB6D71")
    private static let colorOfferDark: Color = Color.init(hex: "#CE79AC")
    private static let colorBidDark: Color = Color.init(hex: "#456CA9")
    private static let colorNeutralDark: Color = Color.init(hex: "#5E5E5E")
    private static let colorBuyDark: Color = Color.init(hex: "#456CA9")
    private static let colorSellDark: Color = Color.init(hex: "#CE79AC")
    
    
    
    private static let colorFGError_F04438: Color = Color.init(hex: "#F04438")
    private static let colorFGPrimary_FFFFFF: Color = Color.init(hex: "#FFFFFF")
    static let colorTextPrimary_F5F5F6: Color = Color.init(hex: "#F5F5F6")
    static let colorTextDisable_85898E: Color = Color.init(hex: "#85898E")
    static let colorTextTertiary_94989C: Color = Color.init(hex: "#94989C")
    static let colorFGQuinary_FFFFFF: Color = Color.init(hex: "#FFFFFF")
    static let colorBrand_002C52: Color = Color.init(hex: "#002C52")
    static let colorWarning600_FDB022: Color = Color.init(hex: "#FDB022")
    static let colorWarning200_93370D: Color = Color.init(hex: "#93370D")
    static let colorWarning50_4E1D09: Color = Color.init(hex: "#4E1D09")
    static let colorBGTertiary_333A41: Color = Color.init(hex: "#333A41")
    static let colorTextPlaceHolder_333A41: Color = Color.init(hex: "#333A41")
    static let colorTextPlaceHolder_94989C: Color = Color.init(hex: "#94989C")
    static let colorTextSecondary_F5F5F6: Color = Color.init(hex: "#F5F5F6")
    static let colorTextTernary_94989C: Color = Color.init(hex: "#94989C")
    static let colorQuaternary_61666C: Color = Color.init(hex: "#61666C")
    static let colorFGQuaternary_CED0D2: Color = Color.init(hex: "#CED0D2")
    static let colorBGSecondary_0B0E13: Color = Color.init(hex: "#0B0E13")
    static let colorBGDisable_333A41: Color = Color.init(hex: "333A41")
    static let colorBorderPrimary_333A41: Color = Color.init(hex: "#333A41")
    static let colorBorderSecondary_1F272F: Color = Color.init(hex: "#1F272F")
    static let colorSuccess_56D990: Color = Color.init(hex: "#56D990")
    static let colorSuccess50_092A18: Color = Color.init(hex: "#092A18")
    static let colorBGPrimary_161E26: Color = Color.init(hex: "161E26")

    // Properties with getters
    
    static var colorPrimary: Color {
        get {
//            AppUtility.shared.isDarkTheme ? colorPrimaryDark : colorPrimaryLight
            AppUtility.shared.isDarkTheme ? colorPrimary_9C4EF7 : colorPrimary_9C4EF7
        }
    }
    
    static var colorTextPrimary: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorTextPrimaryDark : colorTextPrimaryLight
        }
    }
    
    static var colorTextSecondary: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorTextSecondaryDark : colorTextSecondaryLight
        }
    }
    
    static var colorBGSecondary: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorBGSecondaryDark : colorBGSecondaryLight
        }
    }
    
    static var colorBGHeader: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorBGHeaderDark : colorBGHeaderLight
        }
    }
    
    static var colorBorder: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorBorderDark : colorBorderLight
        }
    }
    
    static var colorBorderSecondary: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorBorderDark : colorBorderSecondaryLight
        }
    }
    
    static var colorBG: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorBGDark : colorBGLight
        }
    }
    
    static var colorBGThird: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorBGThirdDark : colorBGThirdLight
        }
    }
    
    static var colorDocumentBG: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorDocumentBGDark : colorDocumentBGLight
        }
    }
    
    static var colorBGSelection: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorBGSelectionDark : colorBGSelectionLight
        }
    }
    
    static var colorStockUpliftHeaderGradient: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorStockUpliftHeaderGradientDark : colorStockUpliftHeaderGradientLight
        }
    }
    
    static var colorStockWithdrawalHeaderGradient: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorStockWithdrawalHeaderGradientDark : colorStockWithdrawalHeaderGradientLight
        }
    }
    
    static var colorBGTable: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorBGTableDark : colorBGTableLight
        }
    }
    
    static var colorPositive: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorPositiveDark : colorPositiveLight
        }
    }
    
    static var colorPositiveSecondary: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorPositiveDarkSecondary : colorPositiveLightSecondary
        }
    }
    
    static var colorNegative: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorNegativeDark : colorNegativeLight
        }
    }
    
    static var colorZero: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorZeroDark : colorZeroLight
        }
    }
    
    static var colorNegativeSecondary: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorNegativeDarkSecondary : colorNegativeLightSecondary
        }
    }
    
    static var colorBGPositive: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorBGPositiveDark : colorBGPositiveLight
        }
    }
    
    static var colorBGNegative: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorBGNegativeDark : colorBGNegativeLight
        }
    }
    
    static var colorAlert: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorAlertDark : colorAlertLight
        }
    }
    
    static var colorOffer: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorOfferDark : colorOfferLight
        }
    }
    
    static var colorBid: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorBidDark : colorBidLight
        }
    }
    
    static var colorNeutral: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorNeutralDark : colorNeutralLight
        }
    }
    
    static var colorBuy: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorBuyDark : colorBuyLight
        }
    }
    
    static var colorSell: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorSellDark : colorSellLight
        }
    }
    
    //-----------------------------------------------------------------------------------
    //-----------------------------------------------------------------------------------
    
    static var colorBGButtonSecondary: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorDarkGrayButton_333A41 : colorQuaternary_EAEDF0 // Done
        }
    }   
    static var colorFGError: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorFGError_F04438 : colorFGError_F97066 // Done
        }
    }   
    static var colorFGPrimary: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorFGPrimary_FFFFFF : colorFGPrimary_101C28 // Done
        }
    }
    static var colorTextPrimaryHEX: String {
        get {
            AppUtility.shared.isDarkTheme ? "F5F5F6" : "101C28" // Done
        }
    }

    static var colorTextDisable: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorTextDisable_85898E : colorTextDisable_667585 // Done
        }
    }

    static var colorTextPrimaryTwo: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorTextPrimaryTwo_F5F5F6 : colorTextPrimaryTwo_F5F5F6
        }
    }

//    static var colorTextTertiary: Color {
//        get {
//            AppUtility.shared.isDarkTheme ? colorTextTertiary_475667 : colorTextTertiary_94989C
//        }
//    }

    static var colorTextTertiary: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorTextTertiary_94989C : colorTextTertiary_94989C // note
        }
    }


    static var colorFGQuinary: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorFGQuinary_FFFFFF : colorFGQuinary_98A5B3
        }
    }
    static var colorFGQuinary2: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorTextDisable_85898E : colorFGQuinary_98A5B3
        }
    }

    static var colorBrand: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorBrand_002C52 : colorBrand_EBF6FF
        }
    }

    static var colorWarning600: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorWarning600_DC6803 : colorWarning600_DC6803
//            AppUtility.shared.isDarkTheme ? colorWarning50_4E1D09 : colorWarning600_DC6803
        }
    }
    static var colorWarning600_2: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorWarning600_FDB022 : colorWarning600_DC6803
        }
    }



    static var colorWarning200: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorWarning50_4E1D09 : colorWarning200_FEDF89
        }
    }


    static var colorWarning50: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorWarning600_FDB022 : colorWarning50_FFFAE
        }
    }

    static var colorBrandPrimary: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorBrandPrimary_3559E9 : colorBrandPrimary_3559E9
        }
    }

    static var colorDarkGrayButton: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorDarkGrayButton_333A41 : colorDarkGrayButton_333A41
        }
    }

    static var colorBGTertiary: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorBGTertiary_333A41 : colorBGTertiary_F2F4F7// Done
        }
    }

    static var colorTextPlaceHolder: Color {
        get {
//            AppUtility.shared.isDarkTheme ? colorTextPlaceHolder_333A41 : colorTextPlaceHolder_667585 // Done
            AppUtility.shared.isDarkTheme ? colorTextPlaceHolder_94989C : colorTextPlaceHolder_667585 // Done
        }
    }
    

    static var colorTextSecondaryThird: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorTextSecondaryTwo_CED0D2 : colorTextSecondary_344354 // Done
        }
    }


    static var colorTextSecondaryTwo: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorTextSecondaryTwo_CED0D2 : colorTextSecondaryTwo_CED0D2
        }
    }

    static var colorTextTernary: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorTextTernary_94989C : colorTextTernary_0D1126
        }
    }

    static var colorQuaternary: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorQuaternary_61666C : colorQuaternary_EAEDF0
        }
    }
    

    static var colorFGQuaternary: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorFGQuaternary_CED0D2 : colorFGQuaternary_667585
        }
    }

    static var colorBGDisable: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorBGDisable_333A41 : colorBGDisable_F2F4F7
        }
    }


    static var colorBorderPrimary: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorBorderPrimary_333A41 : colorBorderPrimary_D0D6DD // Done
        }
    }

    static var colorSuccess: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorSuccess50_092A18 : colorSuccess_26A95F
        }
    }

    static var colorSuccess2: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorChartGreen_2DCA72 : colorSuccess_26A95F
        }
    }



    static var colorSuccess50: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorSuccess_56D990 : colorSuccess50_EEFBF4
        }
    }



    static var colorLink: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorLink_39A0F8 : colorLink_39A0F8
        }
    }

    static var colorError: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorError_D92D20 : colorError_D92D20
//            AppUtility.shared.isDarkTheme ? colorError_D92D20 : colorError_D92D20
//                .red
        }
    }

    static var colorError50: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorError50_FEF3F2 : colorError50_FEF3F2
        }
    }

    static var colorError700: Color {
        get {
            Color(hex: "FDA29B")
        }
    }

    static var colorBGPrimary: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorBGPrimary_161E26 : colorBGPrimary_FFFFFF // Done
        }
    }

    static var colorChartGreen: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorChartGreen_2DCA72 : colorChartGreen_2DCA72
        }
    }

    static var colorChartBlue: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorChartBlue_335CFF : colorChartBlue_335CFF
        }
    }

    static var colorChartOrange: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorChartOrange_F79009 : colorChartOrange_F79009
        }
    }

    static var colorChartOther: Color {
        get {
            AppUtility.shared.isDarkTheme ? colorChartOther_98A5B3 : colorChartOther_98A5B3
        }
    }

    static var colorBlack: Color {
        get {
            AppUtility.shared.isDarkTheme ? Color.white : Color.black
        }
    }
    static var colorWhite: Color {
        get {
          AppUtility.shared.isDarkTheme ? colorWhite_FFFFFF : colorWhite_FFFFFF

        }
    }




 
}



