//
//  File.swift
//  
//
//  Created by Dylan Vélez on 20/07/21.
//

import Foundation
import Combine

public protocol Middleware: Eventful {
    func intercept(event: Event) -> AnyPublisher<Event, Never>
}

open class AnyMiddleware<State, Event>: Middleware {
    public init() { }
    open func intercept(event: Event) -> AnyPublisher<Event, Never> {
        fatalError()
    }
}
