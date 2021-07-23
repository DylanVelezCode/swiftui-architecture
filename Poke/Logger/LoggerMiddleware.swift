//
//  LoggerMiddleware.swift
//  Poke
//
//  Created by Dylan Vélez on 23/07/21.
//

import Foundation
import PokeArch
import PokeServices
import Combine

class PokeFavoritesLoggerMiddleware: AnyMiddleware<PokeFavoritesState, PokeFavoritesEvent> {
    private let service: LoggerService
    
    init(service: LoggerService) {
        self.service = service
    }
    
    override func intercept(state: PokeFavoritesState, forEvent event: PokeFavoritesEvent) -> AnyPublisher<PokeFavoritesEvent, Never> {
        switch event {
        case .removeFromFavorites(let id):
            service.log(action: .removedFavorite(id: id))
            break
        case .fetchPokemon:
            service.log(action: .pageViewed(.pokeFavorites))
            break
        case .fetchPokemonCompleted:
            break
        }
        return Empty().eraseToAnyPublisher()
    }
}

class PokeListLoggerMiddleware: AnyMiddleware<PokeListState, PokeListEvent> {
    private let service: LoggerService
    
    init(service: LoggerService) {
        self.service = service
    }
    
    override func intercept(state: PokeListState, forEvent event: PokeListEvent) -> AnyPublisher<PokeListEvent, Never> {
        switch event {
        case .fetchPokemon:
            service.log(action: .pageViewed(.pokeList))
        case .fetchPokemonCompleted:
            break
        }
        return Empty().eraseToAnyPublisher()
    }
}

class PokeMiddleware: AnyMiddleware<PokeState, PokeEvent> {
    private let service: LoggerService
    
    init(service: LoggerService) {
        self.service = service
    }
    
    override func intercept(state: PokeState, forEvent event: PokeEvent) -> AnyPublisher<PokeEvent, Never> {
        switch event {
        case .addToFavorites(let id):
            service.log(action: .favorite(id: id))
        case .removeFromFavorites(let id):
            service.log(action: .removedFavorite(id: id))
        case .fetchIsFavoriteCompleted, .fetchIsFavorite:
            break
        }
        return Empty().eraseToAnyPublisher()
    }
}
