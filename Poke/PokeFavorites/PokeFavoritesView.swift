//
//  PokeFavoritesView.swift
//  Poke
//
//  Created by Dylan Vélez on 22/07/21.
//

import SwiftUI
import PokeArch

struct PokeFavoritesView: View, ViewConfigurable {
    @ObservedObject var viewModel: PokeFavoritesViewModel
    var body: some View {
        List {
            ForEach(viewModel.state.list) { pokemon in
                NavigationLink(destination: PokeDetailView(pokemon: pokemon)) {
                    HStack {
                        AsyncImage(url: URL(string: pokemon.sprites.front))
                            .padding()
                            .scaledToFit()
                        Text(pokemon.name)
                            .font(.headline)
                        Spacer()
                        Button(action: {
                            withAnimation {
                                viewModel.dispatch(event: .removeFromFavorites(id: pokemon.id))
                            }
                        }) {
                            Image(systemName: "heart.fill")
                                .imageScale(.medium)
                        }
                        .buttonStyle(.plain)
                        .foregroundColor(.red)
                    }
                    .frame(maxWidth: .infinity)
                }
                .frame(height: 80)
            }
            .onDelete { indexSet in
                for index in indexSet {
                    let pokemon = viewModel.state.list[index]
                    viewModel.dispatch(event: .removeFromFavorites(id: pokemon.id))
                }
            }
        }
        .listStyle(.insetGrouped)
        .onAppear {
            viewModel.dispatch(event: .fetchPokemon)
        }
    }
}

struct PokeFavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
