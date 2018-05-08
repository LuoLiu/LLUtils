//
//  UILabel+Extension.swift
//  LLUtils
//
//  Created by luoliu on 2018/5/8.
//  Copyright © 2018年 ll. All rights reserved.
//

import UIKit

extension UILabel {
    
    // MARK: set color for sub text
    func setColorFor(subString: String, color: UIColor) {
        var attributedString = NSMutableAttributedString(string: "")
        if let attributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: attributedText)
        } else if let text = self.text {
            attributedString = NSMutableAttributedString(string: text)
        }
        
        let range = attributedString.mutableString.range(of: subString, options: NSString.CompareOptions.caseInsensitive)
        if range.location != NSNotFound {
            attributedString.addAttribute(.foregroundColor, value: color, range: range)
        }
        
        self.attributedText = attributedString
    }
    
}
