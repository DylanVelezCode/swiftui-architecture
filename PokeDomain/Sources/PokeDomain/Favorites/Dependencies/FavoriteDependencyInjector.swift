//
//  File.swift
//  
//
//  Created by Dylan Vélez on 28/07/21.
//

import Foundation
import PokeModels
import PokeInjection
import PokeServices
import PokeArch

public typealias FavoriteStore = Store<PokeFavoritesState, PokeFavoritesEvent, PokeFavoriteReducer>

private struct FavoritesProviderKey: InjectionKey {
    static var currentValue: FavoriteService = ServiceLocator().favoriteService
}

extension InjectedValues {
    var favoriteService: FavoriteService {
        get { Self[FavoritesProviderKey.self] }
        set { Self[FavoritesProviderKey.self] = newValue }
    }
}
