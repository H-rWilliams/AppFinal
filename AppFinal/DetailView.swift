//
//  DetailView.swift
//  AppFinal
//
//  Created by WILLIAMS, HUNTER R. on 4/30/25.
//

import SwiftUI

struct DetailView: View {
    let pokemon: Pokemon
    @Binding var favorites: Set<Int>  // Pass in favorites from parent
     
    var isFavorite: Bool {
        favorites.contains(pokemon.id)
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                AsyncImage(url: URL(string: pokemon.sprites.front_default)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                } placeholder: {
                    ProgressView()
                }

                Text(pokemon.name.capitalized)
                    .font(.largeTitle)
                    .bold()

                HStack {
                    Text("Height: \(pokemon.height)")
                    Text("Weight: \(pokemon.weight)")
                }
                .font(.subheadline)

                VStack(alignment: .leading) {
                    Text("Type(s):")
                        .font(.headline)

                    ForEach(pokemon.types, id: \.type.name) { typeEntry in
                        Text(typeEntry.type.name.capitalized)
                    }
                }

                Button(action: {
                    if isFavorite {
                        favorites.remove(pokemon.id)
                    } else {
                        favorites.insert(pokemon.id)
                    }
                }) {
                    Label(isFavorite ? "Unfavorite" : "Favorite", systemImage: isFavorite ? "heart.fill" : "heart")
                        .padding()
                        .foregroundColor(.white)
                        .background(isFavorite ? Color.red : Color.blue)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
        .navigationTitle(pokemon.name.capitalized)
    }
}
