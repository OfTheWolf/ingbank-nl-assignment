//
//  SpinnerView.swift
//  App
//
//  Created by self on 26.09.2020.
//  Copyright © 2020 ugur. All rights reserved.
//

import UIKit

class SpinnerView: UIView {
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
        self.addSubview(view)
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        activityIndicator.center = CGPoint(x: bounds.midX, y: bounds.midY)
    }

    func startAnimating(){
        activityIndicator.startAnimating()
    }
    
    func stopAnimating(){
        activityIndicator.stopAnimating()
    }
}
