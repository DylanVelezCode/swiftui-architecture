//
//  PokeDetailViewModel.swift
//  Poke
//
//  Created by Dylan Vélez on 29/07/21.
//

import Foundation
import PokeModels

struct PokeDetailViewModel {
    private let pokemon: Pokemon
    
    var url: URL? {
        return URL(string: pokemon.sprites.front)
    }
    
    var pokeNumber: String {
        return "#\(pokemon.id)"
    }
    
    var name: String {
        return pokemon.name.replacingOccurrences(of: "-", with: " ").capitalized
    }
    
    var abilities: [String] {
        return pokemon.abilities.map { $0.name.replacingOccurrences(of: "-", with: " ").capitalized }
    }
    
    var stats: [Stat] {
        return pokemon.stats.map { Stat(base: $0.base, name: $0.name.replacingOccurrences(of: "-", with: " ").capitalized) }
    }
    
    init(pokemon: Pokemon) {
        self.pokemon = pokemon
    }
    
}
