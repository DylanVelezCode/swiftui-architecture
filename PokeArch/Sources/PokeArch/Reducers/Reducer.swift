//
//  File.swift
//  
//
//  Created by Dylan Vélez on 20/07/21.
//

import Foundation
import Combine

public typealias Effect<Event> = AnyPublisher<Event, Never>?

public protocol Reducing {
    associatedtype State
    associatedtype Event
    func reduce(state: inout State, forEvent event: Event) -> Effect<Event>
}
