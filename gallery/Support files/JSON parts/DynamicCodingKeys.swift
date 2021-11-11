//
//  DynamicCodingKeys.swift
//  gallery
//
//  Created by Andrei Shurykin on 11.11.21.
//

import Foundation

final class DynamicCodingKeys: CodingKey {
    
    // Use for string-keyed dictionary
    var stringValue: String
    init?(stringValue: String) {
        self.stringValue = stringValue
    }
    
    // Use for integer-keyed dictionary
    var intValue: Int?
    init?(intValue: Int) {
        // We are not using this, thus just return nil
        return nil
    }
}
