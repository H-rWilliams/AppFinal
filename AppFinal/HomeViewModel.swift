//
//  HomeViewModel.swift
//  AppFinal
//
//  Created by Hunter Williams on 5/3/25.
//

import Foundation
import SwiftUI

class DogViewModel: ObservableObject {
    @Published var dogImageURLs: [String] = []
    
    // Fetch 15 random dog images
    func fetchRandomDogs() {
        dogImageURLs = []  // Clear current data
        for _ in 1...15 {
            guard let url = URL(string: "https://dog.ceo/api/breeds/image/random") else { continue }
            
            URLSession.shared.dataTask(with: url) { data, _, error in
                if let data = data {
                    do {
                        let decoded = try JSONDecoder().decode(DogResponse.self, from: data)
                        DispatchQueue.main.async {
                            self.dogImageURLs.append(decoded.message)
                        }
                    } catch {
                        print("JSON Decode error: \(error)")
                    }
                } else if let error = error {
                    print("Network error: \(error)")
                }
            }.resume()
        }
    }

    // Fetch breed-specific images
    func fetchBreedImages(for breed: String) {
        dogImageURLs = []  // Clear current data
        
        let formattedBreed = breed.lowercased()
        let urlString = "https://dog.ceo/api/breed/\(formattedBreed)/images"
        
        guard let url = URL(string: urlString) else {
            print("Invalid breed URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                do {
                    let decoded = try JSONDecoder().decode(BreedResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.dogImageURLs = Array(decoded.message.prefix(15)) // Limit to 15
                    }
                } catch {
                    print("Breed Decode error: \(error)")
                }
            } else if let error = error {
                print("Network error: \(error)")
            }
        }.resume()
    }
}

