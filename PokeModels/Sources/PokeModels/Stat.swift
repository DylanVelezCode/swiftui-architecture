//
//  File.swift
//  
//
//  Created by Dylan Vélez on 17/07/21.
//

import Foundation

public struct Stat: Codable {
    public let base: Int
    public let name: String
    
    private enum OuterKeys: String, CodingKey {
        case base = "base_stat"
        case stat
    }
    
    private enum CodingKeys: String, CodingKey {
        case name
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: OuterKeys.self)
        let stat = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .stat)
        
        name = try stat.decode(String.self, forKey: .name)
        base = try container.decode(Int.self, forKey: .base)
    }
}
