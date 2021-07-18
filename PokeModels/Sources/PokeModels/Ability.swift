//
//  File.swift
//  
//
//  Created by Dylan Vélez on 17/07/21.
//

import Foundation

public struct Ability: Codable, Equatable {
    public let name: String
    
    private enum OuterKeys: String, CodingKey {
        case ability
    }
    
    private enum CodingKeys: String, CodingKey {
        case name
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: OuterKeys.self)
        let ability = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .ability)
        name = try ability.decode(String.self, forKey: .name)
    }
    
    public init(name: String) {
        self.name = name
    }
}
