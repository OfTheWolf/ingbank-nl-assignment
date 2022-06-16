//
//  LoadingPresantable.swift
//  App
//
//  Created by uğur on 26.09.2020.
//  Copyright © 2020 ugur. All rights reserved.
//

import UIKit
import Extensions

/// show or hide  loading indicator
protocol LoadingPresentable {
    func showLoading()
    func hideLoading()
}

/// Show loading for all UIViewControllers
extension UIViewController: LoadingPresentable {
    /// adds a UIActivityIndicatorView to the current view
    func showLoading(){
        hideLoading()
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        indicator.hidesWhenStopped = true
        view.addSubview(indicator)
        indicator.startAnimating()
    }
    
    /// removes all UIActivityIndicatorViews from the current view
    func hideLoading(){
        let indicators: [UIActivityIndicatorView] = view.findSubviews()
        indicators.forEach {
            $0.stopAnimating()
            $0.removeFromSuperview()
        }
    }
}

