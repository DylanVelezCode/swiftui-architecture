//
//  File.swift
//  
//
//  Created by Dylan Vélez on 28/07/21.
//

import Foundation
import PokeServices
import PokeModels
import PokeArch
import PokeInjection

public typealias ListStore = Store<PokeListState, PokeListEvent, PokeListReducer>

public struct PokeListDependencies {
    @Inject var listService: PokeService
    @Inject var loggerService: LoggingService
}

public struct PokeListDependencyProvider {
    @Provider var listService = ServiceLocator().httpService
    @Provider var loggerService = ServiceLocator().loggerService
    @Provider var dependencies = PokeListDependencies()
    
    public init() { }
}
