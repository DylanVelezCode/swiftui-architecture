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

public typealias PokeItemStore = Store<PokeState, PokeEvent, PokeListItemReducer>

public struct PokeItemDependencies {
    @Inject var favoriteService: FavoriteService
}


public struct PokeItemDependencyProvider {
    @Provider var favoriteService = ServiceLocator().favoriteService
    @Provider var dependencies = PokeItemDependencies()
    public init() { }
}
