//
//  PokeFavoriteItemViewModel.swift
//  Poke
//
//  Created by Dylan Vélez on 28/07/21.
//

import Foundation
import PokeModels

struct PokeFavoriteItemViewModel {
    private let pokemon: Pokemon
    let onClick: () -> Void
    
    var url: URL? {
        return URL(string: pokemon.sprites.front)
    }
    
    var title: String {
        return pokemon.name.capitalized.replacingOccurrences(of: "-", with: " ")
    }
    
    var pokeNumber: String {
        return "#\(pokemon.id)"
    }
    
    init(pokemon: Pokemon, onClick: @escaping () -> Void) {
        self.pokemon = pokemon
        self.onClick = onClick
    }
}
