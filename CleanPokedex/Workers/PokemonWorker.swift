//
//  HomeWorker.swift
//  CleanPokedex
//
//  Created by Igor Gomes Arantes on 03/06/20.
//  Copyright © 2020 Igor Gomes Arantes. All rights reserved.
//

import Foundation

protocol PokemonStore {
    func getPokemons(completion: @escaping (Result<[Pokemon], Error>) -> Void)
}

final class PokemonWorker {
    // MARK: Properties
    private let pokemonStore: PokemonStore
    
    // MARK: Initialization methods
    init(pokemonStore: PokemonStore) {
        self.pokemonStore = pokemonStore
    }
}

// MARK: Request methods
extension PokemonWorker {
    func getPokemons(completion: @escaping ([Pokemon]) -> Void) {
        pokemonStore.getPokemons { (result) in
            switch result {
            case .success(let pokemons):
                completion(pokemons)
            case .failure:
                completion([])
            }
        }
    }
}



