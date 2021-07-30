//
//  File.swift
//  
//
//  Created by Dylan Vélez on 29/07/21.
//

import Foundation
import Combine
import PokeModels

public protocol FavoriteService {
    func fetchFavorites() -> Set<Int>
    func fetchPokemon() -> AnyPublisher<[Pokemon], Error>
    func addToFavorites(id: Int)
    func removeFromFavorites(id: Int)
}
