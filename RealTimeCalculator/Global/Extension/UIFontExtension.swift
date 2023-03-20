//
//  UIFontExtension.swift
//  SmartCalculator
//
//  Created by Suheon Song on 2023/02/27.
//

import UIKit

extension UIFont {
    public enum FontType: String {
        case black = "-Black"
        case bold = "-Bold"
        case extraBold = "-ExtraBold"
        case extraLight = "-ExtraLight"
        case light = "-Light"
        case medium = "-Medium"
        case regular = "-Regular"
        case semiaBold = "-SemiBold"
        case thin = "-Thin"
    }
    
    static func Pretendard(_ type: FontType = .regular, size: CGFloat = UIFont.systemFontSize) -> UIFont {
        return UIFont(name: "Pretendard\(type.rawValue)", size: size)!
    }
}
