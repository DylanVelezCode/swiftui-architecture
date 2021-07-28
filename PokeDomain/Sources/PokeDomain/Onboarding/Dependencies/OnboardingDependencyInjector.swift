//
//  File.swift
//  
//
//  Created by Dylan Vélez on 28/07/21.
//
import Foundation
import PokeServices
import PokeModels
import PokeArch
import PokeInjection

public typealias OnboardingStore = Store<OnboardingState, OnboardingEvent, OnboardingReducer>

public struct OnboardingDependencyProvider {
    @Provider var store = OnboardingStore(initialState: OnboardingState(), reducer: OnboardingReducer())
    public init() { }
}
