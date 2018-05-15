//
//  AuthManager.swift
//  LLUtils
//
//  Created by luoliu on 2018/5/9.
//  Copyright © 2018年 ll. All rights reserved.
//

import UIKit
import AVFoundation
import AddressBook
import Contacts
import MapKit

private let kCameraAuthed       = "CameraAuthed"
private let kMicAuthed          = "MicAuthed"
private let kLocationAuthed     = "LocationAuthed"
private let kAddressBookAuthed  = "AddressBookAuthed"

private let kAlertTitle         = "提示"
private let kAlertCancelTitle   = "不允许"
private let kAlertDefaultTitle  = "允许"

private let kCameraAlertMsg     = "\(AppInfo.displayName)请求访问您的摄像头"
private let kMicAlertMsg        = "\(AppInfo.displayName)请求访问您的麦克风"
private let kAddressAlertMsg    = "\(AppInfo.displayName)请求访问您的通讯录"
private let kLocationAlertMsg   = "\(AppInfo.displayName)请求开启您的定位服务"

typealias ActionHandler = (() -> Void)

class DeviceAuthManager {
    
    static let shared = DeviceAuthManager()
    
    // 相机权限
    public var cameraAuthed: Bool {
        get {
            return UserDefaults.standard.bool(forKey: kCameraAuthed)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: kCameraAuthed)
            UserDefaults.standard.synchronize()
        }
    }
    
    public func requestCameraAuth(allowed allowHandler: ActionHandler?,
                                  denied denyHandler: ActionHandler?) {
        
        let mediaType = AVMediaType.video
        let authStatus = AVCaptureDevice.authorizationStatus(for: mediaType)
        
        switch authStatus {
        case .authorized:
            self.cameraAuthed = true
            allowHandler?()
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: mediaType) { granted in
                DispatchQueue.main.async {
                    self.cameraAuthed = granted
                    if granted {
                        allowHandler?()
                    } else {
                        denyHandler?()
                    }
                }
            }
        case .denied, .restricted:
            showCustomRequestAlert(message: kCameraAlertMsg, denyHandler: denyHandler)
        }
    }
    
    // 麦克风权限
    public var micAuthed: Bool {
        get {
            return UserDefaults.standard.bool(forKey: kMicAuthed)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: kMicAuthed)
            UserDefaults.standard.synchronize()
        }
    }
    
    public func requestMicAuth(allowed allowHandler: ActionHandler?,
                               denied denyHandler: ActionHandler?) {
        
        let audioSession = AVAudioSession.sharedInstance()
        let permission = audioSession.recordPermission()
        
        switch permission {
        case .granted:
            self.micAuthed = true
            allowHandler?()
        case .undetermined:
            AVAudioSession.sharedInstance().requestRecordPermission({ granted in
                DispatchQueue.main.async {
                    self.micAuthed = granted
                    if granted {
                        allowHandler?()
                    } else {
                        denyHandler?()
                    }
                }
            })
        case .denied:
            showCustomRequestAlert(message: kMicAlertMsg, denyHandler: denyHandler)
        }
    }
    
    // 通讯录权限
    public var addressBookAuthed: Bool {
        get {
            return UserDefaults.standard.bool(forKey: kAddressBookAuthed)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: kAddressBookAuthed)
            UserDefaults.standard.synchronize()
        }
    }
    
    public func requestAddressBookAuth(allowed allowHandler: ActionHandler?,
                                       denied denyHandler: ActionHandler?) {
        
        if #available(iOS 9.0, *) {
            let entityType = CNEntityType.contacts
            let authState = CNContactStore.authorizationStatus(for: entityType)
            
            switch authState {
            case .authorized:
                self.addressBookAuthed = true
                allowHandler?()
            case .notDetermined:
                CNContactStore().requestAccess(for: entityType) { (granted, _) in
                    DispatchQueue.main.async {
                        self.addressBookAuthed = granted
                        if granted {
                            allowHandler?()
                        } else {
                            denyHandler?()
                        }
                    }
                }
            case .denied, .restricted:
                showCustomRequestAlert(message: kAddressAlertMsg, denyHandler: denyHandler)
            }
        } else {
            // iOS 9 earlier
            let authState = ABAddressBookGetAuthorizationStatus()
            
            switch authState {
            case .authorized:
                self.addressBookAuthed = true
                allowHandler?()
            case .notDetermined:
                let addressBook = ABAddressBookCreate().takeRetainedValue()
                ABAddressBookRequestAccessWithCompletion(addressBook, { (granted, _) in
                    DispatchQueue.main.async {
                        self.addressBookAuthed = granted
                        if granted {
                            allowHandler?()
                        } else {
                            denyHandler?()
                        }
                    }
                })
            case .denied, .restricted:
                showCustomRequestAlert(message: kAddressAlertMsg, denyHandler: denyHandler)
            }
        }
    }
    
    // 定位权限
    public var locationAuthed: Bool {
        get {
            return UserDefaults.standard.bool(forKey: kLocationAuthed)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: kLocationAuthed)
            UserDefaults.standard.synchronize()
        }
    }
    
    public func requestLocationAuth(allowed allowHandler: ActionHandler?,
                                    denied denyHandler: ActionHandler?) {
        
        let authState = CLLocationManager.authorizationStatus()
        
        switch authState {
        case .authorizedAlways, .authorizedWhenInUse:
            self.locationAuthed = true
        case .notDetermined:
            // TODO: 自定义 CLLocationManager
            print("notDetermined")
        case .denied, .restricted:
            showCustomRequestAlert(message: kLocationAlertMsg, denyHandler: denyHandler)
        }
        
    }
    
    // 打开系统设置界面
    private func openSystermSetting() {
        guard let settingsURL = URL(string: UIApplicationOpenSettingsURLString) else {
            return
        }
        if UIApplication.shared.canOpenURL(settingsURL) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(settingsURL)
            }
        }
    }
    
    // 自定义请求弹窗
    private func showCustomRequestAlert(message: String, denyHandler: ActionHandler?) {
//        let alert = UIAlertController.alert(title: kAlertTitle, message: message, leftTitle: kAlertCancelTitle, leftHandler: { _ in
//            denyHandler?()
//        }, rightTitle: kAlertDefaultTitle) { _ in
//            self.openSystermSetting()
//        }
//        DispatchQueue.main.async {
//            UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true)
//        }
        // TODO: show alert

    }
    
}

