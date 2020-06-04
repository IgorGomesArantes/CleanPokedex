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
        let displayedPokemons = response.pokemons.map { Home.FetchPokemons.ViewModel.DisplayedPokemon(name: $0.name) }
        viewController?.displayFetchedPokemons(displayedPokemons: displayedPokemons)
    }
    
    func presentFetchPokemonsError(withMessage message: String) {
        viewController?.displayFetchPokemonsError(displayedMessage: message)
    }
}
