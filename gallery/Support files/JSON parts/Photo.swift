//
//  Photo.swift
//  gallery
//
//  Created by Andrei Shurykin on 11.11.21.
//

import Foundation

class Photo: Decodable {
    
    internal init(photoUrl: String?, userName: String?, userUrl: String?, colors: [String?], imageID: String?) {
        self.photoUrl = photoUrl
        self.userName = userName
        self.userUrl = userUrl
        self.colors = colors
        self.imageID = imageID
    }
    
    let photoUrl: String?
    let userName: String?
    let userUrl: String?
    let colors: [String?]
    var imageID: String?
}
