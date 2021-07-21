//
//  OnboardingMiddleware.swift
//  Poke
//
//  Created by Dylan Vélez on 21/07/21.
//

import Foundation
import Combine
import PokeArch

class OnboardingMiddleware: AnyMiddleware<OnboardingState, OnboardingEvent> {
    let key = "com.dylansvm.pokearch.onboarding"
    override func intercept(state: OnboardingState, forEvent event: OnboardingEvent) -> AnyPublisher<OnboardingEvent, Never> {
        switch event {
        case .fetchOnboardingStatus:
            let shouldPresentOnboarding = !UserDefaults.standard.bool(forKey: key)
            let event = shouldPresentOnboarding ? OnboardingEvent.presentOnboarding : OnboardingEvent.onboardingDismissed
            return Just(event).eraseToAnyPublisher()
        case .onboardingDismissed:
            UserDefaults.standard.set(true, forKey: key)
            fallthrough
        default:
            return Empty().eraseToAnyPublisher()
        }
    }
}
