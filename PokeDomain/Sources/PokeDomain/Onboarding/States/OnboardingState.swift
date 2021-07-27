//
//  OnboardingState.swift
//  Poke
//
//  Created by Dylan Vélez on 21/07/21.
//

import Foundation

public struct OnboardingState {
    public var shouldPresentOnboarding: Bool = false
    public init() { }
}

public enum OnboardingEvent {
    case fetchOnboardingStatus
    case presentOnboarding
    case onboardingDismissed
}
