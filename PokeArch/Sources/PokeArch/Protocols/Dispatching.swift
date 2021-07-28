//
//  File.swift
//  
//
//  Created by Dylan Vélez on 27/07/21.
//

import Foundation

public protocol Dispatching {
    associatedtype Event
    func dispatch(event: Event)
}
