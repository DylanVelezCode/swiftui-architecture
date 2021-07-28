//
//  PokeListItemReducer.swift
//  Poke
//
//  Created by Dylan Vélez on 22/07/21.
//
import Foundation
import PokeArch
import Combine
import PokeServices

public class PokeListItemReducer: Reducing, Depending {
    public typealias State = PokeState
    public typealias Event = PokeEvent
    
    var dependencies: Dependencies
    
    public required init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    private func sideEffect(event: PokeEvent) -> Effect<PokeEvent> {
        switch event {
        case .fetchIsFavorite(let id):
            return Just(.fetchIsFavoriteCompleted(dependencies.favoriteService.fetchFavorites().contains(id))).eraseToAnyPublisher()
        case .addToFavorites(let id):
            dependencies.favoriteService.addToFavorites(id: id)
        case .removeFromFavorites(let id):
            dependencies.favoriteService.removeFromFavorites(id: id)
        case .fetchIsFavoriteCompleted:
            break
        }
        return nil
    }
    
    public func reduce(state: inout PokeState, forEvent event: PokeEvent) -> Effect<PokeEvent> {
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
        
        return sideEffect(event: event)
    }
}

extension PokeListItemReducer {
    public struct Dependencies {
        let favoriteService: FavoritePokeService
        public init(favoriteService: FavoritePokeService) {
            self.favoriteService = favoriteService
        }
    }
}