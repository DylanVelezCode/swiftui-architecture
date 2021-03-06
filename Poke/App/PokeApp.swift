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
    
    @ObservedObject private(set) var viewModel = AppViewModel(store: .init(initialState: .init(), reducer: .init()))
    
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
                       set: { viewModel.dispatch(event: $0 ? .presentOnboarding : .onboardingDismissed) })
    }
}
