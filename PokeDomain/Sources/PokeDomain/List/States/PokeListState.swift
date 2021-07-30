//
//  PokeListState.swift
//  Poke
//
//  Created by Dylan Vélez on 21/07/21.
//

import Foundation
import PokeModels
import PokeServices

@frozen public struct PokeListState {
    public var list: [Pokemon] = []
    public var isLoading = false
    
    public init() {
        
    }
}

@frozen public enum PokeListEvent {
    case fetchPokemon
    case fetchPokemonCompleted(pokemon: [Pokemon])
}

extension PokeListEvent: LoggerAction {
    public var logDescription: String {
        return "Action - Fetched Pokemon"
    }
}
