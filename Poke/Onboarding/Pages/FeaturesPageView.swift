//
//  FeaturesPageView.swift
//  Poke
//
//  Created by Dylan Vélez on 21/07/21.
//

import SwiftUI

struct FeaturesPageView: View {
    var body: some View {
        VStack {
            Text("Features")
                .font(.largeTitle)
            Image("capture")
                .resizable()
                .scaledToFit()
            Text("- Support for all generations of pokémon")
                .font(.caption)
            Text("- See every detail of each pokémon")
                .font(.caption)
            Text("- Search by name or PokéDex number")
                .font(.caption)
        }
    }
}

struct FeaturesPageView_Previews: PreviewProvider {
    static var previews: some View {
        FeaturesPageView()
    }
}
