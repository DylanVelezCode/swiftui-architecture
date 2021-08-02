//
//  PokeListView.swift
//  Poke
//
//  Created by Dylan Vélez on 21/07/21.
//

import SwiftUI
import PokeArch
import PokeServices
import PokeDomain
import PokeModels
import PokeInjection
import Combine

struct PokeListView: View, ViewConfigurable {
    @ObservedObject var viewModel: PokeListViewModel
    private let columns = Array(repeating: GridItem(.flexible()), count: 2)
    
    init(viewModel: PokeListViewModel) {
        self.viewModel = viewModel
        viewModel.dispatch(event: .fetchPokemon)
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: columns,
                      alignment: .center,
                      spacing: 10) {
                ForEach(viewModel.state.list, id: \.id) { pokemon in
                    row(pokemon: pokemon)
                        .frame(width: 200)
                }
            }.padding()
            if viewModel.state.isLoading {
                progressView
            } else {
                Button(action: { viewModel.dispatch(event: .fetchPokemon)}) {
                    Text("Load More Pokemon")
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.red)
                .cornerRadius(5)
            }
        }
    }
}

private extension PokeListView {
    var progressView: some View {
        ProgressView()
                    .frame(width: 100, height: 100)
                    .progressViewStyle(CircularProgressViewStyle(tint: .red))
                    .opacity(viewModel.state.isLoading ? 1 : 0)
    }
    
    func row(pokemon: Pokemon) -> some View {
        NavigationLink(destination: PokeDetailView(viewModel: .init(pokemon: pokemon))) {
            PokeListItemView(viewModel: .init(pokemon: pokemon, store: .init(initialState: .init(), reducer: .init())))
                .onAppear {
//                    if pokemon == viewModel.state.list.last {
//                        viewModel.dispatch(event: .fetchPokemon)
//                    }
                }
        }
    }
}

struct PokeListView_Previews: PreviewProvider {
    static var service = ServiceLocator().mockedList
    static var previews: some View {
        InjectedValues[\.listService] = service
        return PokeListView(viewModel: .init(store: .init(initialState: .init(), reducer: .init())))
    }
}
