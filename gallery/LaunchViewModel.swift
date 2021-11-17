//
//  LaunchViewModel.swift
//  gallery
//
//  Created by Andrei Shurykin on 14.11.21.
//

import Foundation

protocol LaunchViewModelProtocol {
    func checkData(_ complition: @escaping() -> Void)
}

final class LaunchViewModel {
    
}

extension LaunchViewModel: LaunchViewModelProtocol {
    
    func checkData(_ complition: @escaping() -> Void) {
        DispatchQueue.global().async {
            DataManager.shared.getData { libResult in
                switch libResult{
                    
                case .success(let lib):
                    DispatchQueue.main.async {
                        complition()
                        DataManager.shared.saveData(lib)
                        guard let localPhotos: [LocalPhoto] = DataManager.shared.fetchData() else {
                            return
                        }
                        DispatchQueue.global().async {
                            localPhotos.forEach { item in
                                guard let fileName = item.imageID else {
                                    return
                                }
                                if DataManager.shared.isFileExist(fileName) {
                                } else {
                                    DataManager.shared.downloadPhoto(fileName) { data in
                                        DataManager.shared.savePhotoToFile(data, fileName)
                                    }
                                }
                            }
                        }
                    }
                case .failure(_):
                    print("Error")
                }
            }
        }
    }
}
