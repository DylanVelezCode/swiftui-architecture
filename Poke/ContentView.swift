//
//  ContentView.swift
//  Poke
//
//  Created by Dylan Vélez on 17/07/21.
//

import SwiftUI
import PokeArch
import PokeServices
import PokeDomain

struct ContentView: View {
    var body: some View {
        TabView {
            NavigationView {
                PokeListView(viewModel: .init())
                    .navigationTitle("PokéDex!")
            }
            .tabItem {
                Text("PokeDex")
            }
            
            NavigationView {
                PokeFavoritesView(viewModel: .init())
                    .navigationTitle("Favorites!")
            }
            .tabItem {
                Text("Favorites")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
