//
//  UIDevice+Extension.swift
//  LLUtils
//
//  Created by luoliu on 2018/5/8.
//  Copyright © 2018年 ll. All rights reserved.
//

import UIKit

extension UIDevice {
    
    public enum ScreenType {
        case iPhone4s       // 3.5
        case iPhone5        // 4
        case iPhone6_7      // 4.7
        case iPhone6_7plus  // 5.5
        case iPhoneX        // 5.8
        case iPad           // 9.7
        case iPad_Pro       // 12.9
        case unknow         // unknow
    }
    
    public static var screenType: ScreenType {
        let deviceIdiom = UIScreen.main.traitCollection.userInterfaceIdiom
        let deviceSize = UIScreen.main.bounds.size
        switch deviceIdiom {
        case .phone:
            switch (deviceSize.width, deviceSize.height) {
            case (0...320, 0...480):
                return .iPhone4s
            case (0...320, 481...568):
                return .iPhone5
            case (321...375, 569...667):
                return .iPhone6_7
            case (321...375, 668...812):
                return .iPhoneX
            case (376...414, 668...736):
                return .iPhone6_7plus
            default:
                return .unknow

            }
        case .pad:
            switch (deviceSize.width, deviceSize.height) {
            case (0...768, _):
                return .iPad
            case (768...1024, _):
                return .iPad_Pro
            default:
                return .unknow
            }
        default:
            return .unknow
        }
    }
    
}

extension UIDevice {
    
    public enum MachineType {
        
        public enum AppleWatchType {
            case _38mm
            case _42mm
            case _series1_38mm
            case _series1_42mm
            case _series2_38mm
            case _series2_42mm
        }
        
        public enum iPodTouchType {
            case _1
            case _2
            case _3
            case _4
            case _5
            case _6
        }
        
        public enum iPhoneType {
            case _1G
            case _3G
            case _3GS
            case _4_GSM
            case _4
            case _4_CDMA
            case _4s
            case _5
            case _5c
            case _5s
            case _6
            case _6Plus
            case _6s
            case _6sPlus
            case _se
            case _7
            case _7Plus
            case _8
            case _8Plus
            case _X
        }
        
        public enum iPadType {
            case _1
            case _2_WiFi
            case _2_GSM
            case _2_CDMA
            case _2
            case _mini1
            case _3_WiFi
            case _3_4G
            case _4
            case _air
            case _mini2
            case _mini3
            case _mini4
            case _air2
            case _pro_97inch
            case _pro_129inch
        }
        
        public enum AppleTVType {
            case _2
            case _3
            case _4
        }
        
        public enum SimulatorType {
            case _x86
            case _x64
        }
        
        case unknown
        case appleWatch(MachineType.AppleWatchType)
        case iPodTouch(MachineType.iPodTouchType)
        case iPhone(MachineType.iPhoneType)
        case iPad(MachineType.iPadType)
        case appleTV(MachineType.AppleTVType)
        case simulator(MachineType.SimulatorType)
        
        public func isPhone(_ type: MachineType.iPhoneType) -> Bool {
            switch self {
            case .iPhone(type):
                return true
            default:
                return false
            }
        }
    }
    
    private static let _fetchMachineModeOnceToken = "ravv_fetch_machine_mode_once_token"
    
    private static var _machineModel: String!
    
    private static var machineMode: String {
        DispatchQueue.once(token: _fetchMachineModeOnceToken) {
            var size: size_t = 0
            sysctlbyname("hw.machine", nil, &size, nil, 0)
            let content = malloc(size)
            sysctlbyname("hw.machine", content, &size, nil, 0)
            if let machine = content?.assumingMemoryBound(to: CChar.self) {
                _machineModel = String.init(utf8String: machine)
                free(content)
            } else {
                _machineModel = ""
            }
        }
        return _machineModel
    }
    
    private static let _fetchMachineOnceToken = "ravv_fetch_machine_once_token"
    
    private static var _machine: MachineType!
    
