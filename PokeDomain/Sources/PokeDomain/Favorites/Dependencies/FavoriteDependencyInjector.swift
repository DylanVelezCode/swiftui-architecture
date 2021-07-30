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

public struct FavoritesDependencies {
    @Inject var service: FavoritePokeService
}

public struct FavoritesDependencyProvider {
    @Provider var service = FavoritePokeService()
    @Provider var dependencies = FavoritesDependencies()
    
    public init() { }
}
