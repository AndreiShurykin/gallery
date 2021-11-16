//
//  GalleryViewController.swift
//  gallery
//
//  Created by Andrei Shurykin on 13.11.21.
//

import UIKit

class GalleryViewController: UIViewController {

    let viewModel: GalleryViewModelProtocol
    
    init(viewModel: GalleryViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addCollectionView()
    }
    
    func addCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let galleryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        galleryCollectionView.isPagingEnabled = true
        layout.scrollDirection = .horizontal
        galleryCollectionView.backgroundColor = .black
        self.view.addSubview(galleryCollectionView)
        galleryCollectionView.translatesAutoresizingMaskIntoConstraints = false
        var galleryColloctionViewConstraints = [NSLayoutConstraint]()
        galleryColloctionViewConstraints.append(NSLayoutConstraint(item: galleryCollectionView, attribute: .leading, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .leading, multiplier: 1, constant: 0))
        galleryColloctionViewConstraints.append(NSLayoutConstraint(item: galleryCollectionView, attribute: .width, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .width, multiplier: 1, constant: 0))
        galleryColloctionViewConstraints.append(NSLayoutConstraint(item: galleryCollectionView, attribute: .bottom, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1, constant: 0))
        galleryColloctionViewConstraints.append(NSLayoutConstraint(item: galleryCollectionView, attribute: .height, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .height, multiplier: 1, constant: 0))
        NSLayoutConstraint.activate(galleryColloctionViewConstraints)
        galleryCollectionView.delegate = self
        galleryCollectionView.dataSource = self
        galleryCollectionView.register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
}

extension GalleryViewController: UICollectionViewDelegate {
    
}

extension GalleryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.arrayCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? GalleryCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setupViews()
        let imageName = viewModel.photoObjects[indexPath.row].imageID
        cell.imageView.image = viewModel.getStoredObject(imageName)
        cell.setLabelText(viewModel.photoObjects[indexPath.row].userName)
        cell.setUserURLTextViewText(viewModel.photoObjects[indexPath.row].userUrl)
        cell.setPhotoUrlTextViewText(viewModel.photoObjects[indexPath.row].photoUrl)
        return cell
    }
}

extension GalleryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width, height: view.bounds.height)
    }
}

