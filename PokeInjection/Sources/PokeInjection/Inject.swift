//
//  File.swift
//  
//
//  Created by Dylan Vélez on 27/07/21.
//

import Foundation

@propertyWrapper public struct Inject<T> {
    public var wrappedValue: T
    
    public init() {
        self.wrappedValue = DependencyInjector.resolve()
    }
}
