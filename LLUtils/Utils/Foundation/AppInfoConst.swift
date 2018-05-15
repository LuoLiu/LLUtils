//
//  AppInfoConst.swift
//  LLUtils
//
//  Created by luoliu on 2018/5/15.
//  Copyright © 2018年 ll. All rights reserved.
//

import UIKit

struct AppInfo {
    
    // App 名称
    static let displayName = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String ?? ""
    
    // Bundle Identifier
    static let bundleID = Bundle.main.bundleIdentifier ?? ""
    
    // App 版本号
    static let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    
    // Bulid 版本号
    static let buildVersion = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? ""
    
    // 系统版本号
    static let systemVersion = UIDevice.current.systemVersion
    
    // 设备 UUID
    static let identifierNumber = UIDevice.current.identifierForVendor
    
    // 设备名称
    static let systemName = UIDevice.current.systemName
    
    // 设备型号
    static let model = UIDevice.current.model
    
    // 设备区域化型号
    static let localizedModel = UIDevice.current.localizedModel
    
}
