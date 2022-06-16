//
//  UITableView+.swift
//  
//
//  Created by uğur on 26.09.2020.
//

import UIKit

public extension UITableView{
    func registerClass<T: UITableViewCell>(for type: T.Type, bundle: Bundle? = nil) {
           let className = String(describing: type)
        register(T.self, forCellReuseIdentifier: className)
    }
    
    func registerNib<T: UITableViewCell>(for type: T.Type, bundle: Bundle? = nil) {
           let className = String(describing: type)
           let nib = UINib(nibName: className, bundle: bundle)
           register(nib, forCellReuseIdentifier: className)
    }
    
    func dequeueCell<T: UITableViewCell>(for type: T.Type, at indexPath: IndexPath) -> T{
        let className = String(describing: type)
        return dequeueReusableCell(withIdentifier: className, for: indexPath) as! T
    }
}
