//
//  IntroPageView.swift
//  Poke
//
//  Created by Dylan Vélez on 21/07/21.
//

import SwiftUI

struct IntroPageView: View {
    private let description = """
    Welcome! This will now be your personal pokedex.
    Spanning from the first OG generation up to the 8th one.
    """
    var body: some View {
        VStack {
            Spacer()
            Text("Your Personal PokeDex!")
                .bold()
                .font(.largeTitle)
                .foregroundColor(.red)
            Text("At your hands")
                .bold()
                .font(.subheadline)
                .foregroundColor(.red)
                .opacity(0.5)
            HStack {
                Spacer()
                Image("page1")
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(12)
                    .padding()
                Spacer()
            }.background(LinearGradient(colors: [.blue, .purple],
                                        startPoint: .top, endPoint: .bottom)
                            .opacity(0.1))
                .cornerRadius(16)
                .padding()
        }
    }
}

struct IntroPageView_Previews: PreviewProvider {
    static var previews: some View {
        IntroPageView()
    }
}
