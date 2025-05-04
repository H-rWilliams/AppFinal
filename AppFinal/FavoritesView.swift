//
//  Favorites.swift
//  AppFinal
//
//  Created by WILLIAMS, HUNTER R. on 4/30/25.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        VStack {
            if appState.favorites.isEmpty {
                Text("No favorites yet.")
                    .font(.headline)
                    .padding()
            } else {
                ScrollView {
                    LazyVStack(spacing: 10) {
                        ForEach(appState.favorites, id: \.self) { url in
                            VStack {
                                NavigationLink(destination: DetailView(imageURL: url)) {
                                    AsyncImage(url: URL(string: url)) { image in
                                        image
                                            .resizable()
                                            .scaledToFit()
                                            .cornerRadius(10)
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .frame(height: 200)
                                    .padding(.horizontal)
                                }

                                Button("Remove") {
                                    removeFromFavorites(url)
                                }
                                .buttonStyle(.borderedProminent)
                                .tint(.red)
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Favorites")
    }

    func removeFromFavorites(_ url: String) {
        if let index = appState.favorites.firstIndex(of: url) {
            appState.favorites.remove(at: index)
        }
    }
}


