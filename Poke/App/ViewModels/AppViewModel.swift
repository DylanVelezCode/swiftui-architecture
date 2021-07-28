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
    //MARK: View State
    struct ViewState {
        var shouldPresent = false
    }
    
    @Published private(set) public var state = ViewState()
    @Inject var store: OnboardingStore
    private var stateCancellable: AnyCancellable?
    
    public init() {
        stateCancellable = store.$state.sink(receiveValue: stateChanged)
    }
    
    func dispatch(event: OnboardingEvent) {
        store.dispatch(event: event)
    }
    
    private func stateChanged(newState: OnboardingState) {
        state.shouldPresent = newState.shouldPresentOnboarding
    }
}
