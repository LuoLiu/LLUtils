//
//  String+Extension.swift
//  LLUtils
//
//  Created by luoliu on 2018/5/8.
//  Copyright © 2018年 ll. All rights reserved.
//

import Foundation

extension String {

    // MARK: contains emoji
    var containsEmoji: Bool {
        for scalar in unicodeScalars {
            switch scalar.value {
            case
            0x1F600...0x1F64F,  // Emoticons
            0x1F300...0x1F5FF,  // Misc Symbols and Pictographs
            0x1F680...0x1F6FF,  // Transport and Map
            0x2600...0x26FF,    // Misc symbols
            0x2700...0x27BF,    // Dingbats
            0xFE00...0xFE0F:    // Variation Selectors
                return true
            default:
                continue
            }
        }
        return false
    }
    
}