    public static var machine: MachineType {
        DispatchQueue.once(token: _fetchMachineOnceToken) {
            let mode = machineMode
            switch mode {
            case "Watch1,1":
                _machine = .appleWatch(._38mm)
            case "Watch1,2":
                _machine = .appleWatch(._42mm)
            case "Watch1,7":
                _machine = .appleWatch(._series1_42mm)
            case "Watch2,3":
                _machine = .appleWatch(._series2_38mm)
            case "Watch2,4":
                _machine = .appleWatch(._series2_42mm)
            case "Watch2,6":
                _machine = .appleWatch(._series1_38mm)
            case "iPod1,1":
                _machine = .iPodTouch(._1)
            case "iPod2,1":
                _machine = .iPodTouch(._2)
            case "iPod3,1":
                _machine = .iPodTouch(._3)
            case "iPod4,1":
                _machine = .iPodTouch(._4)
            case "iPod5,1":
                _machine = .iPodTouch(._5)
            case "iPod7,1":
                _machine = .iPodTouch(._6)
            case "iPhone1,1":
                _machine = .iPhone(._1G)
            case "iPhone1,2":
                _machine = .iPhone(._3G)
            case "iPhone2,1":
                _machine = .iPhone(._3GS)
            case "iPhone3,1":
                _machine = .iPhone(._4_GSM)
            case "iPhone3,2":
                _machine = .iPhone(._4)
            case "iPhone3,3":
                _machine = .iPhone(._4_CDMA)
            case "iPhone4,1":
                _machine = .iPhone(._4s)
            case "iPhone5,1", "iPhone5,2":
                _machine = .iPhone(._5)
            case "iPhone5,3", "iPhone5,4":
                _machine = .iPhone(._5c)
            case "iPhone6,1", "iPhone6,2":
                _machine = .iPhone(._5s)
            case "iPhone7,1":
                _machine = .iPhone(._6Plus)
            case "iPhone7,2":
                _machine = .iPhone(._6)
            case "iPhone8,1":
                _machine = .iPhone(._6s)
            case "iPhone8,2":
                _machine = .iPhone(._6sPlus)
            case "iPhone8,4":
                _machine = .iPhone(._se)
            case "iPhone9,1", "iPhone9,3":
                _machine = .iPhone(._7)
            case "iPhone9,2", "iPhone9,4":
                _machine = .iPhone(._7Plus)
            case "iPhone10,1", "iPhone10,4":
                _machine = .iPhone(._8)
            case "iPhone10,2", "iPhone10,5":
                _machine = .iPhone(._8Plus)
            case "iPhone10,3", "iPhone10,6":
                _machine = .iPhone(._X)
            case "iPad1,1":
                _machine = .iPad(._1)
            case "iPad2,1":
                _machine = .iPad(._2_WiFi)
            case "iPad2,2":
                _machine = .iPad(._2_GSM)
            case "iPad2,3":
                _machine = .iPad(._2_CDMA)
            case "iPad2,4":
                _machine = .iPad(._2)
            case "iPad2,5", "iPad2,6", "iPad2,7":
                _machine = .iPad(._mini1)
            case "iPad3,1":
                _machine = .iPad(._3_WiFi)
            case "iPad3,2", "iPad3,3":
                _machine = .iPad(._3_4G)
            case "iPad3,4", "iPad3,5", "iPad3,6":
                _machine = .iPad(._4)
            case "iPad4,1", "iPad4,2", "iPad4,3":
                _machine = .iPad(._air)
            case "iPad4,4", "iPad4,5", "iPad4,6":
                _machine = .iPad(._mini2)
            case "iPad4,7", "iPad4,8", "iPad4,9":
                _machine = .iPad(._mini3)
            case "iPad5,1", "iPad5,2":
                _machine = .iPad(._4)
            case "iPad5,3", "iPad5,4":
                _machine = .iPad(._air2)
            case "iPad6,3", "iPad6,4":
                _machine = .iPad(._pro_97inch)
            case "iPad6,7", "iPad6,8":
                _machine = .iPad(._pro_129inch)
            case "AppleTV2,1":
                _machine = .appleTV(._2)
            case "AppleTV3,1", "AppleTV3,2":
                _machine = .appleTV(._3)
            case "AppleTV5,3":
                _machine = .appleTV(._4)
            case "i386":
                _machine = .simulator(._x86)
            case "x86_64":
                _machine = .simulator(._x64)
            default:
                _machine = .unknown
            }
        }
        return _machine
    }
    
}
