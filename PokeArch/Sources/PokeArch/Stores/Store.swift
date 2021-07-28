//
//  File.swift
//  
//
//  Created by Dylan Vélez on 20/07/21.
//

import Foundation
import Combine

fileprivate typealias StoreType = ObservableObject & Stateful & Dispatching

public final class Store<State, Event, Reducer: Reducing>: StoreType where Reducer.State == State, Reducer.Event == Event {
    
    private let reducer: Reducer
    private var effectsCancellable: AnyCancellable?
    
    @Published private(set) public var state: State
    
    required public init(initialState: State,
         reducer: Reducer) {
        self.state = initialState
        self.reducer = reducer
    }
    
    public func dispatch(event: Event) {
        guard let publisher = reducer.reduce(state: &state, forEvent: event) else {
            return
        }
        
        effectsCancellable = publisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: dispatch)
    }
}
