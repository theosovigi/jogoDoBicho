//
//  Font + Extension.swift
//  jogoDoBicho
//
//  Created by apple on 12.03.2024.
//
import UIKit

extension UIFont {
    
    enum CustomFonts: String {
        case baloo = "Baloo"
        case baloo2 = "Baloo2"
    }
    
    enum CustomFontStyle: String {
        case regular = "-Regular"
    }
    
    static func customFont(
        font: CustomFonts,
        style: CustomFontStyle,
        size: Int,
        isScaled: Bool = true) -> UIFont {
            
            let fontName: String = font.rawValue + style.rawValue
            
            guard let font = UIFont(name: fontName, size: CGFloat(size)) else {
                debugPrint("Font can't be loaded")
                return UIFont.systemFont(ofSize: CGFloat(size))
            }
            
            return isScaled ? UIFontMetrics.default.scaledFont(for: font) : font
        }
}

extension UIColor {
    func toInt() -> Int {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        let rgba: UInt32 = (UInt32)(red * 255.0) << 24 | (UInt32)(green * 255.0) << 16 | (UInt32)(blue * 255.0) << 8 | (UInt32)(alpha * 255.0)
        return Int(rgba)
    }
    
    convenience init(fromInt value: Int) {
        let red = CGFloat((value >> 24) & 0xFF) / 255.0
        let green = CGFloat((value >> 16) & 0xFF) / 255.0
        let blue = CGFloat((value >> 8) & 0xFF) / 255.0
        let alpha = CGFloat(value & 0xFF) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
