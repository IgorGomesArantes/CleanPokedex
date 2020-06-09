//
//  PokemonAPI.swift
//  CleanPokedex
//
//  Created by Igor Gomes Arantes on 09/06/20.
//  Copyright © 2020 Igor Gomes Arantes. All rights reserved.
//

import Foundation

final class PokemonAPI: PokemonStore {
    // MARK: Properties
    let baseURL = "https://gist.githubusercontent.com/IgorGomesArantes"
    
    // MARK: Store methods
    func getPokemons(completion: @escaping (Result<[Pokemon], Error>) -> Void) {
        let path = "b2b9bed333c52e5148fe2d25131e8d22/raw/b7cc9d4f4f6822017ff93777a0cde5c4dad81461/pokedex.json"
        HTTPService.getData(url:  URL(string: "\(baseURL)/\(path)")!) { (result) in
            completion(result)
        }
    }
}
