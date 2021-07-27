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

class PokeFavoritesViewModel: ViewModel {
    struct ViewState {
        var list: [Pokemon] = []
    }
    
    @Published private(set) var state: ViewState = ViewState()
    private var store: AnyStore<PokeFavoritesState, PokeFavoritesEvent>
    private var stateCancellable: AnyCancellable?
    
    init(store: AnyStore<PokeFavoritesState, PokeFavoritesEvent>) {
        self.store = store
        self.stateCancellable = store.$state.sink(receiveValue: stateChanged)
    }
    
    func dispatch(event: PokeFavoritesEvent) {
        store.dispatch(event: event)
    }
    
    private func stateChanged(newState: PokeFavoritesState) {
        self.state.list = newState.list.sorted { $0.id < $1.id }
    }
}
