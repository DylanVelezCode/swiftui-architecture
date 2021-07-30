//
//  PokeFavoriteReducer.swift
//  Poke
//
//  Created by Dylan Vélez on 22/07/21.
//
import Foundation
import PokeArch
import PokeServices
import PokeInjection
import Combine

public class PokeFavoriteReducer: Reducing, Depending {
    public typealias State = PokeFavoritesState
    public typealias Event = PokeFavoritesEvent
    public typealias Dependencies = FavoritesDependencies
    
    @Inject var dependencies: Dependencies
    
    public init() { }
    
    public func reduce(state: inout PokeFavoritesState, forEvent event: PokeFavoritesEvent) -> Effect<PokeFavoritesEvent> {
        
        switch event {
        case .removeFromFavorites(let id):
            state.list.removeAll(where: { $0.id == id })
        case .fetchPokemonCompleted(let list):
            state.list = list
            state.isLoading = false
        case .fetchPokemon:
            state.isLoading = true
            break
        }
        
        return sideEffect(event: event)
    }
    
    private func sideEffect(event: Event) -> Effect<Event> {
        switch event {
        case .fetchPokemon:
            return dependencies.service.fetchPokemon()
                .map { PokeFavoritesEvent.fetchPokemonCompleted(pokemon: $0) }
                .catch { error in
                    return Just(.fetchPokemonCompleted(pokemon: []))
                }
                .eraseToAnyPublisher()
            
        case .removeFromFavorites(let id):
            dependencies.service.removeFromFavorites(id: id)
        case .fetchPokemonCompleted:
            break
        }
        return nil
    }
}
