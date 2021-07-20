//
//  File.swift
//  
//
//  Created by Dylan Vélez on 20/07/21.
//

import Foundation

public protocol Reducer {
    associatedtype State
    associatedtype Event
    
    func reduce(state: inout State, forEvent event: Event)
}

public class AnyReducer<State, Event>: Reducer {
    
    public init() { }
    
    public func reduce(state: inout State, forEvent event: Event) {
    }
}
