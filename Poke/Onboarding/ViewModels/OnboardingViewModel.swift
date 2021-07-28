//
//  OnboardingViewModel.swift
//  Poke
//
//  Created by Dylan Vélez on 21/07/21.
//

import Foundation
import Combine
import PokeArch
import PokeDomain

class OnboardingViewModel: ViewModel {
    typealias Event = OnboardingEvent
    typealias VMStore = Store<OnboardingState, OnboardingEvent, OnboardingReducer>
    struct ViewState {
        var shouldPresent = true
    }
    
    @Published private(set) public var state: ViewState = ViewState()
    private var store: VMStore
    private var stateCancellable: AnyCancellable?
    
    init(store: VMStore) {
        self.store = store
        stateCancellable = store.$state
            .sink(receiveValue: stateChanged)
    }
    
    func dispatch(event: OnboardingEvent) {
        store.dispatch(event: event)
    }
    
    private func stateChanged(newState: OnboardingState) {
        state.shouldPresent = newState.shouldPresentOnboarding
    }
}
