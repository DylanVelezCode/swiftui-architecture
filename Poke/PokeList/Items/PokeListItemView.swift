//
//  PokeListItemView.swift
//  Poke
//
//  Created by Dylan Vélez on 22/07/21.
//

import SwiftUI
import PokeModels

struct PokeListItemView: View {
    var pokemon: Pokemon
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(Color.white)
            
            VStack {
                Text(pokemon.name)
                    .font(.headline)
                Divider()
                AsyncImage(url: URL(string: pokemon.sprites.front))
                    .frame(height: 100)
                Divider()
                HStack {
                    ForEach(pokemon.types, id: \.name) { type in
                        Text(type.name)
                            .font(.caption2)
                            .padding(6)
                            .background(Color.blue)
                            .cornerRadius(25)
                    }
                }
                .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
        }
        .frame(height: 200)
    }
}

struct PokeListItemView_Previews: PreviewProvider {
    static var previews: some View {
        PokeListItemView(pokemon: Pokemon(id: 0, name: "Bulbasaur", height: 7, weight: 20, abilities: [], sprites: .init(front: ""), types: [.init(name: "grass"), .init(name: "poison")], stats: []))
    }
}
