//
//  OnboardingReducer.swift
//  Poke
//
//  Created by Dylan Vélez on 21/07/21.
//

import Foundation
import Combine
import PokeArch

public class OnboardingReducer: Reducing {
    public typealias State = OnboardingState
    public typealias Event = OnboardingEvent
    
    private let key = "com.dylansvm.pokearch.onboarding"
    
    public init() { }
    
    private func sideEffect(event: Event) -> Effect<Event> {
        switch event {
        case .fetchOnboardingStatus:
            let shouldPresentOnboarding = !UserDefaults.standard.bool(forKey: key)
            let event = shouldPresentOnboarding ? OnboardingEvent.presentOnboarding : OnboardingEvent.onboardingDismissed
            return Just(event).eraseToAnyPublisher()
        case .onboardingDismissed:
            UserDefaults.standard.set(true, forKey: key)
        case .presentOnboarding:
            break
        }
        return nil
    }
    
    public func reduce(state: inout State, forEvent event: Event) -> Effect<Event> {
        switch event {
        case .presentOnboarding:
            state.shouldPresentOnboarding = true
        case .onboardingDismissed:
            state.shouldPresentOnboarding = false
        case .fetchOnboardingStatus:
            break
        }
        
        return sideEffect(event: event)
    }
}
