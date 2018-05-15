//
//  PopupWindow.swift
//  footish
//
//  Created by luoliu on 2018/5/11.
//  Copyright © 2018年 四川奇迹. All rights reserved.
//

import UIKit

class PopupWindow: UIWindow {
    
    var enableTouchHide: Bool = true    // 是否允许点击空白区域关闭弹窗
    var isAnimating: Bool = false       // 当前是否在进行动画
    
    static let shared: PopupWindow = {
        let window = PopupWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UIViewController()
        
        return window
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.windowLevel = UIWindowLevelStatusBar + 1
        addTapGesture()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction(_:)))
        tapGesture.cancelsTouchesInView = false
        tapGesture.delegate = self
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc private func tapAction(_ gesture: UIGestureRecognizer) {
        if enableTouchHide == true && isAnimating == false {
            for subView in bgView.subviews {
                if let popupView = subView as? PopupView {
                    popupView.hide()
                }
            }
        }
    }
    
    lazy var attachView: UIView = {
        return self.rootViewController?.view ?? UIView()
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.zPosition = CGFloat(Float.greatestFiniteMagnitude)
        bgView.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
        bgView.alpha = 0.0
        bgView.frame = attachView.frame
        attachView.addSubview(bgView)
        
        return bgView
    }()
    
}

extension PopupWindow: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return (touch.view == bgView)
    }
    
}
