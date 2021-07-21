//
//  IntroPageView.swift
//  Poke
//
//  Created by Dylan Vélez on 21/07/21.
//

import SwiftUI

struct IntroPageView: View {
    var body: some View {
        VStack {
            Text("Your National PokeDex!")
                .font(.largeTitle)
            Text("At your hands")
                .font(.caption)
            Image("pokedex")
                .resizable()
                .scaledToFit()
            Text("""
Welcome to Poké! your national pokedex at your hands.
This app contains all the info you need about your favorite pokémon spanning from the first OG generation to the latest one.
""")
        }
    }
}

struct IntroPageView_Previews: PreviewProvider {
    static var previews: some View {
        IntroPageView()
    }
}
