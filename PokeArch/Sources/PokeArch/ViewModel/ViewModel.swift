//
//  File.swift
//  
//
//  Created by Dylan Vélez on 20/07/21.
//

import Foundation

/// Defines a ViewModel for this architecture.
/// This should pass the events to the store and format the state to what the view is expecting
public protocol ViewModel: ObservableObject, Dispatching {
    associatedtype StoreState
    associatedtype ViewState
    associatedtype Store
    var state: ViewState { get }
    var store: Store { get set }
    
    func stateChanged(newState: StoreState)
}

extension ViewModel where Self.Store: Dispatching, Self.Store.Event == Self.Event {
    public func dispatch(event: Event) {
        store.dispatch(event: event)
    }
}
