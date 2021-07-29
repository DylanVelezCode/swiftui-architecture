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
    @State var gradient = [Color.red, Color.purple, Color.orange]
    @State var startPoint = UnitPoint(x: 0, y: 0)
    @State var endPoint = UnitPoint(x: 0, y: 2)
    var body: some View {
        VStack {
            AsyncImage(url: viewModel.url,
                       content: asyncImage,
                       placeholder: placeholder)
                .frame(maxWidth: .infinity)
                .background(RoundedRectangle(cornerRadius: 2)
                                .fill(LinearGradient(gradient: Gradient(colors: self.gradient), startPoint: self.startPoint, endPoint: self.endPoint))
                                .onTapGesture {
                                    withAnimation (.easeInOut(duration: 3)){
                                        self.startPoint = UnitPoint(x: 1, y: -1)
                                        self.endPoint = UnitPoint(x: 0, y: 1)
                                    }
                }.opacity(0.3))
            Spacer()
            VStack {
                Text(viewModel.pokeNumber)
                    .foregroundColor(.gray)
                    .font(.caption)
                TabView {
                    List {
                        Section("Abilities") {
                            ForEach(viewModel.abilities, id: \.self) { ability in
                                Text(ability)
                                    .padding()
                                
                            }
                        }
                    }
                    
                    List {
                        Section("Stats") {
                            ForEach(viewModel.stats, id: \.name) { stat in
                                
                                HStack {
                                    Text(stat.name)
                                    Spacer()
                                    Text(String(stat.base))
                                }
                                .padding()
                                
                            }
                        }
                    }
                }
                .tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .always))
                Spacer()
            }
            .navigationTitle(viewModel.name)
            .accentColor(.red)
            
        }
    }
}

private extension PokeDetailView {
    func asyncImage(image: Image) -> some View {
        return image
            .resizable()
            .frame(maxWidth: 200, maxHeight: 200)
            .scaledToFill()
            .clipped()
    }
    
    func placeholder() -> some View {
        withAnimation {
            Image("pokeball")
                .resizable()
                .clipped()
        }
    }
}

struct PokeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
