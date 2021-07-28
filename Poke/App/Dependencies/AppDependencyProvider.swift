//
//  AppDependencyProvider.swift
//  Poke
//
//  Created by Dylan Vélez on 27/07/21.
//

import Foundation
import PokeInjection
import PokeArch
import PokeDomain

typealias AppStore = Store<OnboardingState, OnboardingEvent, OnboardingReducer>
struct AppDependencyProvider {
    @Provider var store = AppStore(initialState: OnboardingState(), reducer: OnboardingReducer())
}
