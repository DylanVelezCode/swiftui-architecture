//
//  PokeListItemReducer.swift
//  Poke
//
//  Created by Dylan Vélez on 22/07/21.
//
import Foundation
import PokeArch
public class PokeListItemReducer: AnyReducer<PokeState, PokeEvent> {
    override public func reduce(state: inout PokeState, forEvent event: PokeEvent) {
        switch event {
        case .addToFavorites:
            state.isFavorite = true
        case .removeFromFavorites:
            state.isFavorite = false
        case .fetchIsFavoriteCompleted(let isFavorite):
            state.isFavorite = isFavorite
        case .fetchIsFavorite:
            break
        }
    }
}
