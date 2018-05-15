//
//  ShareItemCollectionViewCell.swift
//  footish
//
//  Created by luoliu on 2018/5/11.
//  Copyright © 2018年 四川奇迹. All rights reserved.
//

import UIKit

class ShareItemCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ShareItemCollectionViewCell"

    @IBOutlet weak var iconImgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configWith(item: ShareItemModel) {
        iconImgView.image = item.logo
        titleLabel.text = item.name
    }
    
}
