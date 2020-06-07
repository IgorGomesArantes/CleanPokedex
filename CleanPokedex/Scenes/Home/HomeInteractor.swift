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
    func fetchPokemons()
}

final class HomeInteractor: HomeDataStore {
    // MARK: Properties
    var worker: HomeStore = MockedHomeWorker()//HomeWorker()
    var presenter: HomePresentationLogic?
    
    // MARK: Data store properties
    private(set) var pokemons: [Pokemon] = []
}

// MARK: Business logic methods
extension HomeInteractor: HomeBusinessLogic {
    func fetchPokemons() {
        worker.requestPokemons(completion: requestPokemonsCompletion(result:))
    }
}

// MARK: Private methods
private extension HomeInteractor {
    func requestPokemonsCompletion(result: Result<[Pokemon], Error>) {
        switch result {
        case .success(let pokemons):
            self.pokemons = pokemons
            presenter?.presentFetchedPokemons(response: Home.FetchPokemons.Response(pokemons: pokemons))
        case .failure(let error):
            presenter?.presentFetchPokemonsError(withMessage: error.localizedDescription)
        }
    }
}
