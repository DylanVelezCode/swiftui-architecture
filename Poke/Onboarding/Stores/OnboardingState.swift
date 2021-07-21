//
//  OnboardingState.swift
//  Poke
//
//  Created by Dylan Vélez on 21/07/21.
//

import Foundation

struct OnboardingState {
    var shouldPresentOnboarding: Bool = false
}

enum OnboardingEvent {
    case fetchOnboardingStatus
    case presentOnboarding
    case onboardingDismissed
}
