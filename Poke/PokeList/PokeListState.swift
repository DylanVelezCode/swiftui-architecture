//
//  PokeListState.swift
//  Poke
//
//  Created by Dylan Vélez on 21/07/21.
//

import Foundation
import PokeModels

struct PokeListState {
    var list: [Pokemon] = []
    var isLoading = false
}

enum PokeListEvent {
    case fetchPokemon
    case fetchPokemonCompleted(pokemon: [Pokemon])
}
