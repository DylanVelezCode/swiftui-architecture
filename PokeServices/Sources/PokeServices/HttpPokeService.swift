//
//  File.swift
//  
//
//  Created by Dylan Vélez on 18/07/21.
//

import Foundation
import Combine
import PokeModels

final class HttpPokeService: PokeService {
    func getPokemonList() -> AnyPublisher<[Pokemon], Error> {
        return Empty().eraseToAnyPublisher()
    }
    
    func getPokemon(id: Int) -> AnyPublisher<Pokemon, Error> {
        return Empty().eraseToAnyPublisher()
    }
}
