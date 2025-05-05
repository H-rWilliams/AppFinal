//
//  FavoritesView.swift
//  AppFinal
//
//  Created by WILLIAMS, HUNTER R. on 4/30/25.
//

import SwiftUI

struct FavoritesView: View {
//    Gives us access to AppState instance
    @EnvironmentObject var appState: AppState

    var body: some View {
//       Creates vertical layout
        VStack {
//            If we have no images favorited, display a message informing the user of this
            if appState.favorites.isEmpty {
                Text("No favorites yet.")
                    .font(.headline)
                    .padding()
//                If we do have favotites
            } else {
//                Set up a vertical scrollview
                ScrollView {
                    LazyVStack(spacing: 10) {
//                        For each favorited url in the favorites array
                        ForEach(appState.favorites, id: \.self) { url in
//                            Create a VStack in the scrollview to hold the image, housed in a navigation link
                            VStack {
//                                This let's us navigate to detail view when the image is tapped
                                NavigationLink(destination: DetailView(imageURL: url)) {
                                    AsyncImage(url: URL(string: url)) { image in
                                        image
                                            .resizable()
                                            .scaledToFit()
                                            .cornerRadius(10)
//                                        Show loading spinner while image downloads
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .frame(height: 200)
                                    .padding(.horizontal)
                                }
//                              Button for removing a favorite
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

//    Send the url of the image, and remove it from the favorites array
    func removeFromFavorites(_ url: String) {
        if let index = appState.favorites.firstIndex(of: url) {
            appState.favorites.remove(at: index)
        }
    }
}


