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
import PokeInjection

class PokeListItemViewModel: ViewModel {
    typealias Event = PokeEvent
    struct ViewState {
        var isFavorite: Bool = false
        var name: String = ""
        var url: URL? = nil
        var types: [String] = []
        var id: Int = 0
    }
    
    @Published private(set) var state: ViewState = ViewState()
    var store: PokeItemStore
    private var stateCancellable: AnyCancellable?
    private var pokemon: Pokemon
    
    init(pokemon: Pokemon, store: PokeItemStore) {
        self.pokemon = pokemon
        self.store = store
        self.state.id = pokemon.id
        self.state.name = pokemon.name.replacingOccurrences(of: "-", with: " ").capitalized
        self.state.url = URL(string: pokemon.sprites.front)
        self.state.types = pokemon.types.map(\.name.capitalized)
        self.stateCancellable = store.$state.sink(receiveValue: stateChanged)
        store.dispatch(event: .fetchIsFavorite(id: pokemon.id))
    }
    
    func stateChanged(newState: PokeState) {
        self.state.isFavorite = newState.isFavorite
    }
}
