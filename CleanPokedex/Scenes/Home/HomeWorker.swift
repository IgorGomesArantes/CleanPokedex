//
//  HomeWorker.swift
//  CleanPokedex
//
//  Created by Igor Gomes Arantes on 03/06/20.
//  Copyright © 2020 Igor Gomes Arantes. All rights reserved.
//

import Foundation

protocol HomeStore {
    func requestPokemons(completion: @escaping (Result<[Pokemon], Error>) -> Void)
}

final class HomeWorker: HomeStore {
    func requestPokemons(completion: @escaping (Result<[Pokemon], Error>) -> Void) {
        let baseURL = "https://gist.githubusercontent.com/IgorGomesArantes"
        let path = "b2b9bed333c52e5148fe2d25131e8d22/raw/b7cc9d4f4f6822017ff93777a0cde5c4dad81461/pokedex.json"
        
        guard let url = URL(string: "\(baseURL)/\(path)") else { return }
        
        HTTPService.getData(url: url) { (result) in
            completion(result)
        }
    }
}

final class MockedHomeWorker: HomeStore {
    // MARK: Store methods
    func requestPokemons(completion: @escaping (Result<[Pokemon], Error>) -> Void) {
        let pokemons = try! JSONDecoder().decode([Pokemon].self, from: MockedHomeWorker.getData(forResource: "mocked_pokemons"))
        completion(.success(pokemons))
    }
    
    // MARK: Private methods
    static func getData(forResource resource: String) -> Data {
        
        let bundle = Bundle(for: self)
        guard let path = bundle.path(forResource: resource, ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
                fatalError("Recurso não encontrado")
        }
        
        return data
    }
}
