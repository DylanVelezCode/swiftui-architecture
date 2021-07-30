//
//  PokeFavoriteState.swift
//  Poke
//
//  Created by Dylan Vélez on 22/07/21.
//

import Foundation
import PokeModels

@frozen public struct PokeFavoritesState {
    public var list: [Pokemon] = []
    public var isLoading: Bool = false
    public init() { }
}

@frozen public enum PokeFavoritesEvent {
    case fetchPokemon
    case fetchPokemonCompleted(pokemon: [Pokemon])
    case removeFromFavorites(id: Int)
}
