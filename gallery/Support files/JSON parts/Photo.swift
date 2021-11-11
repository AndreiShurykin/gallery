//
//  Photo.swift
//  gallery
//
//  Created by Andrei Shurykin on 11.11.21.
//

import Foundation

class Photo: Decodable {
    
    internal init(photo_url: String?, user_name: String?, user_url: String?, colors: [String?]) {
        self.photo_url = photo_url
        self.user_name = user_name
        self.user_url = user_url
        self.colors = colors
    }
    
    let photo_url: String?
    let user_name: String?
    let user_url: String?
    let colors: [String?]
}
