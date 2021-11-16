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
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    let layout = UICollectionViewFlowLayout()
    var galleryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addCollectionView()
    }
    
    func addCollectionView() {
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        galleryCollectionView.collectionViewLayout = layout
        galleryCollectionView.isPagingEnabled = true
        galleryCollectionView.backgroundColor = .blue
        layout.scrollDirection = .horizontal
        galleryCollectionView.backgroundColor = .white
        self.view.addSubview(galleryCollectionView)
        galleryCollectionView.translatesAutoresizingMaskIntoConstraints = false
        let galleryCollectionViewConstraints = [
            galleryCollectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            galleryCollectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            galleryCollectionView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1),
            galleryCollectionView.bottomAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.bottomAnchor, multiplier: 1)
        ]
        NSLayoutConstraint.activate(galleryCollectionViewConstraints)
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

