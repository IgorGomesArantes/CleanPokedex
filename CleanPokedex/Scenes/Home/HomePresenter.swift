//
//  HomePresenter.swift
//  CleanPokedex
//
//  Created by Igor Gomes Arantes on 03/06/20.
//  Copyright © 2020 Igor Gomes Arantes. All rights reserved.
//

import Foundation

protocol HomePresentationLogic {
    func presentFetchedPokemons(_ response: Home.FetchPokemons.Response)
}

final class HomePresenter {
    // MARK: Properties
    weak var viewController: HomeDisplayLogic?
}

// MARK: Presentation logic methods
extension HomePresenter: HomePresentationLogic {
    func presentFetchedPokemons(_ response: Home.FetchPokemons.Response) {
        switch response {
        case .success(let pokemons):
            viewController?.displayFetchedPokemons(.success(getDisplayedPokemons(pokemons)))
        case .failure(let error):
            viewController?.displayFetchedPokemons(.failure(getFetchPokemonsErrorViewModel(error)))
        }
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
    
    func getFetchPokemonsErrorViewModel(_ error: Error) -> Home.FetchPokemons.ViewModel.DisplayedError {
        let title = "Erro ao buscar os Pokemons."
        let buttonTitle = "Tentar novamente"
        return Home.FetchPokemons.ViewModel.DisplayedError(title: title, message: error.localizedDescription, buttonTitle: buttonTitle)
    }
}
