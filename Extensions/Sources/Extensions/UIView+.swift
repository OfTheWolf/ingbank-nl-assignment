//
//  UIView+.swift
//  
//
//  Created by uğur on 26.09.2020.
//

import UIKit

public extension UIView {
    /// find specified type of subviews recursively
    func findSubviews<T: UIView>() -> [T] {
        var subviews = [T]()
        self.subviews.forEach { subview in
            subviews += subview.findSubviews() as [T]
            if let subview = subview as? T {
                subviews.append(subview)
            }
        }
        return subviews
    }
    
    /// load nib for the specified type
    class func fromNib<T: UIView>() -> T {
        return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    
    /// add constraints to all edges with insets
    /// - Parameters:
    ///   - toView: added view who needs constraints
    ///   - insets: view edge insets to parent
    func pinEdges(_ toView: UIView, insets: UIEdgeInsets){
        toView.translatesAutoresizingMaskIntoConstraints = false
        toView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets.left).isActive = true
        toView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: insets.right).isActive = true
        toView.topAnchor.constraint(equalTo: topAnchor, constant: insets.top).isActive = true
        toView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: insets.bottom).isActive = true
    }
}

