//
//  File.swift
//  
//
//  Created by Dylan Vélez on 17/07/21.
//

import Foundation

public struct PokeType: Codable {
    public let name: String
    
    private enum OuterKeys: String, CodingKey {
        case type
    }
    
    private enum CodingKeys: String, CodingKey {
        case name
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: OuterKeys.self)
        let type = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .type)
        name = try type.decode(String.self, forKey: .name)
    }
}
