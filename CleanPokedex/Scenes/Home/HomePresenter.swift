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
    weak var viewController: HomeViewController?
}

// MARK: Presentation logic methods
extension HomePresenter: HomePresentationLogic {
    func presentFetchedPokemons(response: Home.FetchPokemons.Response) {
        viewController?.displayFetchedPokemons(displayedPokemons: getDisplayedPokemons(response))
    }
    
    func presentFetchPokemonsError(withMessage message: String) {
        viewController?.displayFetchPokemonsError(displayedMessage: message)
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
    
    func getDisplayedPokemons(_ response: Home.FetchPokemons.Response) -> [Home.FetchPokemons.ViewModel.DisplayedPokemon] {
        return response.pokemons.map { getDisplayedPokemon(pokemon: $0) }
    }
}
