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

class PokeListViewModel: ViewModel {
    struct ViewState {
        var list: [Pokemon] = []
        var isLoading = false
    }
    
    @Published private(set) var state: ViewState = ViewState()
    private var store: AnyStore<PokeListState, PokeListEvent>
    private var stateCancellable: AnyCancellable?
    
    init(store: AnyStore<PokeListState, PokeListEvent>) {
        self.store = store
        
        stateCancellable = store.$state.sink(receiveValue: stateChanged)
    }
    
    func dispatch(event: PokeListEvent) {
        store.dispatch(event: event)
    }
    
    private func stateChanged(newState: PokeListState) {
        if !newState.list.isEmpty {
            self.state.list.append(contentsOf: newState.list)
        }
        self.state.isLoading = newState.isLoading
    }
}
