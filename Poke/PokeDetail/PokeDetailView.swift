//
//  PokeDetailView.swift
//  Poke
//
//  Created by Dylan Vélez on 22/07/21.
//

import SwiftUI
import PokeModels
import PokeArch
import URLImage

struct PokeDetailView: View, ViewConfigurable {
    let viewModel: PokeDetailViewModel
    var body: some View {
        VStack {
            header
            Spacer()
            VStack {
                Text(viewModel.pokeNumber)
                    .foregroundColor(.red)
                    .font(.callout)
                TabView {
                    List(content: abilities)
                    List(content: stats)
                }
                .tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            }
            .navigationTitle(viewModel.name)
        }
    }
}

//MARK: Extra Views
private extension PokeDetailView {
    var rowBackground: some View {
        HStack(spacing: 0) {
            Rectangle()
                .fill(Color.red)
            Rectangle()
                .fill(Color.black)
                .frame(width: 10)
                .overlay(Circle()
                            .strokeBorder(Color.black, lineWidth: 4)
                            .background(Circle().foregroundColor(.white))
                            .frame(width: 30, height: 30))
            Rectangle()
                .fill(Color.white)
        }
    }
    @ViewBuilder
    var header: some View {
        let background = Rectangle()
            .fill(LinearGradient(gradient: Gradient(colors: [.purple, .yellow, .blue]),
                                 startPoint: .top, endPoint: .bottom))
            .opacity(0.05)
        
    URLImage(viewModel.url!) {
        Image("pokeball")
            .resizable()
            .aspectRatio(contentMode: .fit)
    } inProgress: { _ in
        Image("pokeball")
            .resizable()
            .aspectRatio(contentMode: .fit)
    } failure: { _,_  in
        
    }
    content: { image in
        // Downloaded image
        image
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
            .shadow(radius: 5)
            .frame(maxWidth: .infinity)
            .background(background)
    }
    
    func abilities() -> some View {
        return Section(header: Text("Abilities")) {
            ForEach(viewModel.abilities, id: \.self) { ability in
                HStack {
                    Text(ability)
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding()
                    Spacer()
                }
                .frame(maxWidth: .infinity)
            }
            .background(rowBackground)
            .cornerRadius(10)
            .listRowBackground(Color.clear)
        }
    }
    
    func stats() -> some View {
        Section(header: Text("Stats")){
            ForEach(viewModel.stats, id: \.name) { stat in
                HStack {
                    Text(stat.name)
                        .font(.subheadline)
                        .foregroundColor(.white)
                    Spacer()
                    Text(String(stat.base))
                        .font(.caption)
                        .foregroundColor(.red)
                }
                .padding()
                .frame(maxWidth: .infinity)
            }
            .background(rowBackground)
            .cornerRadius(10)
            .listRowBackground(Color.clear)
        }
    }
}

//MARK: View Functions
private extension PokeDetailView {
    func asyncImage(image: Image) -> some View {
        image
            .resizable()
            .frame(maxWidth: 200, maxHeight: 200)
            .scaledToFill()
            .clipped()
    }
    
    func placeholder() -> some View {
        Image("pokeball")
            .resizable()
            .clipped()
    }
}

struct PokeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PokeDetailView(viewModel: .init(pokemon: .init(id: 1, name: "Bulbasaur", height: 10, weight: 10, abilities: [.init(name: "Poison")], sprites: .init(front: ""), types: [], stats: [.init(base: 50, name: "HP")])))
    }
}
