//
//  ContentView.swift
//  Poke
//
//  Created by Dylan Vélez on 17/07/21.
//

import SwiftUI
import PokeArch
import PokeServices

struct ContentView: View {
    var body: some View {
        TabView {
            NavigationView {
                PokeListView()
                    .navigationTitle("PokéDex!")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
