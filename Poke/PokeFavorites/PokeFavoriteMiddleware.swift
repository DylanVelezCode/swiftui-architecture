//
//  PokeFavoriteMiddleware.swift
//  Poke
//
//  Created by Dylan Vélez on 22/07/21.
//

import Foundation
import PokeArch
import PokeServices
import Combine
import PokeDomain

class PokeFavoriteMiddleware: AnyMiddleware<PokeFavoritesState, PokeFavoritesEvent> {
    private let service: FavoritePokeService
    
    init(service: FavoritePokeService) {
        self.service = service
    }
    
    override func intercept(event: PokeFavoritesEvent) -> AnyPublisher<PokeFavoritesEvent, Never> {
        switch event {
        case .fetchPokemon:
            return service.fetchPokemon()
                .print()
                .map { PokeFavoritesEvent.fetchPokemonCompleted(pokemon: $0) }
                .catch { error in
                    return Just(.fetchPokemonCompleted(pokemon: []))
                }
                .eraseToAnyPublisher()
            
        case .removeFromFavorites(let id):
            service.removeFromFavorites(id: id)
            break
        case .fetchPokemonCompleted:
            break
        }
        
        return Empty().eraseToAnyPublisher()
    }
}
