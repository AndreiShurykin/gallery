//
//  GalleryCollectionViewCell.swift
//  gallery
//
//  Created by Andrei Shurykin on 14.11.21.
//

import UIKit
import CloudKit
import WebKit

class GalleryCollectionViewCell: UICollectionViewCell, UITextViewDelegate {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(imageView)
        self.addSubview(containerView)
        self.containerView.addSubview(nameLabel)
        self.containerView.addSubview(userUrlTextView)
        self.containerView.addSubview(photoUrlTextView)
        self.photoUrlTextView.delegate = self
        self.userUrlTextView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var imageView = UIImageView(frame: .zero)
    var containerView = UIView(frame: .zero)
    var nameLabel = UILabel(frame: .zero)
    var userUrlTextView = UITextView(frame: .zero)
    var photoUrlTextView = UITextView(frame: .zero)
    var webView = WKWebView(frame: .zero)
    var backButton = UIButton(frame: .zero)
    
    
    func setupViews() {
        
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFit
        
        containerView.backgroundColor = .blue
        
        nameLabel.textAlignment = .center
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.textColor = .black
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        let containerViewHeight = self.frame.height / 10
        let containerViewConstraints = [
            containerView.leftAnchor.constraint(equalTo: self.leftAnchor),
            containerView.rightAnchor.constraint(equalTo: self.rightAnchor),
            containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 50),
            containerView.heightAnchor.constraint(equalToConstant: containerViewHeight)
        ]
        NSLayoutConstraint.activate(containerViewConstraints)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let imageViewConstraints = [
            imageView.leftAnchor.constraint(equalTo: self.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: self.rightAnchor),
            imageView.topAnchor.constraint(equalTo: containerView.bottomAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50)
        ]
        NSLayoutConstraint.activate(imageViewConstraints)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.backgroundColor = .systemPink
        let nameLabelHeight = self.frame.height / 20
        let nameLabelConstraints = [
            nameLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            nameLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: nameLabelHeight)
        ]
        NSLayoutConstraint.activate(nameLabelConstraints)
        
        userUrlTextView.translatesAutoresizingMaskIntoConstraints = false
        userUrlTextView.backgroundColor = .yellow
        let userUrlButtonWidth = self.frame.width / 2
        let userUrlButtonConstraints = [
            userUrlTextView.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            userUrlTextView.widthAnchor.constraint(equalToConstant: userUrlButtonWidth),
            userUrlTextView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            userUrlTextView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ]
        NSLayoutConstraint.activate(userUrlButtonConstraints)
        
        photoUrlTextView.translatesAutoresizingMaskIntoConstraints = false
        photoUrlTextView.backgroundColor = .green
        let photoUrlButtonConstraints = [
            photoUrlTextView.leftAnchor.constraint(equalTo: userUrlTextView.rightAnchor),
            photoUrlTextView.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            photoUrlTextView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            photoUrlTextView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ]
        NSLayoutConstraint.activate(photoUrlButtonConstraints)
    }
    
    func setLabelText(_ text: String?) {
        guard let text = text else {
            return
        }
        nameLabel.text = "Author: " + text
    }
    
    func setUserURLTextViewText(_ text: String?) {
        guard let text = text else {
            return
        }
        let attributedString = NSMutableAttributedString(string: "Click to see more about user")
        attributedString.addAttribute(.link, value: text, range: NSRange(location: 0, length: 28))
        userUrlTextView.attributedText = attributedString
    }
    
    func setPhotoUrlTextViewText(_ text: String?) {
        guard let text = text else {
            return
        }
        let attributedString = NSMutableAttributedString(string: "Click to see more original materials")
        attributedString.addAttribute(.link, value: text, range: NSRange(location: 0, length: 36))
        photoUrlTextView.attributedText = attributedString
        
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        let backButtonHeight = self.frame.height / 20
        backButton.frame = CGRect(x: imageView.frame.origin.x,
                                  y: imageView.frame.origin.y,
                                  width: imageView.frame.width,
                                  height: backButtonHeight)
        backButton.backgroundColor = .systemPink
        backButton.setTitle("Back to gallery", for: .normal)
        backButton.addTarget(self, action: #selector(removeFromView), for: .touchUpInside)
        self.addSubview(backButton)
        webView.frame = CGRect(x: imageView.frame.origin.x,
                               y: imageView.frame.origin.y + backButtonHeight,
                               width: imageView.frame.width,
                               height: imageView.frame.height)
        let request = URLRequest(url: URL)
        webView.load(request)
        self.addSubview(webView)
        return false
    }
    
    @objc func removeFromView() {
        backButton.removeFromSuperview()
        webView.removeFromSuperview()
    }
    
    
}

