//
//  HomeView.swift
//  AppFinal
//
//  Created by Hunter Williams on 5/3/25.
//

import SwiftUI

struct HomeView: View {
//    Creates and owns an instance of DogViewModel. DogViewModel is our "source of truth" for dog images. As a state object, swiftUI watches for updates and refreshes the view when the instance changes (specifically our list of images)
    @StateObject var viewModel = DogViewModel()
//    Pulls in shared AppState, allowing access to our favorites
    @EnvironmentObject var appState: AppState
//    Local state var which handles user input when searching for a different breed. The value updates as the user types
    @State private var breedInput = ""

    var body: some View {
        VStack {
//            Sets a horizontal layout for the search bar
            HStack {
//                Textfield which prompts the user to search for a breed, saving the breed typed to breedInput
                TextField("Enter dog breed", text: $breedInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
// If the search bar is empty, call fetchRandomDogs()
                Button("Search") {
                    if breedInput.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                        viewModel.fetchRandomDogs()
// If the search bar has input, call fetchBreedImages() with the given input
                    } else {
                        viewModel.fetchBreedImages(for: breedInput.lowercased())
                    }
                }
                .buttonStyle(.bordered)
            }

            // This creates a scrollable list of images
            ScrollView {
                LazyVStack(spacing: 10) {
//                    For each url in our list of image url's do this
                    ForEach(viewModel.dogImageURLs, id: \.self) { url in
//                        Wrap in a navigation link to allow tapping an image to go to a detailed view of it
                        NavigationLink(destination: DetailView(imageURL: url)) {
                            VStack {
//                                Use asyncimage to prevent blocking the main thread, and display a loading progress bar while images download
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
//                            Button for favorites
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
//        Runs fetchRandomDogs when the view initially loads
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



