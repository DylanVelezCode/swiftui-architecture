//
//  File.swift
//  
//
//  Created by Dylan Vélez on 17/07/21.
//

import Foundation

public struct Sprite: Codable {
    public let front: String
    
    private enum CodingKeys: String, CodingKey {
        case front = "front_default"
    }
}
