//
//  File.swift
//  
//
//  Created by Dylan Vélez on 29/07/21.
//

import Foundation

public class ServiceLocator {
    public lazy var localService: PokeService = LocalPokeService()
    public lazy var httpService: PokeService = HttpPokeService()
    public lazy var mockedList: PokeService = MockedPokeService()
    public lazy var loggerService: LoggingService = LoggerService()
    public lazy var favoriteService: FavoriteService = FavoritePokeService()
    
    public init() { }
}
