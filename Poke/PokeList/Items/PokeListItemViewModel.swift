//
//  PokeListItemViewModel.swift
//  Poke
//
//  Created by Dylan Vélez on 22/07/21.
//

import Foundation
import PokeArch
import PokeModels
import Combine
import PokeDomain

class PokeListItemViewModel: ViewModel {
    typealias VMStore = Store<PokeState, PokeEvent, PokeListItemReducer>
    typealias Event = PokeEvent
    struct ViewState {
        var isFavorite: Bool = false
        var name: String = ""
        var url: URL? = nil
        var types: [String] = []
        var id: Int = 0
    }
    
    @Published private(set) var state: ViewState = ViewState()
    private var store: VMStore
    private var stateCancellable: AnyCancellable?
    private var pokemon: Pokemon
    
    init(pokemon: Pokemon, store: VMStore) {
        self.store = store
        self.pokemon = pokemon
        self.stateCancellable = store.$state.sink(receiveValue: stateChanged)
    }
    
    func dispatch(event: PokeEvent) {
        store.dispatch(event: event)
    }
    
    private func stateChanged(newState: PokeState) {
        self.state.id = pokemon.id
        self.state.name = pokemon.name
        self.state.url = URL(string: pokemon.sprites.front)
        self.state.types = pokemon.types.map(\.name)
        self.state.isFavorite = newState.isFavorite
    }
}
