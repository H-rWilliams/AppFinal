//
//  DetailView.swift
//  AppFinal
//
//  Created by WILLIAMS, HUNTER R. on 4/30/25.
//

import SwiftUI

struct DetailView: View {
//    constant property used to house an image url passed to the view
    let imageURL: String
//    Gives us access to AppState, which handles favoriting logic
    @EnvironmentObject var appState: AppState

    var body: some View {
//        Create a vertical layout
        VStack(spacing: 20) {
//            Title with the dogs breed, which is grabbed from the url passed to the view
            Text("Breed: \(breedName(from: imageURL))")
                .font(.title2)
                .padding(.top)

//            Asynchronously load the image from the url passed to the view
            AsyncImage(url: URL(string: imageURL)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(12)
            } placeholder: {
//                Displays a spinning loader while the image is downloading
                ProgressView()
            }
            .frame(height: 300)
            .padding()

            // Button to toggle the image as a favorite
            Button(action: {
                toggleFavorite()
            }) {
//                Checks to see if the image is in our favorites array
//                If so, remove it. If not, add it
                Image(systemName: appState.favorites.contains(imageURL) ? "heart.fill" : "heart")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.red)
            }
            .padding()

            Spacer()
        }
        .navigationTitle("Dog Details")
    }

    // Extract breed name from the image URL
    func breedName(from url: String) -> String {
//        Splits the url with a / delimiter
        let components = url.split(separator: "/")
//        Looks for "breeds" in the components list. If present, we check the index of the next item, which is typically the breed name. We remove hyphens and capitalize, returning the breed
        if let index = components.firstIndex(of: "breeds"), index + 1 < components.count {
            let rawBreed = components[index + 1].replacingOccurrences(of: "-", with: " ")
            return rawBreed.capitalized
//            If breeds isn't present, check the url array for "img". If present, check the next indexed value, typically a breed name, and perform the same logic ^
        } else if let breedsIndex = components.firstIndex(of: "img"), breedsIndex + 1 < components.count {
            let rawBreed = components[breedsIndex + 1].replacingOccurrences(of: "-", with: " ")
            return rawBreed.capitalized
        }
//        Fallback
        return "Unknown"
    }

    // If the image is in the array, remove it. If not, append it
    func toggleFavorite() {
        if let index = appState.favorites.firstIndex(of: imageURL) {
            appState.favorites.remove(at: index)
        } else {
            appState.favorites.append(imageURL)
        }
    }
}



