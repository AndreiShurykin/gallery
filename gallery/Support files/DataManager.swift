//
//  DataManager.swift
//  gallery
//
//  Created by Andrei Shurykin on 11.11.21.
//

import Foundation

class DataManager {
    
    static var shared = DataManager()
    private init() {}
    
    func getData() -> PhotoLib {
        var dataLib = PhotoLib(lib: [Photo(photo_url: "", user_name: "", user_url: "", colors: [""])])
            guard let url = URL(string: "http://dev.bgsoft.biz/task/credits.json") else {
                return PhotoLib(lib: [Photo(photo_url: "", user_name: "", user_url: "", colors: [""])])
            }
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil,
                let data = data else {
                    return
                }
                do {
                    let lib = try JSONDecoder().decode(PhotoLib.self, from: data)
                    dataLib = lib
                } catch let error{
                    print(error)
                }
            }
            task.resume()
        return dataLib
        }
        
}
