//
//  UIColor+Extension.swift
//  LLUtils
//
//  Created by luoliu on 2018/5/8.
//  Copyright © 2018年 ll. All rights reserved.
//

import UIKit

extension UIColor {
    
    // MARK: init with hex
    // eg. UIColor.colorWithHex(0x000000)
    class func colorWithHex(_ hexValue: Int, alpha: CGFloat = 1.0) -> UIColor {
        let redValue = CGFloat((hexValue & 0xFF0000) >> 16) / 255.0
        let greenValue = CGFloat((hexValue & 0xFF00) >> 8) / 255.0
        let blueValue = CGFloat(hexValue & 0xFF) / 255.0
        
        return UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: alpha)
    }
    
    // eg. UIColor.colorWithHexString("0x000000")
    class func colorWithHexString(_ hexString: String, alpha: CGFloat = 1.0) -> UIColor {
        var result: UInt32 = 0
        var hex = hexString
        if hexString.hasPrefix("#") {
            hex.remove(at: hex.startIndex)
        }
        Scanner(string: "0x" + hex).scanHexInt32(&result)
        
        return UIColor.colorWithHex(Int(result), alpha: alpha)
    }
    
}
