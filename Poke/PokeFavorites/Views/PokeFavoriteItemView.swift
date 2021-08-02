//
//  PokeFavoriteItemView.swift
//  Poke
//
//  Created by Dylan Vélez on 28/07/21.
//

import SwiftUI
import PokeModels
import PokeArch
import SwURL

struct PokeFavoriteItemView: View, ViewConfigurable {
    let viewModel: PokeFavoriteItemViewModel
    var body: some View {
        HStack(alignment: .center) {
            RemoteImageView(url: viewModel.url!)
                .imageProcessing({ image in
                            return image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        })
                .frame(width: 50, height: 50)
            
            Text(viewModel.title)
                .font(.headline)
                .foregroundColor(.red)
            
            Text(viewModel.pokeNumber)
                .font(.caption)
                .foregroundColor(.red)
                .opacity(0.5)
            
            Spacer()
            
            Button(action: viewModel.onClick) {
                Image(systemName: "heart.fill")
                    .imageScale(.medium)
            }
            .buttonStyle(PlainButtonStyle())
            .foregroundColor(.red)
        }
        .frame(maxWidth: .infinity)
    }
}

//MARK: Extra Views
private extension PokeFavoriteItemView {
    func asyncImage(image: Image) -> some View {
        image
            .resizable()
            .frame(maxWidth: 60, maxHeight: 60)
            .scaledToFill()
            .clipped()
    }
    
    func placeholder() -> some View {
        Image("pokeball")
            .resizable()
            .scaledToFit()
    }
}

//MARK: Preview
struct PokeFavoriteItemView_Previews: PreviewProvider {
    static var previews: some View {
        PokeFavoriteItemView(viewModel: .init(pokemon: .init(id: 1, name: "Bulbasaur", height: 10, weight: 10, abilities: [], sprites: .init(front: ""), types: [], stats: []), onClick: {}))
    }
}
