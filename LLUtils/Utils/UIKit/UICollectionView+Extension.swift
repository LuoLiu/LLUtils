//
//  UICollectionView+Extension.swift
//  LLUtils
//
//  Created by luoliu on 2018/5/8.
//  Copyright © 2018年 ll. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    // MARK: easy register nib
    func register<T: UICollectionViewCell>(cellNib nibName: T.Type) {
        let identifier = "\(T.self)"
        register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
    }
    
    func register<T: UICollectionReusableView>(headerViewNib nibName: T.Type) {
        let identifier = "\(T.self)"
        register(UINib(nibName: identifier, bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: identifier)
    }
    
    func register<T: UITableViewHeaderFooterView>(footerViewNib nibName: T.Type) {
        let identifier = "\(T.self)"
        register(UINib(nibName: identifier, bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: identifier)
    }
    
    // MARK: easy register class
    func register<T: UICollectionViewCell>(cellClass: T.Type) {
        let identifier = "\(T.self)"
        register(cellClass, forCellWithReuseIdentifier: identifier)
    }
    
    func register<T: UICollectionReusableView>(headerViewClass viewClass: T.Type) {
        let identifier = "\(T.self)"
        register(viewClass, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: identifier)
    }
    
    func register<T: UITableViewHeaderFooterView>(footerViewClass viewClass: T.Type) {
        let identifier = "\(T.self)"
        register(viewClass, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: identifier)
    }
    
    // MARK: easy dequeueReusable
    func dequeueReusableCell<T: UICollectionViewCell>(_ cellClass: T.Type, for indexPath: IndexPath) -> T {
        let identifier = "\(T.self)"
        guard let cell = dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? T else {
            fatalError("You need register \(identifier) before dequeue")
        }
        return cell
    }
    
    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(_ viewClass: T.Type, ofKind kind: String, for indexPath: IndexPath) -> T {
        let identifier = "\(T.self)"
        guard let view = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: identifier, for: indexPath) as? T else {
            fatalError("You need register \(identifier) before dequeue")
        }
        return view
    }
    
    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(header viewClass: T.Type, for indexPath: IndexPath) -> T {
        let identifier = "\(T.self)"
        guard let view = dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: identifier, for: indexPath) as? T else {
            fatalError("You need register \(identifier) before dequeue")
        }
        return view
    }
    
    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(footer viewClass: T.Type, for indexPath: IndexPath) -> T {
        let identifier = "\(T.self)"
        guard let view = dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: identifier, for: indexPath) as? T else {
            fatalError("You need register \(identifier) before dequeue")
        }
        return view
    }
    
}
