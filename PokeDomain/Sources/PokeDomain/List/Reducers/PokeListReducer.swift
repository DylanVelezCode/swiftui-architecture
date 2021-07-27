//
//  PokeListReducer.swift
//  Poke
//
//  Created by Dylan Vélez on 21/07/21.
//

import Foundation
import PokeArch

public class PokeListReducer: AnyReducer<PokeListState, PokeListEvent> {
    
    override public func reduce(state: inout PokeListState, forEvent event: PokeListEvent) {
        switch event {
        case .fetchPokemon:
            state.list = []
            state.isLoading = true
        case .fetchPokemonCompleted(let newPokemon):
            state.list = newPokemon
            state.isLoading = false
        }
    }
}
