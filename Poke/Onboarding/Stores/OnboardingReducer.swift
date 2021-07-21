//
//  OnboardingReducer.swift
//  Poke
//
//  Created by Dylan Vélez on 21/07/21.
//

import Foundation
import PokeArch

class OnboardingReducer: AnyReducer<OnboardingState, OnboardingEvent> {
    override func reduce(state: inout OnboardingState, forEvent event: OnboardingEvent) {
        switch event {
        case .presentOnboarding:
            state.shouldPresentOnboarding = true
        case .onboardingDismissed:
            state.shouldPresentOnboarding = false
        default:
            break
        }
    }
}
