//
//  OnboardingState.swift
//  Poke
//
//  Created by Dylan Vélez on 21/07/21.
//

import Foundation

/// The state of the onboarding screens
public struct OnboardingState {
    public var shouldPresentOnboarding: Bool = false
    public init() { }
}

/// Possible events for the onboarding
public enum OnboardingEvent {
    case fetchOnboardingStatus
    case presentOnboarding
    case onboardingDismissed
}
