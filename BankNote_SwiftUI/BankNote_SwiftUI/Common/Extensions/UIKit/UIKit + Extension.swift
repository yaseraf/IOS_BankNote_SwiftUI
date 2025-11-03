//
//  UIKit + Extension.swift
//  QSC
//
//  Created by FIT on 15/08/2024.
//  Copyright © 2024 FIT. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    class func fromNib<T: UIView>() -> T {

        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }

    func addConstraint(leading:CGFloat? = nil,top:CGFloat,bottom:CGFloat? = nil,trailing:CGFloat? = nil,height:CGFloat? = nil) {
        let view = self
        guard let parentView = self.superview else{return}

        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: parentView.topAnchor, constant: top).isActive = true
        if let leading = leading{
            view.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: leading).isActive = true
        }
        if let trailing = trailing{
            view.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: trailing).isActive = true
        }
        if let bottom = bottom{
            view.bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: bottom).isActive = true
        }

        if let height = height{
            view.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    func addBottomShadow() {
        layer.masksToBounds = false
        layer.shadowRadius = 4
        layer.shadowOpacity = 1
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0 , height: 2)
        layer.shadowPath = UIBezierPath(rect: CGRect(x: 0,
                                                     y: bounds.maxY - layer.shadowRadius,
                                                     width: bounds.width,
                                                     height: layer.shadowRadius)).cgPath
    }
}

extension UIFont {
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
        
        var sfProDisplay: String {
            switch self {
            case .thin:
                "\(SFProDisplay)-Thin"
            case .extraLight:
                "\(SFProDisplay)-ExtraLight"
            case .light:
                "\(SFProDisplay)-Light"
            case .regular:
                "\(SFProDisplay)-Regular"
            case .medium:
                "\(SFProDisplay)-Medium"
            case .semiBold:
                "\(SFProDisplay)-SemiBold"
            case .bold:
                "\(SFProDisplay)-Bold"
            case .extraBold:
                "\(SFProDisplay)-ExtraBold"
            case .black:
                "\(SFProDisplay)-Black"
            }
        }

        
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

    static func apply(_ type: UIFont.ThemeFont = .regular, size: CGFloat = 15) -> UIFont? {
        return  UIFont(name: type.sfProDisplay, size: size)
    }
    
    static func notoSansArabicFont(_ type: UIFont.ThemeFont = .regular, size: CGFloat ) -> UIFont? {
        return UIFont(name: type.notoSansArabicFont, size: size)
    }
    
    static func cairoFont(_ type: UIFont.ThemeFont = .regular, size: CGFloat ) -> UIFont? {
        return UIFont(name: type.cairoFont, size: size)
    }
    
    static func interFont(_ type: UIFont.ThemeFont = .regular, size: CGFloat ) -> UIFont? {
        return UIFont(name: type.interFont, size: size)
    }


}


extension UIViewController{

    func checkViewControllerExist(scene: any BaseSceneType.Type)->Bool {
        guard let presentedView = self.presentedViewController?.view else{return true}
        return "\(presentedView )".contains("\(scene.self)")
    }
}
