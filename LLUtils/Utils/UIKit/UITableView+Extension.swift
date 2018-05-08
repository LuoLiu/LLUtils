//
//  UITableView+Extension.swift
//  LLUtils
//
//  Created by luoliu on 2018/5/8.
//  Copyright © 2018年 ll. All rights reserved.
//

import UIKit

extension UITableView {
    
    // MARK: easy register nib
    func register<T: UITableViewCell>(cellNib nibName: T.Type) {
        let identifier = "\(T.self)"
        register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    func register<T: UITableViewHeaderFooterView>(headerViewNib nibName: T.Type) {
        let identifier = "\(T.self)"
        register(UINib(nibName: identifier, bundle: nil), forHeaderFooterViewReuseIdentifier: identifier)
    }
    
    // MARK: easy register class
    func register<T: UITableViewCell>(cellClass: T.Type) {
        register(cellClass, forCellReuseIdentifier: "\(T.self)")
    }
    
    func register<T: UITableViewHeaderFooterView>(headerFooterView viewClass: T.Type) {
        register(viewClass, forHeaderFooterViewReuseIdentifier: "\(T.self)")
    }
    
    // MARK: easy dequeueReusable
    func dequeueReusableCell<T: UITableViewCell>(_ cellClass: T.Type, for indexPath: IndexPath) -> T {
        let identifer = "\(T.self)"
        if let cell = dequeueReusableCell(withIdentifier: identifer, for: indexPath) as? T {
            return cell
        } else {
            return T(style: .default, reuseIdentifier: identifer)
        }
    }
    
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(_ viewClass: T.Type) -> T {
        let identifer = "\(T.self)"
        if let view = dequeueReusableHeaderFooterView(withIdentifier: identifer) as? T {
            return view
        } else {
            return T(reuseIdentifier: identifer)
        }
    }
    
    // MARK: easy add header / footer
    func addTableHeaderView(height: CGFloat = CGFloat.leastNormalMagnitude) {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: bounds.width, height: height))
        tableHeaderView = header
    }
    
    func addTableFooterView(height: CGFloat = CGFloat.leastNormalMagnitude) {
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: bounds.width, height: height))
        tableFooterView = footer
    }
    
}
