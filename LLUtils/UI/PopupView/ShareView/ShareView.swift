//
//  ShareView.swift
//  footish
//
//  Created by luoliu on 2018/5/11.
//  Copyright © 2018年 四川奇迹. All rights reserved.
//

import UIKit

private let kShareViewHeight: CGFloat = 250.0
private let kItemsViewHeight: CGFloat = 210.0

class ShareView: PopupView {
    
    private let viewModel = ShareViewModel()
    
    static func instance() -> ShareView {
        return ShareView(frame: CGRect(x: 0, y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.height, height: kShareViewHeight))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initializeSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var itemsView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        layout.itemSize = CGSize(width: 70.0, height: 92.0)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let frame = CGRect(x: 0, y: kShareViewHeight, width: UIScreen.main.bounds.width, height: kItemsViewHeight)
        let itemsView = UICollectionView(frame: frame, collectionViewLayout: layout)
        itemsView.backgroundColor = .clear
        itemsView.dataSource = self
        itemsView.delegate = self
        itemsView.register(UINib(nibName: ShareItemCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: ShareItemCollectionViewCell.identifier)

        return itemsView
    }()

    
}

// MARK: - UICollectionView DataSource
extension ShareView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShareItemCollectionViewCell.identifier, for: indexPath) as! ShareItemCollectionViewCell
        let item = viewModel.itemForIndex(indexPath)
        cell.configWith(item: item)
        
        return cell
    }
    
}

// MARK: - UICollectionView Delegate
extension ShareView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = viewModel.itemForIndex(indexPath)
        print(item.name)
    }
    
}

// MARK: - Private
extension ShareView {
    
    private func initializeSubviews() {
//        self.hero.isEnabled = true
        self.backgroundColor = UIColor.colorWithHex(0x131A2B)
        self.addSubview(itemsView)

        configCornerRadii()
        configAnimation()
        addTitle()
        addCloseBtn()
    }
    
    private func configAnimation() {
        showAnimation = { [weak self] in
            guard let weakSelf = self else { return }
            UIView.animate(withDuration: 0.3, animations: {
                weakSelf.frame.origin.y = UIScreen.main.bounds.height - kShareViewHeight
            })
            UIView.animate(withDuration: 0.2, delay: 0.15, options: [], animations: {
                weakSelf.itemsView.frame.origin.y = 40
            }, completion: nil)
        }
        
        hideAnimation = { [weak self] in
            guard let weakSelf = self else { return }
            UIView.animate(withDuration: 0.3, animations: {
                weakSelf.frame.origin.y = UIScreen.main.bounds.height
                weakSelf.alpha = 0.0
            }, completion: { _ in
                self?.removeFromSuperview()
            })
        }

    }
    
    // 标题
    private func addTitle() {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 11)
        label.text = "分享到"
        self.addSubview(label)
//        label.snp.makeConstraints { maker in
//            maker.top.equalToSuperview().offset(15.0)
//            maker.centerX.equalToSuperview()
//        }
    }
    
    // 关闭按钮
    private func addCloseBtn() {
        let closeBtn = UIButton(type: .custom)
        closeBtn.setBackgroundImage(#imageLiteral(resourceName: "btn_close"), for: .normal)
        self.addSubview(closeBtn)
//        closeBtn.snp.makeConstraints { maker in
//            maker.size.equalTo(CGSize(width: 12.0, height: 12.0))
//            maker.right.equalToSuperview().offset(-15.0)
//            maker.top.equalToSuperview().offset(15.0)
//        }
        closeBtn.addTarget(self, action: #selector(hide), for: .touchUpInside)
    }
    
    // 顶部圆角
    private func configCornerRadii() {
        let maskPath = UIBezierPath(roundedRect: self.bounds,
                                    byRoundingCorners: [.topLeft, .topRight],
                                    cornerRadii: CGSize(width: 10.0, height: 10.0))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    
}
