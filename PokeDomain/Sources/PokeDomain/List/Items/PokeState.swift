//
//  PokeState.swift
//  Poke
//
//  Created by Dylan Vélez on 22/07/21.
//

import Foundation

@frozen public struct PokeState {
    public var isFavorite: Bool = false
    public init() { }
}

@frozen public enum PokeEvent {
    case addToFavorites(id: Int)
    case removeFromFavorites(id: Int)
    case fetchIsFavorite(id: Int)
    case fetchIsFavoriteCompleted(Bool)
}
