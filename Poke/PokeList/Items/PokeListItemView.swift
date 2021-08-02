//
//  PokeListItemView.swift
//  Poke
//
//  Created by Dylan Vélez on 22/07/21.
//

import SwiftUI
import PokeModels
import PokeArch
import PokeDomain

struct PokeListItemView: View, ViewConfigurable {
    @ObservedObject var viewModel: PokeListItemViewModel
    var body: some View {
        VStack(spacing: 0) {
            header
            image
            Spacer().frame(height: 10)
            types
        }
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray, lineWidth: 1)
                .opacity(0.5)
        )
        .frame(maxWidth: .infinity, minHeight: 200, maxHeight: 200)
        .padding()
        .onAppear(perform: onAppear)
    }
}

private extension PokeListItemView {
    var header: some View {
        HStack {
            Text(viewModel.state.name)
                .font(.headline)
                .lineLimit(2)
            Spacer()
            Button(action: viewModel.onHeartClicked) {
                Image(systemName: viewModel.state.heartIcon)
                    .imageScale(.medium)
                    .foregroundColor(.white)
            }
            .buttonStyle(.plain)
            .foregroundColor(.red)
        }
        .foregroundColor(.white)
        .padding()
        .background(Color.red)
    }
    
    var image: some View {
        let background = Rectangle()
            .fill(LinearGradient(colors: [.purple, .yellow, .blue],
                                 startPoint: .top, endPoint: .bottom))
            .opacity(0.05)
        return AsyncImage(url: viewModel.state.url,
                          content: asyncImage,
                          placeholder: placeholder)
            .shadow(radius: 5)
            .frame(maxWidth: .infinity)
            .background(background)
    }
    
    var types: some View {
        HStack {
            ForEach(viewModel.state.types, id: \.self) { type in
                Text(type)
                    .font(.caption)
                    .frame(maxWidth: .infinity)
                    .padding(6)
                    .background(Color.pink)
                    .cornerRadius(16)
            }
        }
        .padding()
        .foregroundColor(.white)
    }
}

private extension PokeListItemView {
    func asyncImage(image: Image) -> some View {
        image
            .resizable()
            .frame(maxWidth: 100, maxHeight: 100)
            .clipped()
    }
    
    func placeholder() -> some View {
        Image("pokeball")
            .resizable()
            .scaledToFit()
            .clipped()
    }
    
    func onAppear() {
        viewModel.dispatch(event: .fetchIsFavorite(id: viewModel.state.id))
    }
}

struct PokeListItemView_Previews: PreviewProvider {
    static var previews: some View {
        PokeListItemView(viewModel: .init(pokemon: .init(id: 1, name: "Bulbasaur", height: 10, weight: 10, abilities: [], sprites: .init(front: ""), types: [], stats: []), store: .init(initialState: .init(), reducer: .init())))
    }
}
