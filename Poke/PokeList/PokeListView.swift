//
//  PokeListView.swift
//  Poke
//
//  Created by Dylan Vélez on 21/07/21.
//

import SwiftUI
import PokeArch
import PokeServices

struct PokeListView: View, ViewConfigurable {
    @ObservedObject var viewModel: PokeListViewModel = .init(store: AnyStore<PokeListState, PokeListEvent>(initialState: .init(), reducer: PokeListReducer(), middlewares: [PokeListMiddleware(service: PokeFactory.getServiceOf(type: .http))]))
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: [.init(.flexible()), .init(.flexible())],
                      alignment: .center,
                      spacing: 20) {
                ForEach(viewModel.state.list, id: \.id) { pokemon in
                    NavigationLink(destination: PokeDetailView(pokemon: pokemon)) {
                        PokeListItemView(viewModel: .init(pokemon: pokemon, store: .init(initialState: .init(), reducer: PokeListItemReducer(), middlewares: [PokeListItemMiddleware(service: FavoritePokeService())])))
                            .cornerRadius(12)
                            .shadow(radius: 5)
                            .onAppear {
                                if pokemon == viewModel.state.list.last {
                                    viewModel.dispatch(event: .fetchPokemon)
                                }
                            }
                    }
                }
            }
                      .padding()
        }
        .overlay(ProgressView()
                    .frame(width: 100, height: 100)
                    .progressViewStyle(CircularProgressViewStyle())
                    .opacity(viewModel.state.isLoading ? 1 : 0))
        .onAppear {
            viewModel.dispatch(event: .fetchPokemon)
        }
    }
}

struct PokeListView_Previews: PreviewProvider {
    static var previews: some View {
        let store = AnyStore<PokeListState, PokeListEvent>(initialState: .init(), reducer: PokeListReducer(), middlewares: [PokeListMiddleware(service: PokeFactory.getServiceOf(type: .local))])
        let viewModel = PokeListViewModel(store: store)
        PokeListView(viewModel: viewModel)
    }
}
