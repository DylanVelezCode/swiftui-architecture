//
//  PokeListViewModel.swift
//  Poke
//
//  Created by Dylan Vélez on 21/07/21.
//

import Foundation
import PokeArch
import PokeModels
import Combine
import PokeDomain

class PokeListViewModel: ViewModel {
    typealias VMStore = Store<PokeListState, PokeListEvent, PokeListReducer>
    typealias Event = PokeListEvent
    struct ViewState {
        var list: [Pokemon] = []
        var isLoading = false
    }
    
    @Published private(set) var state: ViewState = ViewState()
    private var store: VMStore
    private var stateCancellable: AnyCancellable?
    
    init(store: VMStore) {
        self.store = store
        
        stateCancellable = store.$state.sink(receiveValue: stateChanged)
    }
    
    func dispatch(event: PokeListEvent) {
        store.dispatch(event: event)
    }
    
    private func stateChanged(newState: PokeListState) {
        if !newState.list.isEmpty {
            self.state.list.append(contentsOf: newState.list.sorted { $0.id < $1.id })
        }
        self.state.isLoading = newState.isLoading
    }
}
