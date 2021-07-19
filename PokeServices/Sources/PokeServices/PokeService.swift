//
//  File.swift
//  
//
//  Created by Dylan Vélez on 18/07/21.
//

import Foundation
import Combine
import PokeModels

public protocol PokeService {
    func getPokemonList() -> AnyPublisher<[Pokemon], Error>
    func getPokemon(id: Int) -> AnyPublisher<Pokemon, Error>
}
