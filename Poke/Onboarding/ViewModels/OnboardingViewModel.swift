//
//  OnboardingViewModel.swift
//  Poke
//
//  Created by Dylan Vélez on 21/07/21.
//

import Foundation
import Combine
import PokeArch

class OnboardingViewModel: ViewModel {
    struct ViewState {
        var shouldPresent = true
    }
    
    @Published private(set) public var state: ViewState = ViewState()
    private var store: AnyStore<OnboardingState, OnboardingEvent>
    private var stateCancellable: AnyCancellable?
    
    init(store: AnyStore<OnboardingState, OnboardingEvent>) {
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
