//
//  PokemonMockedJson.swift
//  CleanPokedex
//
//  Created by Igor Gomes Arantes on 09/06/20.
//  Copyright © 2020 Igor Gomes Arantes. All rights reserved.
//

import Foundation

final class PokemonMockedJson: PokemonStore {
    func getPokemons(completion: @escaping (Result<[Pokemon], Error>) -> Void) {
        let pokemons = try! JSONDecoder().decode([Pokemon].self, from: MockDataHelper.getData(forResource: .pokemons))
        completion(.success(pokemons))
    }
}
