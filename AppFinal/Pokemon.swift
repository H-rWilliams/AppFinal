//
//  Pokemon.swift
//  AppFinal
//
//  Created by Sherry Williams on 5/3/25.
//

import Foundation

struct Pokemon: Identifiable, Decodable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let sprites: Sprites
    let types: [TypeEntry]
    
    struct Sprites: Decodable {
        let front_default: String?
    }
    
    struct TypeEntry: Decodable {
        let type: TypeInfo
    }
    
    struct TypeInfo: Decodable {
        let name: String
    }
}
