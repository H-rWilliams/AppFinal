//
//  DetailView.swift
//  AppFinal
//
//  Created by WILLIAMS, HUNTER R. on 4/30/25.
//

import SwiftUI

struct DetailView: View {
    let imageURL: String

    var body: some View {
        VStack(spacing: 20) {
            Text("Breed: \(breedName(from: imageURL))")
                .font(.title2)
                .padding(.top)

            AsyncImage(url: URL(string: imageURL)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(12)
            } placeholder: {
                ProgressView()
            }
            .frame(height: 300)
            .padding()

            Spacer()
        }
        .navigationTitle("Dog Details")
    }

    // Extract breed name from the image URL
    func breedName(from url: String) -> String {
        // Example: https://dog.ceo/api/img/hound-afghan/n02088094_1003.jpg
        let components = url.split(separator: "/")
        if let index = components.firstIndex(of: "breeds"), index + 1 < components.count {
            let rawBreed = components[index + 1].replacingOccurrences(of: "-", with: " ")
            return rawBreed.capitalized
        } else if let breedsIndex = components.firstIndex(of: "img"), breedsIndex + 1 < components.count {
            let rawBreed = components[breedsIndex + 1].replacingOccurrences(of: "-", with: " ")
            return rawBreed.capitalized
        }
        return "Unknown"
    }
}



