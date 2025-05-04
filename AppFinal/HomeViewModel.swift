//
//  HomeViewModel.swift
//  AppFinal
//
//  Created by Sherry Williams on 5/3/25.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var pokemonList: [Pokemon] = []
    
    init() {
        fetchInitialPokemon()
    }
    
    func fetchInitialPokemon() {
        for id in 1...15 {
            PokemonService.fetchPokemon(id: id) { result in
                switch result {
                case .success(let pokemon):
                    self.pokemonList.append(pokemon)
                case .failure(let error):
                    print("Error fetching Pokemon #\(id): \(error.localizedDescription)")
                }
            }
        }
    }
}
