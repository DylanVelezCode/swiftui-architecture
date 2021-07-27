//
//  PokeListItemMiddleware.swift
//  Poke
//
//  Created by Dylan Vélez on 22/07/21.
//

import Foundation
import PokeArch
import PokeServices
import Combine

class PokeListItemMiddleware: AnyMiddleware<PokeState, PokeEvent> {
    private let service: FavoritePokeService
    
    init(service: FavoritePokeService) {
        self.service = service
    }
    
    override func intercept(event: PokeEvent) -> AnyPublisher<PokeEvent, Never> {
        switch event {
        case .fetchIsFavorite(let id):
            return Just(.fetchIsFavoriteCompleted(service.fetchFavorites().contains(id))).eraseToAnyPublisher()
        case .addToFavorites(let id):
            service.addToFavorites(id: id)
            break
        case .removeFromFavorites(let id):
            service.removeFromFavorites(id: id)
            break
        case .fetchIsFavoriteCompleted:
            break
        }
        
        return Empty().eraseToAnyPublisher()
    }
}
