//
//  File.swift
//  
//
//  Created by Dylan Vélez on 20/07/21.
//

import Foundation
import Combine

public protocol Store: ObservableObject {
    associatedtype State
    associatedtype Event
    associatedtype Reducer
    associatedtype Middleware
    
    var state: State { get }
    
    func dispatch(event: Event)
    
    init(initialState: State, reducer: Reducer, middlewares: [Middleware])
}

public class AnyStore<State, Event>: Store {
    public typealias Reducer = AnyReducer<State, Event>
    public typealias Middleware = AnyMiddleware<State, Event>
    
    private let reducer: Reducer
    private let middlewares: [Middleware]
    private var middlewareCancellables: Set<AnyCancellable> = []
    
    @Published private(set) public var state: State
    
    required public init(initialState: State,
         reducer: Reducer,
         middlewares: [Middleware]) {
        self.state = initialState
        self.reducer = reducer
        self.middlewares = middlewares
    }
    
    public func dispatch(event: Event) {
        reducer.reduce(state: &state, forEvent: event)
        for mw in middlewares {
            mw.intercept(state: state, forEvent: event)
                .receive(on: DispatchQueue.main)
                .sink(receiveValue: dispatch)
                .store(in: &middlewareCancellables)
        }
    }
}
