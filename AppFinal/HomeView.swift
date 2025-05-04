//
//  HomeView.swift
//  AppFinal
//
//  Created by Sherry Williams on 5/3/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @Binding var favorites: Set<Int>

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
                                DetailView(pokemon: pokemon, favorites: $favorites)
                            } label: {
                                HStack(spacing: 16) {
                                    if let imageUrl = pokemon.sprites.front_default,
                                       let url = URL(string: imageUrl) {
                                        AsyncImage(url: url) { image in
                                            image
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 60, height: 60)
                                        } placeholder: {
                                            ProgressView()
                                        }
                                    } else {
                                        Image(systemName: "questionmark.circle")
                                            .resizable()
                                            .frame(width: 60, height: 60)
                                            .foregroundColor(.gray)
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

