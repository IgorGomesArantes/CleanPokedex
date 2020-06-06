//
//  HomePresenter.swift
//  CleanPokedex
//
//  Created by Igor Gomes Arantes on 03/06/20.
//  Copyright © 2020 Igor Gomes Arantes. All rights reserved.
//

import Foundation

protocol HomePresentationLogic {
    func presentFetchedPokemons(response: Home.FetchPokemons.Response)
    func presentFetchPokemonsError(withMessage message: String)
}

final class HomePresenter {
    // MARK: Properties
    weak var viewController: HomeDisplayLogic?
}

// MARK: Presentation logic methods
extension HomePresenter: HomePresentationLogic {
    func presentFetchedPokemons(response: Home.FetchPokemons.Response) {
        viewController?.displayFetchedPokemons(Home.FetchPokemons.ViewModel(displayedPokemons: getDisplayedPokemons(response.pokemons)))
    }
    
    func presentFetchPokemonsError(withMessage message: String) {
        viewController?.displayFetchPokemonsError(Home.FetchPokemons.Error(message: message))
    }
}

// MARK: Private methods
private extension HomePresenter {
    func getDisplayedPokemon(pokemon: Pokemon) -> Home.FetchPokemons.ViewModel.DisplayedPokemon {
        return Home.FetchPokemons.ViewModel.DisplayedPokemon(name: pokemon.name,
                                                             code: pokemon.code,
                                                             imageURL: pokemon.imageURL,
                                                             types: pokemon.types,
                                                             mainType: pokemon.types.first!)
    }
    
    func getDisplayedPokemons(_ pokemons: [Pokemon]) -> [Home.FetchPokemons.ViewModel.DisplayedPokemon] {
        return pokemons.map { getDisplayedPokemon(pokemon: $0) }
    }
}
