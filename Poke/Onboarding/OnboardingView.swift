//
//  OnboardingView.swift
//  Poke
//
//  Created by Dylan Vélez on 21/07/21.
//

import SwiftUI

struct OnboardingView: View {
    var body: some View {
        TabView {
            IntroPageView()
            FeaturesPageView()
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
