//
//  UIView+Extension.swift
//  LLUtils
//
//  Created by luoliu on 2018/5/8.
//  Copyright © 2018年 ll. All rights reserved.
//

import UIKit

extension UIView {
    
    // MARK: add border
    func addBorder(width: CGFloat, color: UIColor, cornerRadius: CGFloat) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
    }
    
    // MARK: load from nib
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as? UIView
        
        return view ?? UIView()
    }
    
}
