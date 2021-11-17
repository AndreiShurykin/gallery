//
//  LaunchViewController.swift
//  gallery
//
//  Created by Andrei Shurykin on 14.11.21.
//

import UIKit

final class LaunchViewController: UIViewController {
    
    let viewModel: LaunchViewModelProtocol
    
    init(viewModel: LaunchViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let spinner: UIActivityIndicatorView = {
        let loginSpinner = UIActivityIndicatorView(style: .large)
        loginSpinner.translatesAutoresizingMaskIntoConstraints = false
        loginSpinner.hidesWhenStopped = true
        return loginSpinner
    }()
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(spinner)
        spinner.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        spinner.startAnimating()
        viewModel.checkData {
            DispatchQueue.main.async {
                let galleryViewController = GalleryViewController(viewModel: GalleryViewModel())
                self.navigationController?.pushViewController(galleryViewController, animated: true)
            }
        }
        
    }
}
