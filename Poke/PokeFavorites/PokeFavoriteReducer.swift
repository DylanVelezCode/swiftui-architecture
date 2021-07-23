//
//  PokeFavoriteReducer.swift
//  Poke
//
//  Created by Dylan Vélez on 22/07/21.
//
import Foundation
import PokeArch
class PokeFavoriteReducer: AnyReducer<PokeFavoritesState, PokeFavoritesEvent> {
    override func reduce(state: inout PokeFavoritesState, forEvent event: PokeFavoritesEvent) {
        switch event {
        case .removeFromFavorites(let id):
            state.list.removeAll(where: { $0.id == id })
        case .fetchPokemonCompleted(let list):
            state.list = list
        case .fetchPokemon:
            break
        }
    }
}
