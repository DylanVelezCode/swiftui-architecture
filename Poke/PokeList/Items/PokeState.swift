//
//  PokeState.swift
//  Poke
//
//  Created by Dylan Vélez on 22/07/21.
//

import Foundation

struct PokeState {
    var isFavorite: Bool = false
}

enum PokeEvent {
    case addToFavorites(id: Int)
    case removeFromFavorites(id: Int)
    case fetchIsFavorite(id: Int)
    case fetchIsFavoriteCompleted(Bool)
}
