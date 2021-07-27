//
//  PokeListMiddleware.swift
//  Poke
//
//  Created by Dylan Vélez on 21/07/21.
//

import Foundation
import PokeArch
import PokeServices
import Combine

class PokeListMiddleware: AnyMiddleware<PokeListState, PokeListEvent> {
    private let service: PokeService
    
    init(service: PokeService) {
        self.service = service
    }
    
    override func intercept(event: PokeListEvent) -> AnyPublisher<PokeListEvent, Never> {
        switch event {
        case .fetchPokemon:
            return service.getPokemonList()
                .map { PokeListEvent.fetchPokemonCompleted(pokemon: $0) }
                .catch { error in
                    return Just(.fetchPokemonCompleted(pokemon: []))
                }
                .eraseToAnyPublisher()
        default:
            return Empty().eraseToAnyPublisher()
        }
    }
}
