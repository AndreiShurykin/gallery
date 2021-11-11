//
//  PhotoLib.swift
//  gallery
//
//  Created by Andrei Shurykin on 11.11.21.
//

import Foundation

class PhotoLib: Decodable {
    
    init(lib: [Photo]?) {
        self.array = lib
    }
    
    var array: [Photo]?
    
    required init(from decoder: Decoder) throws {
        
        // 1
        // Create a decoding container using DynamicCodingKeys
        // The container will contain all the JSON first level key
        let container = try decoder.container(keyedBy: DynamicCodingKeys.self)
        var tempArray = [Photo]()
        
        // 2
        // Loop through each key in container
        for key in container.allKeys {
            // Decode Photo using key & keep decoded Photo object in tempArray
            let decodedObject = try container.decode(Photo.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
            tempArray.append(decodedObject)
        }
        
        // 3
        // Finish decoding all Photo objects. Thus assign tempArray to array.
        array = tempArray
    }
    
    
}
