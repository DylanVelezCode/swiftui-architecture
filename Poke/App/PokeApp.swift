//
//  PokeApp.swift
//  Poke
//
//  Created by Dylan Vélez on 17/07/21.
//

import SwiftUI
import PokeArch
import PokeDomain
import PokeInjection

@main
struct PokeApp: App, ViewConfigurable {
    private var dependencyProvider = AppDependencyProvider()
    @ObservedObject private(set) var viewModel: AppViewModel
    
    init() {
        self.viewModel = AppViewModel()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .sheet(isPresented: sheetBinding, onDismiss: { viewModel.dispatch(event: .onboardingDismissed) }) {
                    OnboardingView()
                }
                .onAppear {
                    viewModel.dispatch(event: .fetchOnboardingStatus)
                }
        }
    }
    
    private var sheetBinding: Binding<Bool> {
        return Binding(get: { viewModel.state.shouldPresent },
                       set:  { shouldPresent in
            if shouldPresent {
                viewModel.dispatch(event: .presentOnboarding)
            } else {
                viewModel.dispatch(event: .onboardingDismissed)
            }
        })
    }
}
