//
//  ViewController.swift
//  gallery
//
//  Created by Andrei Shurykin on 11.11.21.
//

import UIKit

class ViewController: UIViewController {
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.global().async {
            let array = DataManager.shared.getData()
            print()
        }
    }
}
