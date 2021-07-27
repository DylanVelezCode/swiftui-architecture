//
//  PokeApp.swift
//  Poke
//
//  Created by Dylan Vélez on 17/07/21.
//

import SwiftUI
import PokeArch
import PokeDomain

@main
struct PokeApp: App, ViewConfigurable {
    @ObservedObject private(set) var viewModel: OnboardingViewModel = .init(store: .init(initialState: .init(),
                                                                         reducer: OnboardingReducer(),
                                                                         middlewares: [OnboardingMiddleware()]))
    var body: some Scene {
        WindowGroup {
            ContentView()
                .sheet(isPresented: .init(get: { viewModel.state.shouldPresent }, set: {
                    $0 ? viewModel.dispatch(event: .presentOnboarding) : viewModel.dispatch(event: .onboardingDismissed)
                }), onDismiss: { viewModel.dispatch(event: .onboardingDismissed) }) {
                    OnboardingView()
                }
                .onAppear {
                    viewModel.dispatch(event: .fetchOnboardingStatus)
                }
        }
    }
}
