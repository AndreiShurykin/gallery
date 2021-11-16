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

class LaunchViewModel {
    
}

extension LaunchViewModel: LaunchViewModelProtocol {
    
    func checkData(_ complition: @escaping() -> Void) {
        DispatchQueue.global().async {
            DataManager.shared.getData { libResult in
                switch libResult{
                    
                case .success(let lib):
                    DispatchQueue.main.async {
                        DataManager.shared.saveData(lib)
                        guard let localPhotos: [LocalPhoto] = DataManager.shared.fetchData() else {
                            return
                        }
                        DispatchQueue.global().async {
                            DataManager.shared.downloadPhoto(localPhotos) { objectsCounter in
                                if objectsCounter == localPhotos.count {
                                    complition()
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
