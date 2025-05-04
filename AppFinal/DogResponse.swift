//
//  DogResponse.swift
//  AppFinal
//
//  Created by Hunter Williams on 5/3/25.
//

import Foundation

struct DogResponse: Decodable {
    let message: String
    let status: String
}

struct BreedResponse: Decodable {
    let message: [String]
    let status: String
}
