//
//  ShareViewModel.swift
//  footish
//
//  Created by luoliu on 2018/5/11.
//  Copyright © 2018年 四川奇迹. All rights reserved.
//

import UIKit

enum ShareType {
    
    case sina
    case qq
    case qZone
    case wechatSession
    case wechatTimeline
    case copyLink
    
    var item: ShareItemModel {
        // TODO: 判断是否安装
        switch self {
        case .sina:
            return ShareItemModel(
                name: "微博",
                logo: #imageLiteral(resourceName: "icon_share_sina"),
                isInstalled: true)
        case .qq:
            return ShareItemModel(
                name: "QQ",
                logo: #imageLiteral(resourceName: "icon_share_qq"),
                isInstalled: true)
        case .qZone:
            return ShareItemModel(
                name: "QQ空间",
                logo: #imageLiteral(resourceName: "icon_share_qzone"),
                isInstalled: true)
        case .wechatSession:
            return ShareItemModel(
                name: "微信",
                logo: #imageLiteral(resourceName: "icon_share_wechat_session"),
                isInstalled: true)
        case .wechatTimeline:
            return ShareItemModel(
                name: "朋友圈",
                logo: #imageLiteral(resourceName: "icon_share_wechat_timeline"),
                isInstalled: true)
        case .copyLink:
            return ShareItemModel(
                name: "复制链接",
                logo: #imageLiteral(resourceName: "icon_share_link"),
                isInstalled: true)
        }
    }
    
}

class ShareViewModel {
    
    private let shareTypes: [ShareType] = [.sina, .qq, .qZone, .wechatSession, .wechatTimeline, .copyLink]
    
    func numberOfItems() -> Int {
        return shareTypes.count
    }
    
    func itemForIndex(_ indexPath: IndexPath) -> ShareItemModel {
        return shareTypes[indexPath.row].item
    }
    
}

struct ShareItemModel {
    
    let name: String
    
    let logo: UIImage?
    
    let isInstalled: Bool
    
    init(name title: String, logo image: UIImage?, isInstalled: Bool) {
        name = title
        logo = image
        self.isInstalled = isInstalled
    }
    
}
