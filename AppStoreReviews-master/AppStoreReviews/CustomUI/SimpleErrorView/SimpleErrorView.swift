//
//  SimpleErrorView.swift
//  App
//
//  Created by uğur on 26.09.2020.
//  Copyright © 2020 ugur. All rights reserved.
//

import UIKit

/// Shows simple error message label and confirm button popup
class SimpleErrorView: UIView {
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var containerView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        ///add border and corner radius
        containerView.layer.borderColor = UIColor.black.withAlphaComponent(0.2).cgColor
        containerView.layer.borderWidth = 1/UIScreen.main.scale
        containerView.layer.cornerRadius = 4
        containerView.layer.masksToBounds = true
    }

    /// pass some data to fill the label
    func configure(with message: String?){
        errorLabel.text = message
    }
    
    /// dismiss on button click action
    @IBAction func okAction(_ sender: Any) {
        UIView.animate(withDuration: 0.3) {
            self.removeFromSuperview()
        }
    }
}
