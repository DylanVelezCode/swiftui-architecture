//
//  PokeFavoriteState.swift
//  Poke
//
//  Created by Dylan Vélez on 22/07/21.
//

import Foundation
import PokeModels

struct PokeFavoritesState {
    var list: [Pokemon] = []
}

enum PokeFavoritesEvent {
    case fetchPokemon
    case fetchPokemonCompleted(pokemon: [Pokemon])
    case removeFromFavorites(id: Int)
}
