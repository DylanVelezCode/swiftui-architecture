//
//  PokeListItemView.swift
//  Poke
//
//  Created by Dylan Vélez on 22/07/21.
//

import SwiftUI
import PokeModels
import PokeArch

struct PokeListItemView: View, ViewConfigurable {
    @ObservedObject var viewModel: PokeListItemViewModel
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(Color.white)
            
            VStack {
                HStack {
                    Text(viewModel.state.name)
                        .font(.headline)
                    Spacer()
                    Button(action: {
                        if viewModel.state.isFavorite {
                            viewModel.dispatch(event: .removeFromFavorites(id: viewModel.state.id))
                        } else {
                            viewModel.dispatch(event: .addToFavorites(id: viewModel.state.id))
                        }
                    }) {
                        Image(systemName: viewModel.state.isFavorite ? "heart.fill" : "heart")
                            .imageScale(.medium)
                    }
                    .buttonStyle(.plain)
                    .foregroundColor(.red)
                }
                .padding(.horizontal, 16)
                Divider()
                AsyncImage(url: viewModel.state.url)
                    .frame(height: 100)
                Divider()
                HStack {
                    ForEach(viewModel.state.types, id: \.self) { type in
                        Text(type)
                            .font(.caption2)
                            .padding(6)
                            .background(Color.blue)
                            .cornerRadius(25)
                    }
                }
                .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
        }
        .frame(height: 200)
        .onAppear {
            viewModel.dispatch(event: .fetchIsFavorite(id: viewModel.state.id))
        }
    }
}

struct PokeListItemView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
