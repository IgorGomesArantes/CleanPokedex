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
    var pokemonWorker: PokemonWorker = PokemonWorker(pokemonStore: PokemonAPI())
    
    // MARK: Data store properties
    private(set) var pokemons: [Pokemon] = []
}

// MARK: Business logic methods
extension HomeInteractor: HomeBusinessLogic {
    func fetchPokemons(_ request: Home.FetchPokemons.Request) {
        pokemonWorker.getPokemons(completion: requestPokemonsCompletion(pokemons:))
    }
}

// MARK: Private methods
private extension HomeInteractor {
    func requestPokemonsCompletion(pokemons: [Pokemon]) {
        self.pokemons = pokemons
        presenter?.presentFetchedPokemons(Home.FetchPokemons.Response(pokemons: pokemons))
    }
}
