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
import PokeInjection

class AppViewModel: ViewModel {
    typealias Event = OnboardingEvent
    
    struct ViewState {
        var shouldPresent = true
    }
    
    @Published private(set) public var state: ViewState
    private var stateCancellable: AnyCancellable?
    @Inject var store: OnboardingStore
    
    public init() {
        self.state = ViewState()
        self.stateCancellable = nil
        stateCancellable = store.$state.sink(receiveValue: stateChanged)
    }
    
    func dispatch(event: OnboardingEvent) {
        store.dispatch(event: event)
    }
    
    private func stateChanged(newState: OnboardingState) {
        state.shouldPresent = newState.shouldPresentOnboarding
    }
}
