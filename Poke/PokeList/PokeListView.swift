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
            progressView
        }
        .onAppear {
            viewModel.dispatch(event: .fetchPokemon)
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
                    if pokemon == viewModel.state.list.last {
                        viewModel.dispatch(event: .fetchPokemon)
                    }
                }
        }
    }
}

struct PokeListView_Previews: PreviewProvider {
    
    struct Service: PokeService {
        enum SError: Error {
            case something
        }
        func getPokemonList() -> AnyPublisher<[Pokemon], Error> {
            let array = [Pokemon(id: 1, name: "bulbasaur", height: 10, weight: 10, abilities: [], sprites: Sprite(front: ""), types: [], stats: [])]
            return Just(array)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        
        func getPokemon(id: Int) -> AnyPublisher<Pokemon, Error> {
            return Empty().eraseToAnyPublisher()
        }
        
        
    }
    struct PokeListDependencyProvider {
        @Provider public var listService = Service()
        @Provider public var loggerService = ServiceLocator().loggerService
        @Provider public var dependencies = PokeListDependencies()
        
        public init() { }
    }
    
    static var previews: some View {
        var reducer = PokeListReducer()
        reducer.dependencies.listService = Service()
        return PokeListView(viewModel: .init(store: .init(initialState: .init(), reducer: reducer)))
    }
}
