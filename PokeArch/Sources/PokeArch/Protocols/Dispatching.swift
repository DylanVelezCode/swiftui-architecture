//
//  File.swift
//  
//
//  Created by Dylan Vélez on 27/07/21.
//

import Foundation

/// Defines an instance which can dispatch events
public protocol Dispatching {
    associatedtype Event
    func dispatch(event: Event)
}
