//
//  File.swift
//  
//
//  Created by Dylan Vélez on 20/07/21.
//

import Foundation
import Combine

public typealias Effect<Event> = AnyPublisher<Event, Never>?

/// Defines a type which changes a given state for a specific event and returns a new side effect
public protocol Reducing {
    associatedtype State
    associatedtype Event
    func reduce(state: inout State, forEvent event: Event) -> Effect<Event>
}
