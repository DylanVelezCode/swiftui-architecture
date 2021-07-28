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
    //MARK: - Dependencies
    private let onboardingProvider = OnboardingDependencyProvider()
    private let listProvider = PokeListDependencyProvider()
    private let itemProvider = PokeItemDependencyProvider()
    private let favoritesProvider = FavoritesDependencyProvider()
    
    @ObservedObject private(set) var viewModel = AppViewModel()
    
    //MARK: - Body
    var body: some Scene {
        WindowGroup {
            ContentView()
                .sheet(isPresented: sheetBinding,
                       onDismiss: onboardingDismissed,
                       content: onboardingView)
                .onAppear(perform: fetchOnboardingStatus)
        }
    }
}

//MARK: - Events
private extension PokeApp {
    func onboardingView() -> some View {
        OnboardingView()
    }
    
    func onboardingDismissed() {
        viewModel.dispatch(event: .onboardingDismissed)
    }
    
    func fetchOnboardingStatus() {
        viewModel.dispatch(event: .fetchOnboardingStatus)
    }
}

//MARK: - View Extensions
private extension PokeApp {
    var sheetBinding: Binding<Bool> {
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
