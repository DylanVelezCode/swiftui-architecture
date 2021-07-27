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

public protocol LogEvent {
    var action: LoggerService.LogAction? { get }
}

public class LoggerMiddleware<State, Event: LogEvent>: AnyMiddleware<State, Event> {
    private let service: LoggerService
    public init(service: LoggerService) {
        self.service = service
    }
    
    override public func intercept(event: Event) -> AnyPublisher<Event, Never> {
        if let action = event.action {
            service.log(action: action)
        }
        return Empty().eraseToAnyPublisher()
    }
}

extension PokeListEvent: LogEvent {
    public var action: LoggerService.LogAction? {
        switch self {
        case .fetchPokemon:
            return .pageViewed(.pokeList)
        default:
            return nil
        }
    }
}

extension PokeFavoritesEvent: LogEvent {
    public var action: LoggerService.LogAction? {
        switch self {
        case .removeFromFavorites(let id):
            return .removedFavorite(id: id)
        case .fetchPokemon:
            return .pageViewed(.pokeFavorites)
        default:
            return nil
        }
    }
    
}

extension PokeEvent: LogEvent {
    public var action: LoggerService.LogAction? {
        switch self {
        case .addToFavorites(let id):
            return .favorite(id: id)
        case .removeFromFavorites(let id):
            return .removedFavorite(id: id)
        default:
            return nil
        }
    }
}
