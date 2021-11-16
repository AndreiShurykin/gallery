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
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
    }
    
    func addShadow() {
        self.clipsToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 10
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: 10).cgPath
    }
    
    func addParallaxEffect(_ magnitude: Float) {
        let horizontal = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        horizontal.minimumRelativeValue = -magnitude
        horizontal.maximumRelativeValue = magnitude
        
        let vertical = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        vertical.minimumRelativeValue = -magnitude
        vertical.maximumRelativeValue = magnitude
        
        let group = UIMotionEffectGroup()
        group.motionEffects = [horizontal, vertical]
        self.addMotionEffect(group)
    }
}
