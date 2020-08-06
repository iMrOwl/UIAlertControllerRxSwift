//
//  UIColorExtension.swift
//  AlertControllerRxSwift
//
//  Created by Сычев Евгений Дмитриевич on 28.07.2020.
//  Copyright © 2020 Сычев Евгений Дмитриевич. All rights reserved.
//

import UIKit

// MARK: - UIColor Extension

extension UIColor {
    
    // MARK: - Public properties
    
    class var mainViewColor: UIColor? {
        return UIColor(hex: "#8DF7ffff")
    }
    
    class var loginButtonColor: UIColor? {
        return UIColor(hex: "#2D7FC1ff")
    }
 
    // MARK: - Init
    
    public convenience init?(hex: String) {
        let red: CGFloat
        let green: CGFloat
        let blue: CGFloat
        let alpha: CGFloat

        guard hex.hasPrefix(Constant.hasPrefix) else { return nil }
        
        let start = hex.index(hex.startIndex, offsetBy: 1)
        let hexColor = String(hex[start...])
        
        guard hexColor.count == Constant.hexColorCount else { return nil }
        let scanner = Scanner(string: hexColor)
        
        var hexNumber: UInt64 = 0
        
        guard scanner.scanHexInt64(&hexNumber) else { return nil }
        
        red = CGFloat((hexNumber & 0xff000000) >> 24) / 255
        green = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
        blue = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
        alpha = CGFloat(hexNumber & 0x000000ff) / 255
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

// MARK: - Constants

private extension UIColor {
    
    enum Constant {
        static let hasPrefix: String = "#"
        static let hexColorCount: Int = 8
    }
    
}
