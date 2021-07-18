//
//  File.swift
//  
//
//  Created by Dylan Vélez on 17/07/21.
//

import Foundation

public typealias Decimetre = Int
public typealias Hectogram = Int

public struct Pokemon: Identifiable, Codable {
    public let id: Int
    public let name: String
    public let height: Decimetre
    public let weight: Hectogram
    public let abilities: [Ability]
    public let sprites: Sprite
    public let types: [PokeType]
    public let stats: [Stat]
}
