//
//  File.swift
//  
//
//  Created by Dylan Vélez on 23/07/21.
//

import Foundation

public protocol LoggerAction {
    var description: String { get }
}

public class LoggerService {
    
    public enum Page: String {
        case pokeList
        case pokeFavorites
    }
    
    public enum LogAction: LoggerAction {
        case pageViewed(Page)
        case favorite(id: Int)
        case removedFavorite(id: Int)
        
        public var description: String {
            switch self {
            case .pageViewed(let page):
                return "Page Viewed - \(page.rawValue)"
            case .favorite(let id):
                return "Favorited - \(id)"
            case .removedFavorite(let id):
                return "Remove Favorite - \(id)"
            }
        }
    }
    
    public init() { }
    
    public func log(action: LogAction) {
        print(action.description)
    }
}
