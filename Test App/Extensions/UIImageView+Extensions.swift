//
//  ImageView+Extensions.swift
//  Test App
//
//  Created by Matajar on 14/09/21.
//

import UIKit
extension UIImageView {
    func roundedImage() {
        self.layer.cornerRadius = (self.frame.size.width) / 2;
        self.clipsToBounds = true
        self.layer.borderWidth = 3.0
        self.layer.borderColor = UIColor.white.cgColor
    }
}
