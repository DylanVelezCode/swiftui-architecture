//
//  File.swift
//  
//
//  Created by Dylan Vélez on 1/08/21.
//

import Foundation
import PokeModels
import PokeInjection
import PokeServices
import PokeArch

public typealias FavoriteStore = Store<PokeFavoritesState, PokeFavoritesEvent, PokeFavoriteReducer>
public typealias ListStore = Store<PokeListState, PokeListEvent, PokeListReducer>
public typealias OnboardingStore = Store<OnboardingState, OnboardingEvent, OnboardingReducer>
public typealias PokeItemStore = Store<PokeState, PokeEvent, PokeListItemReducer>


private struct FavoriteServiceKey: InjectionKey {
    static var currentValue: FavoriteService = ServiceLocator().favoriteService
}

private struct ListServiceKey: InjectionKey {
    static var currentValue: PokeService = ServiceLocator().localService
}

private struct LogServiceKey: InjectionKey {
    static var currentValue: LoggingService = ServiceLocator().loggerService
}

extension InjectedValues {
    public var favoriteService: FavoriteService {
        get { Self[FavoriteServiceKey.self] }
        set { Self[FavoriteServiceKey.self] = newValue }
    }
    
    public var listService: PokeService {
        get { Self[ListServiceKey.self] }
        set { Self[ListServiceKey.self] = newValue }
    }
    
    public var loggerService: LoggingService {
        get { Self[LogServiceKey.self] }
        set { Self[LogServiceKey.self] = newValue }
    }
}


