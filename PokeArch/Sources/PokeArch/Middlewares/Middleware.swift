//
//  File.swift
//  
//
//  Created by Dylan Vélez on 20/07/21.
//

import Foundation
import Combine

public protocol Middleware {
    associatedtype State
    associatedtype Event
    
    func intercept(state: State, forEvent event: Event) -> AnyPublisher<Event, Never>
}

public class AnyMiddleware<State, Event>: Middleware {
    public func intercept(state: State, forEvent event: Event) -> AnyPublisher<Event, Never> {
        return Empty().eraseToAnyPublisher()
    }
}
