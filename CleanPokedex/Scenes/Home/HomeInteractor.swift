//
//  HomeInteractor.swift
//  CleanPokedex
//
//  Created by Igor Gomes Arantes on 03/06/20.
//  Copyright © 2020 Igor Gomes Arantes. All rights reserved.
//

import Foundation

protocol HomeDataStore {
    var pokemons: [Pokemon] { get }
}

protocol HomeBusinessLogic {
    func fetchPokemons(_ request: Home.FetchPokemons.Request)
}

final class HomeInteractor: HomeDataStore {
    // MARK: Properties
    var presenter: HomePresentationLogic?
    var worker: PokemonStore = PokemonWorker()
    
    // MARK: Data store properties
    private(set) var pokemons: [Pokemon] = []
}

// MARK: Business logic methods
extension HomeInteractor: HomeBusinessLogic {
    func fetchPokemons(_ request: Home.FetchPokemons.Request) {
        worker.requestPokemons(completion: requestPokemonsCompletion(result:))
    }
}

// MARK: Private methods
private extension HomeInteractor {
    func requestPokemonsCompletion(result: Result<[Pokemon], Error>) {
        switch result {
        case .success(let pokemons):
            self.pokemons = pokemons
            presenter?.presentFetchedPokemons(Home.FetchPokemons.Response(result: .success(pokemons)))
        case .failure(let error):
            presenter?.presentFetchedPokemons(Home.FetchPokemons.Response(result: .failure(error)))
        }
    }
}
