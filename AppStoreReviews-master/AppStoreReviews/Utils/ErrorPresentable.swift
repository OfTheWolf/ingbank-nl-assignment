//
//  ErrorPresentable.swift
//  App
//
//  Created by uğur on 26.09.2020.
//  Copyright © 2020 ugur. All rights reserved.
//

import UIKit

protocol ErrorPresentable {
    func showError(with message: String)
    func hideAllErrors()
}

extension UIViewController: ErrorPresentable{
    func showError(with message: String) {
        hideAllErrors()
        let errorView: SimpleErrorView = UIView.fromNib()
        errorView.frame = UIScreen.main.bounds
        errorView.configure(with: message)
        view.addSubview(errorView)
    }
    
    func hideAllErrors() {
        let errors: [SimpleErrorView] = view.findSubviews()
        errors.forEach {
            $0.removeFromSuperview()
        }
    }
}
