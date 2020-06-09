//
//  HomeWorker.swift
//  CleanPokedex
//
//  Created by Igor Gomes Arantes on 03/06/20.
//  Copyright © 2020 Igor Gomes Arantes. All rights reserved.
//

import Foundation

protocol PokemonStore {
    func requestPokemons(completion: @escaping (Result<[Pokemon], Error>) -> Void)
}

final class PokemonWorker: PokemonStore {
    // MARK: Properties
    let baseURL = "https://gist.githubusercontent.com/IgorGomesArantes"
    
    // MARK: Store methods
    func requestPokemons(completion: @escaping (Result<[Pokemon], Error>) -> Void) {
        let path = "b2b9bed333c52e5148fe2d25131e8d22/raw/b7cc9d4f4f6822017ff93777a0cde5c4dad81461/pokedex.json"
        HTTPService.getData(url:  URL(string: "\(baseURL)/\(path)")!) { (result) in
            completion(result)
        }
    }
}

final class MockedPokemonWorker: PokemonStore {
    // MARK: Store methods
    func requestPokemons(completion: @escaping (Result<[Pokemon], Error>) -> Void) {
        let pokemons = try! JSONDecoder().decode([Pokemon].self, from: MockDataHelper.getData(forResource: .pokemons))
        completion(.success(pokemons))
    }
}
