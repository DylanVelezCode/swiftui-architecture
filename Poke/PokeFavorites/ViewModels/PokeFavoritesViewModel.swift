//
//  PokeFavoritesViewModel.swift
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

class PokeFavoritesViewModel: ViewModel {
    typealias Event = PokeFavoritesEvent
    
    struct ViewState {
        var list: [Pokemon] = []
    }
    
    @Published private(set) var state: ViewState = ViewState()
    var store: FavoriteStore
    private var stateCancellable: AnyCancellable?
    
    init(store: FavoriteStore) {
        self.store = store
        self.stateCancellable = store.$state.sink(receiveValue: stateChanged)
    }
    
    func stateChanged(newState: PokeFavoritesState) {
        self.state.list = newState.list.sorted { $0.id < $1.id }
    }
}
