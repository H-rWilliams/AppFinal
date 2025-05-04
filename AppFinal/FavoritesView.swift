//
//  Favorites.swift
//  AppFinal
//
//  Created by WILLIAMS, HUNTER R. on 4/30/25.
//

import SwiftUI

struct FavoritesView: View {
    @Binding var favorites: Set<Int>
    @StateObject private var viewModel = HomeViewModel()

    var body: some View {
        VStack {
            if favorites.isEmpty {
                Text("No favorites yet.")
                    .font(.subheadline)
                    .padding()
            } else {
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(viewModel.pokemonList.filter { favorites.contains($0.id) }) { pokemon in
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
        .navigationTitle("Favorites")
    }
}

