//
//  PokeFavoriteItemView.swift
//  Poke
//
//  Created by Dylan Vélez on 28/07/21.
//

import SwiftUI
import PokeModels

struct PokeFavoriteItemView: View {
    let viewModel: PokeFavoriteItemViewModel
    var body: some View {
        HStack(alignment: .center) {
            AsyncImage(url: viewModel.url,
                       content: { $0 },
                       placeholder: placeholder)
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
            .buttonStyle(.plain)
            .foregroundColor(.red)
        }
        .frame(maxWidth: .infinity)
    }
}

//MARK: Extra Views
private extension PokeFavoriteItemView {
    func placeholder() -> some View {
        Image("pokeball")
            .resizable()
            .scaledToFit()
    }
}

//MARK: Preview
struct PokeFavoriteItemView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
