//
//  File.swift
//  
//
//  Created by Dylan Vélez on 22/07/21.
//

import Foundation
import Combine
import PokeModels

final class FavoritePokeService: FavoriteService {
    private var listEndpoint = "https://pokeapi.co/api/v2/pokemon/"
    
    public func fetchFavorites() -> Set<Int> {
        let storedIds = UserDefaults.standard.array(forKey: "com.dylansvm.architecture.favorites") as? [Int]
        return Set(storedIds ?? [])
    }
    
    public func fetchPokemon() -> AnyPublisher<[Pokemon], Error> {
        let storedIds = UserDefaults.standard.array(forKey: "com.dylansvm.architecture.favorites") as? [Int]
        return (storedIds ?? []).publisher
            .flatMap { self.getPokemon(id: $0) }
            .collect()
            .eraseToAnyPublisher()
    }
    
    public func addToFavorites(id: Int) {
        let storedIds = UserDefaults.standard.array(forKey: "com.dylansvm.architecture.favorites") as? [Int]
        var setOfIds = Set(storedIds ?? [])
        setOfIds.insert(id)
        UserDefaults.standard.set(Array(setOfIds), forKey: "com.dylansvm.architecture.favorites")
    }
    
    public func removeFromFavorites(id: Int) {
        let storedIds = UserDefaults.standard.array(forKey: "com.dylansvm.architecture.favorites") as? [Int]
        var setOfIds = Set(storedIds ?? [])
        setOfIds.remove(id)
        UserDefaults.standard.set(Array(setOfIds), forKey: "com.dylansvm.architecture.favorites")
    }
    
    private func getPokemon(id: Int) -> AnyPublisher<Pokemon, Error> {
        guard let url = URL(string: "\(listEndpoint)\(id)/") else {
            return Empty().eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Pokemon.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
