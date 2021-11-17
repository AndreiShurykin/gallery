//
//  DataManager.swift
//  gallery
//
//  Created by Andrei Shurykin on 11.11.21.
//

import Foundation
import UIKit
import CoreData

final class DataManager {
    
    static var shared = DataManager()
    private init() {}
    
    func getData(complition: @escaping (Result<PhotoLib, Error>) -> Void) {
        guard let url = URL(string: "http://dev.bgsoft.biz/task/credits.json") else {
            complition(.failure(NSError.init()))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil,
                  let data = data else {
                      complition(.failure(error ?? NSError.init()))
                      return
                  }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let lib = try decoder.decode(PhotoLib.self, from: data)
                complition(.success(lib))
            } catch let error {
                complition(.failure(error))
            }
        }
        task.resume()
    }
    
    func saveData(_ data: PhotoLib) {
        guard let photos = data.array else {
            return
        }
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let context = delegate.persistentContainer.viewContext
        let request = LocalPhoto.fetchRequest() as NSFetchRequest<LocalPhoto>
        do {
            let localPhotos = try context.fetch(request)
            photos.forEach { photo in
                var objectExistFlag = false
                if localPhotos.contains (where: { $0.imageID == photo.imageID }) {
                    objectExistFlag = true
                }
                if !objectExistFlag {
                    let localPhoto = LocalPhoto(context: context)
                    localPhoto.photoUrl = photo.photoUrl
                    localPhoto.userName = photo.userName
                    localPhoto.userUrl = photo.userUrl
                    localPhoto.colors = photo.colors.compactMap { $0 }
                    localPhoto.imageID = photo.imageID
                }
            }
            
        } catch {
            print(error)
        }
        do {
            print("Context will be saved")
            if context.hasChanges {
                try context.save()
                print("Context was saved")
            } else {
                print("There is nothing to save")
            }
        } catch let err {
            print(err)
        }
    }
    
    func fetchData<T>() -> [T]? where T: NSManagedObject {
        guard let delegate = (UIApplication.shared.delegate) as? AppDelegate else {
            return nil
        }
        let context = delegate.persistentContainer.viewContext
        do {
            let request = T.fetchRequest()
            let sort = NSSortDescriptor(key: "userName", ascending: true )
            request.sortDescriptors = [sort]
            return try context.fetch(request) as? [T]
        } catch let err {
            print(err)
            return nil
        }
    }
    
    func isFileExist(_ fileName: String?) -> Bool {
        guard let fileName = fileName else {
            return false
        }
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let url = NSURL(fileURLWithPath: path)
        if let pathComponent = url.appendingPathComponent(fileName) {
            let filePath = pathComponent.path
            let fileManager = FileManager.default
            if (fileManager.fileExists(atPath: filePath)) {
                return true
            }
        }
        return false
    }
    
    func downloadPhoto(_ fileName: String?,_ complition: @escaping (Data?) -> Void) {
        guard let fileName = fileName else {
            complition(nil)
            return
        }
        let urlString = "http://dev.bgsoft.biz/task/" + fileName + ".jpg"
        guard let url = URL(string: urlString) else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            complition(data)
        }
        task.resume()
    }
    
    func savePhotoToFile(_ photoData: Data?,_ fileName: String?) {
        guard let fileName = fileName else {
            return
        }
        let fileManager = FileManager.default
        do {
            let documentDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask,
                                                           appropriateFor:nil, create:false)
            let fileURL = documentDirectory.appendingPathComponent(fileName)
            try photoData?.write(to: fileURL)
            print(fileName + ": saved")
        } catch {
            print(error)
        }
        
    }
    
    func getStoredObject<T>(_ fileName: String?) -> T? where T: ObjectFromFile {
        guard let fileName = fileName else {
            return nil
        }
        let fileManager = FileManager.default
        do {
            let documentDirectiry = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let fileURL = documentDirectiry.appendingPathComponent(fileName)
            let data = try Data(contentsOf: fileURL)
            return T(data: data)
        } catch {
            print(error)
            return nil
        }
    }
    
    func getArrayCount() -> Int {
        var count = 0
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            return 0
        }
        let context = delegate.persistentContainer.viewContext
        let request = LocalPhoto.fetchRequest()
        do {
            let array = try context.fetch(request)
            count = array.count
        } catch {
            print(error)
        }
        return count
    }
}

