//
//  PokeDetailView.swift
//  Poke
//
//  Created by Dylan Vélez on 22/07/21.
//

import SwiftUI
import PokeModels
import PokeArch

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
                .tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .always))
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
    
    var header: some View {
        let background = Rectangle()
            .fill(LinearGradient(colors: [.purple, .yellow, .blue],
                                 startPoint: .top, endPoint: .bottom))
            .opacity(0.05)
        return AsyncImage(url: viewModel.url,
                          content: asyncImage,
                          placeholder: placeholder)
            .shadow(radius: 5)
            .frame(maxWidth: .infinity)
            .background(background)
    }
    
    func abilities() -> some View {
        return Section("Abilities") {
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
            .listRowSeparator(.hidden)
        }
    }
    
    func stats() -> some View {
        Section("Stats") {
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
            .listRowSeparator(.hidden)
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
        EmptyView()
    }
}
