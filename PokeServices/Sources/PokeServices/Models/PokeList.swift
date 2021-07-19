//
//  File.swift
//  
//
//  Created by Dylan Vélez on 18/07/21.
//

import Foundation

struct NamedResource: Codable {
    let name: String
    let url: String
}

struct PokeList: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [NamedResource]
}
