//
//  File.swift
//  
//
//  Created by Dylan Vélez on 27/07/21.
//

import Foundation

public struct DependencyInjector {
    private static var dependencyList: [String:Any] = [:]
    
    public static func resolve<T>() -> T {
        guard let t = dependencyList[String(describing: T.self)] as? T else {
            fatalError("No povider registered for type \(T.self)")
        }
        return t
    }
    
    public static func register<T>(dependency: T) {
        dependencyList[String(describing: T.self)] = dependency
    }
}
