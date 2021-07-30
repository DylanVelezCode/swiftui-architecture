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
import PokeInjection

class PokeListViewModel: ViewModel {
    typealias Event = PokeListEvent
    
    struct ViewState {
        var list: [Pokemon] = []
        var isLoading = false
    }
    
    @Published private(set) var state: ViewState = ViewState()
    var store: ListStore
    private var stateCancellable: AnyCancellable?
    
    init(store: ListStore) {
        self.store = store
        stateCancellable = store.$state.sink(receiveValue: stateChanged)
    }
    
    func stateChanged(newState: PokeListState) {
        if !newState.list.isEmpty {
            DispatchQueue.main.async {
                self.state.list.append(contentsOf: newState.list.sorted { $0.id < $1.id })
            }
        }
        self.state.isLoading = newState.isLoading
    }
}
