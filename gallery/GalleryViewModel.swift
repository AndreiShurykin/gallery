//
//  GalleryViewModel.swift
//  gallery
//
//  Created by Andrei Shurykin on 13.11.21.
//

import Foundation
import UIKit

protocol GalleryViewModelProtocol {
    var arrayCount: Int { get }
    var photoObjects: [LocalPhoto] { get }
    func getStoredObject(_ fileName: String?) -> UIImage
    func isFileExist(_ fileName: String) -> Bool
}

final class GalleryViewModel {
    var arrayCount: Int {
        return DataManager.shared.getArrayCount()
    }
    
    var photoObjects: [LocalPhoto] {
        guard let objects: [LocalPhoto] = DataManager.shared.fetchData() else {
            return [LocalPhoto()]
        }
        return objects
    }
    
}

extension GalleryViewModel: GalleryViewModelProtocol {
    func getStoredObject(_ fileName: String?) -> UIImage {
        guard let image: UIImage = DataManager.shared.getStoredObject(fileName) else {
            return UIImage()
        }
        return image
    }
    
    func isFileExist(_ fileName: String) -> Bool {
        if DataManager.shared.isFileExist(fileName) {
            return true
        } else {
            return false
        }
    }
}
