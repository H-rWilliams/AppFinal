//
//  HomeView.swift
//  AppFinal
//
//  Created by Sherry Williams on 5/3/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        VStack {
            if viewModel.pokemonList.isEmpty {
                ProgressView("Loading Pokémon...")
                    .padding()
            } else {
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(viewModel.pokemonList) { pokemon in
                            NavigationLink {
                                // Placeholder — later you'll pass this to DetailView
                                Text("Details for \(pokemon.name.capitalized)")
                            } label: {
                                HStack(spacing: 16) {
                                    AsyncImage(url: URL(string: pokemon.sprites.front_default)) { image in
                                        image
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 60, height: 60)
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    
                                    Text(pokemon.name.capitalized)
                                        .font(.headline)
                                }
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(12)
                            }
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationTitle("Pokédex")
    }
}
