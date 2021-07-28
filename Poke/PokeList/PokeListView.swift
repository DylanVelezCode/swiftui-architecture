//
//  PokeListView.swift
//  Poke
//
//  Created by Dylan Vélez on 21/07/21.
//

import SwiftUI
import PokeArch
import PokeServices
import PokeDomain

struct PokeListView: View, ViewConfigurable {
    @ObservedObject var viewModel: PokeListViewModel
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: [.init(.flexible()), .init(.flexible())],
                      alignment: .center,
                      spacing: 20) {
                ForEach(viewModel.state.list, id: \.id) { pokemon in
                    NavigationLink(destination: PokeDetailView(pokemon: pokemon)) {
                        PokeListItemView(viewModel: .init(pokemon: pokemon))
                            .cornerRadius(12)
                            .shadow(radius: 5)
                            .onAppear {
                                if pokemon == viewModel.state.list.last {
                                    viewModel.dispatch(event: .fetchPokemon)
                                }
                            }
                    }
                }
            }
                      .padding()
        }
        .overlay(ProgressView()
                    .frame(width: 100, height: 100)
                    .progressViewStyle(CircularProgressViewStyle())
                    .opacity(viewModel.state.isLoading ? 1 : 0))
        .onAppear {
            viewModel.dispatch(event: .fetchPokemon)
        }
    }
}

struct PokeListView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
