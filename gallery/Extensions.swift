//
//  Extensions.swift
//  gallery
//
//  Created by Andrei Shurykin on 14.11.21.
//

import UIKit


protocol ObjectFromFile {
    init?(data: Data)
}

extension UIImage: ObjectFromFile {
    
}

extension UIView {
    func roundCorners() {
        self.layer.cornerRadius = 20
    }
}
