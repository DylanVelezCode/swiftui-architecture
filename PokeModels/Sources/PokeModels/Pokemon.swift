//
//  File.swift
//  
//
//  Created by Dylan Vélez on 17/07/21.
//

import Foundation

public typealias Decimetre = Int
public typealias Hectogram = Int

public struct Pokemon: Identifiable, Codable, Hashable {
    public let id: Int
    public let name: String
    public let height: Decimetre
    public let weight: Hectogram
    public let abilities: [Ability]
    public let sprites: Sprite
    public let types: [PokeType]
    public let stats: [Stat]
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public init(id: Int, name: String, height: Decimetre, weight: Hectogram, abilities: [Ability], sprites: Sprite, types: [PokeType], stats: [Stat]) {
        self.id = id
        self.name = name
        self.height = height
        self.weight = weight
        self.abilities = abilities
        self.sprites = sprites
        self.types = types
        self.stats = stats
    }
}

extension Pokemon: Equatable {
    public static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        return lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.height == rhs.height &&
        lhs.weight == rhs.weight &&
        lhs.abilities == rhs.abilities &&
        lhs.sprites == rhs.sprites &&
        lhs.types == rhs.types &&
        lhs.stats == rhs.stats
    }
}
