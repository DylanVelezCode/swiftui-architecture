//
//  PokeFavoritesView.swift
//  Poke
//
//  Created by Dylan Vélez on 22/07/21.
//

import SwiftUI
import PokeArch
import PokeDomain
import PokeModels

struct PokeFavoritesView: View, ViewConfigurable {
    @ObservedObject var viewModel: PokeFavoritesViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.state.list, content: row)
                .onDelete(perform: onDelete)
        }
        .listStyle(.insetGrouped)
        .onAppear(perform: onAppear)
    }
}

//MARK: Extra Views
private extension PokeFavoritesView {
    func row(with pokemon: Pokemon) -> some View {
        let itemViewModel = PokeFavoriteItemViewModel(pokemon: pokemon, onClick: {
            onRemoveFavorite(id: pokemon.id)
        })
        
        return NavigationLink(destination: PokeDetailView(pokemon: pokemon)) {
            PokeFavoriteItemView(viewModel: itemViewModel)
        }
        .frame(height: 80)
    }
}

//MARK: Methods
private extension PokeFavoritesView {
    func onAppear() {
        viewModel.dispatch(event: .fetchPokemon)
    }
    
    func onDelete(indexSet: IndexSet) {
        for index in indexSet {
            let pokemon = viewModel.state.list[index]
            onRemoveFavorite(id: pokemon.id)
        }
    }
    
    func onRemoveFavorite(id: Int) {
        withAnimation {
            viewModel.dispatch(event: .removeFromFavorites(id: id))
        }
    }
}

//MARK: Preview
struct PokeFavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
