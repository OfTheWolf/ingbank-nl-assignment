//
//  AlertPresentable.swift
//  AppStoreReviews
//
//  Created by ugur on 30.10.2020.
//  Copyright © 2020 ING. All rights reserved.
//

import UIKit

/// show or hide  loading indicator
protocol AlertPresentable {
    func showAlert(_ title: String?, _ message: String?)
}

extension UIViewController: AlertPresentable{
    func showAlert(_ title: String? = nil, _ message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}


