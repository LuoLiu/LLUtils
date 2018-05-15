//
//  PopupView.swift
//  footish
//
//  Created by luoliu on 2018/5/11.
//  Copyright © 2018年 四川奇迹. All rights reserved.
//

import UIKit

class PopupView: UIView {
    
    var showAnimation: (() -> ())? // 自定义子类显示动画
    var hideAnimation: (() -> ())? // 自定义子类隐藏动画
    var willHide: (() -> ())?      // 自定义子类隐藏前操作
    
    private var backgroundBlurEffectStyle: UIBlurEffectStyle?
    
    private lazy var blurView: UIView = {
        let blurView = UIView()
        if let style = backgroundBlurEffectStyle {
            let effectView = UIVisualEffectView(effect: UIBlurEffect(style: style))
            blurView.addSubview(effectView)
            effectView.frame = PopupWindow.shared.bgView.frame
        }
        blurView.isUserInteractionEnabled = false
        
        return blurView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setBackgroundBlurEffectStyle(_ style: UIBlurEffectStyle) {
        backgroundBlurEffectStyle = style
        blurView.removeFromSuperview()
        PopupWindow.shared.bgView.backgroundColor = .clear
    }
    
    @objc func show() {
        showBgView(true)
        showAnimation?()
    }
    
    @objc func hide() {
        showBgView(false)
        hideAnimation?()
    }
    
}

// MARK: - Private
extension PopupView {
    
    private func showBgView(_ isShow: Bool) {
        let bgView = PopupWindow.shared.bgView
        
        if isShow {
            if self.superview == nil {
                bgView.addSubview(self)
            }
            
            bgView.isHidden = false
            PopupWindow.shared.isAnimating = true
            PopupWindow.shared.isHidden = false
            PopupWindow.shared.makeKey()
            
            UIView.animate(withDuration: 0.3, delay: 0.0, options: [.curveEaseOut, .beginFromCurrentState], animations: {
                bgView.alpha = 1.0
            }) { finished in
                PopupWindow.shared.isAnimating = false
            }
        } else {
            PopupWindow.shared.isAnimating = true
            willHide?()
            
            UIView.animate(withDuration: 0.3, delay: 0.0, options: [.curveEaseIn, .beginFromCurrentState], animations: {
                bgView.alpha = 0.0
            }) { finished in
                PopupWindow.shared.isAnimating = false
                PopupWindow.shared.attachView.willRemoveSubview(bgView)
                self.removeFromSuperview()
                
                PopupWindow.shared.isHidden = true
                UIApplication.shared.delegate?.window??.makeKey()
            }
        }
    }
    
}
