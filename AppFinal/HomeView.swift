//
//  HomeView.swift
//  AppFinal
//
//  Created by Hunter Williams on 5/3/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = DogViewModel()
    @EnvironmentObject var appState: AppState
    @State private var breedInput = ""

    var body: some View {
        VStack {
            // Breed search
            HStack {
                TextField("Enter dog breed", text: $breedInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                Button("Search") {
                    if breedInput.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                        viewModel.fetchRandomDogs()
                    } else {
                        viewModel.fetchBreedImages(for: breedInput.lowercased())
                    }
                }
                .buttonStyle(.bordered)
            }

            // Dog images
            ScrollView {
                LazyVStack(spacing: 10) {
                    ForEach(viewModel.dogImageURLs, id: \.self) { url in
                        NavigationLink(destination: DetailView(imageURL: url)) {
                            VStack {
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

                                Button(appState.favorites.contains(url) ? "Unfavorite" : "Favorite") {
                                    toggleFavorite(url)
                                }
                                .buttonStyle(.borderedProminent)
                                .padding(.bottom)
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Browse Dogs")
        .onAppear {
            viewModel.fetchRandomDogs()
        }
    }

    // Toggle favorite state
    func toggleFavorite(_ url: String) {
        if let index = appState.favorites.firstIndex(of: url) {
            appState.favorites.remove(at: index)
        } else {
            appState.favorites.append(url)
        }
    }
}



