//
//  File.swift
//  
//
//  Created by Dylan Vélez on 18/07/21.
//

import Foundation
import Combine
import PokeModels

final class LocalPokeService: PokeService {
    
    public enum LocalPokeError: Error {
        case fileNotFound
        case unknown
    }
    func getPokemonList() -> AnyPublisher<[Pokemon], Error> {
        guard let path = Bundle.module.url(forResource: "PokemonList", withExtension: "json") else {
            return Fail(error: LocalPokeError.fileNotFound).eraseToAnyPublisher()
        }
        
        let publisher = Just(path)
            .tryMap { try Data(contentsOf: $0) }
            .decode(type: PokeList.self, decoder: JSONDecoder())
            .map(\.results)
            .flatMap { results in
                results.publisher
                    .map(\.name)
                    .tryMap { name in
                        guard let pokePath = Bundle.module.url(forResource: name, withExtension: "json") else {
                            throw LocalPokeError.fileNotFound
                        }
                        return try Data(contentsOf: pokePath)
                    }
                    .decode(type: Pokemon.self, decoder: JSONDecoder())
            }
            .collect()
        
        return publisher.eraseToAnyPublisher()
    }
    
    func getPokemon(id: Int) -> AnyPublisher<Pokemon, Error> {
        return getPokemonList()
            .flatMap { $0.publisher }
            .first { $0.id == id }
            .eraseToAnyPublisher()
    }
}


final class MockedPokeService: PokeService {
    func getPokemonList() -> AnyPublisher<[Pokemon], Error> {
        return Just([Pokemon(id: 1, name: "bulbasaur", height: 10, weight: 10, abilities: [], sprites: Sprite(front: ""), types: [], stats: [])])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func getPokemon(id: Int) -> AnyPublisher<Pokemon, Error> {
        return Empty().eraseToAnyPublisher()
    }
}
