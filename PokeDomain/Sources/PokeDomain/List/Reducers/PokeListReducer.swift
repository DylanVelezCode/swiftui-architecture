//
//  PokeListReducer.swift
//  Poke
//
//  Created by Dylan Vélez on 21/07/21.
//

import Foundation
import PokeArch
import Combine
import PokeServices
import PokeInjection

public struct PokeListReducer: Reducing, Depending {
    public typealias State = PokeListState
    public typealias Event = PokeListEvent
    public typealias Dependencies = PokeListDependencies
    
    @Inject public var dependencies: Dependencies
    
    public init() { }
    
    public func reduce(state: inout State, forEvent event: Event) -> Effect<Event> {
        print(dependencies)
        switch event {
        case .fetchPokemon:
            state.list = []
            state.isLoading = true
        case .fetchPokemonCompleted(let newPokemon):
            state.list = newPokemon
            state.isLoading = false
        }
        
        return sideEffect(event: event)
    }
    
    private func sideEffect(event: PokeListEvent) -> Effect<PokeListEvent> {
        switch event {
        case .fetchPokemon:
            let logger: AnyPublisher<PokeListEvent, Never> = {
                dependencies.loggerService.log(action: event)
                return Empty().eraseToAnyPublisher()
            }()
            return dependencies.listService.getPokemonList()
                .map(PokeListEvent.fetchPokemonCompleted)
                .replaceError(with: .fetchPokemonCompleted(pokemon: []))
                .merge(with: logger)
                .eraseToAnyPublisher()
        case .fetchPokemonCompleted:
            return nil
        }
    }
}
