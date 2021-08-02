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
    @Inject public var listService: PokeService
    @Inject public var loggerService: LoggingService
    public init() { }
}

public struct PokeListDependencyProvider {
    @Provider public var listService = ServiceLocator().httpService
    @Provider public var loggerService = ServiceLocator().loggerService
    @Provider public var dependencies = PokeListDependencies()
    
    public init() { }
}
