//
//  ContentView.swift
//  Poke
//
//  Created by Dylan Vélez on 17/07/21.
//

import SwiftUI

struct ContentView: View {
    //MARK: - ViewModels
    private let listVM = PokeListViewModel()
    private let favoritesVM = PokeFavoritesViewModel()
    
    var body: some View {
        TabView {
            NavigationView {
                PokeListView(viewModel: listVM)
                    .navigationTitle("Poké!")
            }
            .tabItem(pokeDexTabItem)
            
            NavigationView {
                PokeFavoritesView(viewModel: favoritesVM)
                    .navigationTitle("PokéFavorites!")
            }
            .tabItem(favoritesTabItem)
        }
        .accentColor(.red)
    }
}

//MARK: - Tab Items
private extension ContentView {
    func pokeDexTabItem() -> some View {
        VStack {
            Image(systemName: "apps.ipad")
            Text("PokeDex")
        }
    }
    
    func favoritesTabItem() -> some View {
        VStack {
            Image(systemName: "heart.circle")
            Text("Favorites")
        }
    }
}

//MARK: - Previews
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
