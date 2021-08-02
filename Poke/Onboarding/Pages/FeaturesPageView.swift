//
//  FeaturesPageView.swift
//  Poke
//
//  Created by Dylan Vélez on 21/07/21.
//

import SwiftUI

struct FeaturesPageView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("Features")
                .bold()
                .font(.largeTitle)
                .foregroundColor(.red)
            VStack {
                HStack {
                    Spacer()
                    Image("page1")
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(12)
                        .padding()
                    Spacer()
                }.background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]),
                                            startPoint: .top, endPoint: .bottom)
                                .opacity(0.1))
                    .cornerRadius(16)
                    .padding()
                    .overlay(Text("The whole PokéDex")
                                .bold()
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .background(Rectangle()
                                                .fill(Color.red)
                                                .opacity(0.8))
                                .cornerRadius(12))
                
                HStack {
                    Spacer()
                    Image("favorite-feature")
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(12)
                        .padding()
                    Image("detail-feature")
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(12)
                        .padding()
                    Spacer()
                }.background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]),
                                            startPoint: .top, endPoint: .bottom)
                                .opacity(0.1))
                    .cornerRadius(16)
                    .padding()
                    .overlay(Text("Favorites and Details")
                                .bold()
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .background(Rectangle()
                                                .fill(Color.red)
                                                .opacity(0.8))
                                .cornerRadius(12))
            }
            Spacer()
        }
    }
}

struct FeaturesPageView_Previews: PreviewProvider {
    static var previews: some View {
        FeaturesPageView()
    }
}
