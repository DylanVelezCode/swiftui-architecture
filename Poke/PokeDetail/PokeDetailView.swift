//
//  PokeDetailView.swift
//  Poke
//
//  Created by Dylan Vélez on 22/07/21.
//

import SwiftUI
import PokeModels

struct PokeDetailView: View {
    var pokemon: Pokemon
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: pokemon.sprites.front))
                .frame(height: 150)
            Divider()
            Spacer()
            VStack {
                Text("#\(pokemon.id)")
                    .foregroundColor(.gray)
                    .font(.caption)
                Text(pokemon.name)
                    .font(.largeTitle)
                TabView {
                    List {
                        Section("Abilities") {
                            ForEach(pokemon.abilities, id: \.name) { ability in
                                Text(ability.name)
                                    .padding()
                                
                            }
                        }
                    }
                    
                    List {
                        Section("Stats") {
                            ForEach(pokemon.stats, id: \.name) { stat in
                                
                                HStack {
                                    Text(stat.name)
                                    Spacer()
                                    Text(String(stat.base))
                                }
                                .padding()
                                
                            }
                        }
                    }
                }
                .tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .always))
                Spacer()
            }
        }
    }
}

struct PokeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PokeDetailView(pokemon: .init(id: 1, name: "Bulbasaur", height: 7, weight: 29, abilities: [.init(name: "Leech Seed")], sprites: .init(front: ""), types: [.init(name: "Grass"), .init(name: "Poison")], stats: [.init(base: 40, name: "HP")]))
    }
}
