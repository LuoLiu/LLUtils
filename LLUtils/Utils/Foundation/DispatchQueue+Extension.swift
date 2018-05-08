//
//  DispatchQueue+Extension.swift
//  LLUtils
//
//  Created by luoliu on 2018/5/8.
//  Copyright © 2018年 ll. All rights reserved.
//

import Foundation

extension DispatchQueue {
    
    private static var _onceToken = [String]()
    
    public static func once(token: String, block: () -> Void) {
        objc_sync_enter(self)
        defer {
            objc_sync_exit(self)
        }
        if _onceToken.contains(token) {
            return
        }
        _onceToken.append(token)
        block()
    }
    
}
