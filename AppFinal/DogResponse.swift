//
//  DogResponse.swift
//  AppFinal
//
//  Created by Hunter Williams on 5/3/25.
//

import Foundation

// Structs which we can decode dogceo API response JSON into

// Dog response grabs a single image, decoding the url and status of the request
struct DogResponse: Decodable {
    let message: String
    let status: String
}

// Breed Response is for decoding an array of multiple images for a specific breed
struct BreedResponse: Decodable {
    let message: [String]
    let status: String
}
