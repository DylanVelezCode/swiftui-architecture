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
    @Inject var loggerService: LoggerService
}

public struct PokeListDependencyProvider {
    @Provider var listService = PokeFactory.getServiceOf(type: .http)
    @Provider var loggerService = LoggerService()
    @Provider var dependencies = PokeListDependencies()
    
    public init() { }
}
