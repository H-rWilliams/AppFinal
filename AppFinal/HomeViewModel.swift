//
//  HomeViewModel.swift
//  AppFinal
//
//  Created by Hunter Williams on 5/3/25.
//

import Foundation
import SwiftUI

// Make class conform to ObservableObject, meaning swiftUI views can subscribe to it and update automatically when @published variables inside change
class DogViewModel: ObservableObject {
//    A published array used to store urls for dog images
    @Published var dogImageURLs: [String] = []
    
    // Fetch 15 random dog images
    func fetchRandomDogs() {
        dogImageURLs = []  // Clear current data
//        Run a loop 15 times
        for _ in 1...15 {
//            Make a request for each iteration
            guard let url = URL(string: "https://dog.ceo/api/breeds/image/random") else { continue }
//            Async network call
            URLSession.shared.dataTask(with: url) { data, _, error in
//                Decodes the response JSON into DogResponse, extracts the dog image url, and appends it to our @published array on the main thread
                if let data = data {
                    do {
                        let decoded = try JSONDecoder().decode(DogResponse.self, from: data)
                        DispatchQueue.main.async {
                            self.dogImageURLs.append(decoded.message)
                        }
//                        Catch errors during deserialization
                    } catch {
                        print("JSON Decode error: \(error)")
                    }
//                    Catch bad calls
                } else if let error = error {
                    print("Network error: \(error)")
                }
            }.resume()
        }
    }

    // Fetch breed-specific images
//    Similar logic to the previous function, with the main difference being the endpoint we target. We pass the breed the user searches for and returns 15 images for that specific breed
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

