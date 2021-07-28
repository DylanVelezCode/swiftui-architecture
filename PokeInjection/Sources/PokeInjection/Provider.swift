//
//  File.swift
//  
//
//  Created by Dylan Vélez on 27/07/21.
//

import Foundation

@propertyWrapper public struct Provider<T> {
    public var wrappedValue: T
    
    public init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
        DependencyInjector.register(dependency: wrappedValue)
    }
}
