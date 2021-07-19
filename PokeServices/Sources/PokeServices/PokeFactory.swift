//
//  File.swift
//  
//
//  Created by Dylan Vélez on 18/07/21.
//

import Foundation

public final class PokeFactory {
    public enum ServiceType {
        case local
        case http
    }
    
    private init() { }
    
    public static func getServiceOf(type: ServiceType) -> PokeService {
        switch type {
        case .local:
            return LocalPokeService()
        case .http:
            return HttpPokeService()
        }
    }
}
